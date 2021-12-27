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
          nameChanged: (e) async {
            final AppList updatedList = state.appList.copyWith(name: e.newName);

            // TODO handle error
            final res = await appListsRepository.update(updatedList);

            emit(
              state.copyWith(
                appList: updatedList,
                isNewItemAdded: false,
              ),
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
          finishedEditingItem: (e) async {
            if (state.didJustDelete) {
              // Do nothing in this case....
              // This is how I dealt with the hack mentioned in AppListFormState
              emit(state.copyWith(
                didJustDelete: false,
              ));
              return;
            }

            final AppList updatedList = state.appList.copyWithUpdatedItemtitle(e.newTitle, e.index);

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
              didJustDelete: true,
            ));
          },
        );
      },
      transformer: sequential(), // TODO: This is also part of the hack!!
    );
  }
}
