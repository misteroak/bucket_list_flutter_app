import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

import '../../../3_domain/applist/applist_entity.dart';
import '../../../3_domain/entities.dart';

part 'applist_actor_bloc.freezed.dart';
part 'applist_actor_event.dart';
part 'applist_actor_state.dart';

@injectable
class AppListActorBloc extends Bloc<AppListActorEvent, AppListActorState> {
  final IAppListsRepository _appListsRepository;

  AppListActorBloc(this._appListsRepository)
      : super(const AppListActorState.initial()) {
    on<AppListActorEvent>((event, emit) async {
      await event.map(
        // Get List
        getList: (e) async {
          print('blox is getting list id ${e.appListId}');
          final listOrFailure = await _appListsRepository.getList(e.appListId);

          listOrFailure.fold(
            (f) => emit(const AppListActorState.getListError()),
            (r) {
              print('bloc got $r');
              emit(AppListActorState.getListSuccess(r));
            },
          );
        },

        // Create New List
        createNewList: (e) async {
          emit(const AppListActorState.creatingNewList());
          final newList = AppList.empty().copyWith(name: e.listName);
          final res = await _appListsRepository.create(newList);

          res.fold(
            // TODO - listen to this state when creating a new list
            (_) => emit(const AppListActorState.newListCreatedError()),
            (r) => emit(AppListActorState.newListCreatedSuccessfully(newList)),
          );
        },
        // Delete List
        deleteList: (e) async {
          emit(const AppListActorState.deletingList());

          //TODO: !! Implement me

          // final res = await _appListsRepository.delete(e.appList);
          // if (!res) {
          //   emit(const AppListWatcherState.deleteListError());
          // }
          // else {
          //   add(const AppListWatcherEvent.loadLists());
          // }
        },
      );
    });
  }
}
