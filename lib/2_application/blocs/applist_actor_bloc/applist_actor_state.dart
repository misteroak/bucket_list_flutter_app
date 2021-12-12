part of 'applist_actor_bloc.dart';

@freezed
class AppListActorState with _$AppListActorState {
  // TODO: Check all states are used
  const factory AppListActorState.initial() = _Initial;

  // Read
  const factory AppListActorState.getList() = _$getList;
  const factory AppListActorState.getListSuccess(AppList appList) =
      _$getListSuccess;
  const factory AppListActorState.getListError() = _$getListError;

  // Create
  const factory AppListActorState.creatingNewList() = _$creatingNewList;
  const factory AppListActorState.newListCreatedSuccessfully(AppList appList) =
      _$newListCreatedSuccessfully;
  const factory AppListActorState.newListCreatedError() = _$newListCreatedError;

  // Deleting
  const factory AppListActorState.deletingList() = _$deletingList;
  const factory AppListActorState.deletedListSuccessfully() =
      _$deletedListSuccessfully;
  const factory AppListActorState.deleteListError() = _$deleteListError;
}
