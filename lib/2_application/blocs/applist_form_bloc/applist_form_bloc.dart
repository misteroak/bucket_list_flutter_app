import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../3_domain/entities.dart';

part 'applist_form_bloc.freezed.dart';
part 'applist_form_bloc_event.dart';
part 'applist_form_bloc_state.dart';

@injectable
class AppListFormBloc extends Bloc<AppListFormEvent, AppListFormState> {
  final IAppListsRepository appListsRepository;

  AppListFormBloc(
    this.appListsRepository,
  ) : super(AppListFormState.initial()) {
    on<AppListFormEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) {
            emit(
              state.copyWith(
                appList: e.initialList,
                isEditig: true,
                isDirty: false,
              ),
            ); // Edited list (from event)
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
                appList: state.appList.copyAndAddNewItem(),
                isDirty: true,
              ),
            );
          },
          listItemDeleted: (e) {
            emit(
              state.copyWith(
                  appList: state.appList.copyAndRemoveItemAtIndex(e.index),
                  isDirty: true),
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

            emit(
              state.copyWith(
                isSaving: false,
                saveError: res.isLeft(),
                isDirty: res.isLeft(),
              ),
            );
          },
        );
      },
    );
  }
}
