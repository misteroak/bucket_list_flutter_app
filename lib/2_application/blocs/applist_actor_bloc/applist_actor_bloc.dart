import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../1_presentation/common/app_strings.dart' as constants;
import '../../../3_domain/core/unique_id.dart';
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
        updateListsIndex: (e) async {
          final listOrFailure = await _appListsRepository.updateListsIndex(e.lists);

          listOrFailure.fold(
            (f) => emit(const AppListActorState.updateListsIndexError()),
            (r) => null, // do nothing, list watcher block will act on this
          );
        },
        getList: (e) async {
          final listOrFailure = await _appListsRepository.getList(e.appListId);

          listOrFailure.fold(
            (f) => emit(const AppListActorState.getListError()),
            (r) => emit(AppListActorState.getListSuccess(r)),
          );
        },
        createNewList: (e) async {
          final newList = AppList.empty().copyWith(name: e.listName ?? constants.defaultNewListName);
          final res = await _appListsRepository.create(newList, e.orderIndex);

          res.fold(
            (failure) => emit(const AppListActorState.newListCreatedError()),
            (r) => emit(AppListActorState.newListCreatedSuccessfully(newList)),
          );
        },
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
