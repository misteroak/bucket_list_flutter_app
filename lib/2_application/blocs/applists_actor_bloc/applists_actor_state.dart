part of 'applists_actor_bloc.dart';

@freezed
class AppListsActorState with _$AppListsActorState {
  const factory AppListsActorState.initial() = _Initial;

  const factory AppListsActorState.updateListsIndicesFailed() = _$updateListsIndicesFailed;
  const factory AppListsActorState.getListSuccess(AppList appList) = _$getListSuccess;
  const factory AppListsActorState.getListFailed() = _$getListFailed;
  const factory AppListsActorState.createListSuccess(AppList newAppList) = _$createListSuccesss;
  const factory AppListsActorState.createListFailed() = _$createListFailed;
  const factory AppListsActorState.deleteListError() = _$deleteListError;
}
