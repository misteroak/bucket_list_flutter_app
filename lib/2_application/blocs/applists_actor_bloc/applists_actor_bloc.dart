import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../1_presentation/common/app_strings.dart' as constants;
import '../../../3_domain/core/unique_id.dart';
import '../../../3_domain/entities.dart';

part 'applists_actor_bloc.freezed.dart';
part 'applists_actor_event.dart';
part 'applists_actor_state.dart';

@injectable
class AppListsActorBloc extends Bloc<AppListsActorEvent, AppListsActorState> {
  final IAppListsRepository _appListsRepository;

  AppListsActorBloc(this._appListsRepository) : super(const AppListsActorState.initial()) {
    on<AppListsActorEvent>((event, emit) async {
      await event.map(
        updateListsIndices: (e) async {
          final listOrFailure = await _appListsRepository.updateListsIndex(e.lists);

          listOrFailure.fold(
            (f) => emit(const AppListsActorState.updateListsIndicesFailed()),
            (r) => null, // do nothing, list watcher block will act on this
          );
        },
        getList: (e) async {
          final listOrFailure = await _appListsRepository.getList(e.appListId);

          listOrFailure.fold(
            (f) => emit(const AppListsActorState.getListFailed()),
            (r) => emit(AppListsActorState.getListSuccess(r)),
          );
        },
        createList: (e) async {
          final newList = AppList.empty().copyWith(name: e.listName ?? constants.defaultNewListName);
          final res = await _appListsRepository.create(newList, e.orderIndex);

          res.fold(
            (failure) => emit(const AppListsActorState.createListFailed()),
            (r) {
              emit(AppListsActorState.createListSuccess(newList));
            },
          );
        },
        deleteList: (e) async {
          final res = await _appListsRepository.delete(e.appList.id);
          res.fold(
            (failure) => emit(const AppListsActorState.deleteListError()),
            (_) {},
          );
        },
      );
    });
  }
}
