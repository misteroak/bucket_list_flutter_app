import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../3_domain/entities.dart';

part 'applist_form_bloc.freezed.dart';
part 'applist_form_event.dart';
part 'applist_form_state.dart';

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
              ),
            );
          },
          nameChanged: (e) {
            emit(
              state.copyWith(
                appList: state.appList.copyWith(name: e.name),
                isNewItemAdded: false,
                isDirty: true,
              ),
            );
          },
          listItemAdded: (_) {
            emit(
              state.copyWith(
                appList: state.appList.copyAndAddNewItem(),
                isNewItemAdded: true,
                isDirty: true,
              ),
            );
          },
          finishedEditingItem: (e) async {
            final AppList updatedList =
                state.appList.copyWithUpdatedItemtitle(e.newTitle, e.index);

            // TODO handle error
            final res = await appListsRepository.update(updatedList);

            emit(state.copyWith(
              appList: updatedList,
              isNewItemAdded: false,
            ));
          },
          listItemDeleted: (e) async {
            final updatedList = state.appList.copyAndRemoveItemAtIndex(e.index);

            // TODO handle error
            final res = await appListsRepository.update(updatedList);

            emit(state.copyWith(
              appList: updatedList,
              isNewItemAdded: false,
              isDirty: true,
            ));
          },
        );
      },
    );
  }
}
