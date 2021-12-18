import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/1_presentation/constants.dart' as constants;
import 'package:photo_app/3_domain/core/unique_id.dart';

import '../../../3_domain/entities.dart';

part 'applist_actor_bloc.freezed.dart';
part 'applist_actor_event.dart';
part 'applist_actor_state.dart';

@injectable
class AppListActorBloc extends Bloc<AppListActorEvent, AppListActorState> {
  final IAppListsRepository _appListsRepository;

  AppListActorBloc(this._appListsRepository) : super(const AppListActorState.initial()) {
    on<AppListActorEvent>((event, emit) async {
      await event.map(
        // Get List
        getList: (e) async {
          final listOrFailure = await _appListsRepository.getList(e.appListId);

          listOrFailure.fold(
              // TODO: Listen to this state
              (f) => emit(const AppListActorState.getListError()),
              (r) => emit(AppListActorState.getListSuccess(r)));
        },

        // Create New List
        createNewList: (e) async {
          final newList = AppList.empty().copyWith(name: e.listName ?? constants.defaultNewListName);
          final res = await _appListsRepository.create(newList);

          res.fold(
            // TODO - listen to this state
            (failure) => emit(const AppListActorState.newListCreatedError()),
            (r) {},
          );
        },
        // Delete List
        deleteList: (e) async {
          final res = await _appListsRepository.delete(e.appList.id);
          res.fold(
            (failure) => emit(const AppListActorState.deleteListError()),
            (_) {},
          );
        },
      );
    });
  }
}
