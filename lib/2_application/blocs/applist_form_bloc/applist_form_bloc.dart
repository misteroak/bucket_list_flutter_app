import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/2_application/blocs/applist_watcher_bloc/applist_watcher_bloc.dart';

import '../../../3_domain/entities.dart';

part 'applist_form_bloc.freezed.dart';
part 'applist_form_bloc_event.dart';
part 'applist_form_bloc_state.dart';

@injectable
class AppListFormBloc extends Bloc<AppListFormEvent, AppListFormState> {
  // This is ugly. It will be fixed in a later stage once we make our bloc use streams
  final AppListWatcherBloc appListWatcherBloc;

  final IAppListsRepository appListsRepository;

  AppListFormBloc(
    this.appListsRepository,
    this.appListWatcherBloc,
  ) : super(AppListFormState.initial()) {
    on<AppListFormEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) {
            if (e.initialList == null) return; // New list
            emit(state.copyWith(
              appList: e.initialList!,
              isEditig: true,
              isDirty: false,
            )); // Edited list (from event)
          },
          nameChanged: (e) {
            emit(
              state.copyWith(
                appList: state.appList.copyWith(name: e.name),
                isDirty: true,
              ),
            );
          },
          listItemAdded: (_) {
            emit(
              state.copyWith(
                appList: state.appList.copyAndAddEmptyItem(),
                isDirty: true,
              ),
            );
          },
          listItemDeleted: (e) {
            emit(
              state.copyWith(
                  appList: state.appList.copyAndRemoveItemAtIndex(e.index),
                  isDirty: false),
            );
          },
          listItemTitleChanged: (e) {
            emit(
              state.copyWith(
                appList:
                    state.appList.copyWithUpdatedItemtitle(e.newTitle, e.index),
                isDirty: false,
              ),
            );
          },
          listSaved: (_) async {
            emit(state.copyWith(isSaving: true));
            final res = state.isEditig
                ? await appListsRepository.update(state.appList)
                : await appListsRepository.create(state.appList);

            // Notify the watcher bloc it should re-read from storage. This is ugly and
            //  will be fixed once we move the blocs to streams
            appListWatcherBloc.add(const AppListWatcherEvent.loadLists());

            emit(
              state.copyWith(
                isSaving: false,
                saveError: !res,
                isDirty: !res,
              ),
            );
          },
        );
      },
    );
  }
}
