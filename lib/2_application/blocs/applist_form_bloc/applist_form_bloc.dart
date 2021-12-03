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

  AppListFormBloc(this.appListsRepository) : super(AppListFormState.initial()) {
    on<AppListFormEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) {
            if (e.initialList == null) return; // New list
            emit(state.copyWith(
                appList: e.initialList!,
                isDirty: false)); // Edited list (from event)
          },
          nameChanged: (e) {
            emit(
              state.copyWith(
                appList: state.appList.copyWith(name: e.name),
                isDirty: true,
              ),
            );
          },
          itemAdded: (_) {
            emit(
              state.copyWith(
                appList: state.appList.copyAndAddEmptyItem(),
                isDirty: true,
              ),
            );
          },
          itemDeleted: (e) {
            emit(
              state.copyWith(
                  appList: state.appList.copyAndRemoveItemAtIndex(e.index),
                  isDirty: false),
            );
          },
          itemTitleChanged: (e) {
            emit(
              state.copyWith(
                appList:
                    state.appList.copyWithUpdatedItemtitle(e.newTitle, e.index),
                isDirty: false,
              ),
            );
          },
          // itemsChanged: (e) {
          //   emit(
          //     state.copyWith(
          //       appList: state.appList.copyWith(items: e.items),
          //       isDirty: false,
          //     ),
          //   );
          // },
          saved: (_) async {
            emit(state.copyWith(isSaving: true));
            final res = await appListsRepository.writeList(state.appList);
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
