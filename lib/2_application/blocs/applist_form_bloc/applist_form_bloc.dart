import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
          listNameChanged: (e) async {
            final AppList updatedList = state.appList.copyWith(name: e.newName);

            final res = await appListsRepository.update(updatedList);
            res.fold(
              (f) => emit(state.copyWith(saveError: true)),
              (r) => emit(state.copyWith(appList: updatedList, isNewItemAdded: false)),
            );
          },
          listItemAdded: (_) {
            emit(
              state.copyWith(
                appList: state.appList.copyAndAddNewItem(),
                isNewItemAdded: true,
              ),
            );
          },
          listItemUpdated: (e) async {
            final AppList updatedList = state.appList.copyWithUpdatedItemtitle(e.newTitle, e.index);

            final res = await appListsRepository.update(updatedList);
            res.fold(
              (f) => emit(state.copyWith(saveError: true)),
              (r) => emit(state.copyWith(appList: updatedList, isNewItemAdded: false)),
            );
          },
          listItemDeleted: (e) async {
            final updatedList = state.appList.copyAndRemoveItemAtIndex(e.index);

            final res = await appListsRepository.update(updatedList);
            res.fold(
              (f) => emit(state.copyWith(saveError: true)),
              (r) => emit(state.copyWith(appList: updatedList, isNewItemAdded: false)),
            );
          },
        );
      },
      transformer: sequential(), // NOTE: This is also part of the hack!!
    );
  }
}
