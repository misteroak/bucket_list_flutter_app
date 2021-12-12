part of 'applist_actor_bloc.dart';

@freezed
class AppListActorState with _$AppListActorState {
  const factory AppListActorState.initial() = _Initial;

  // Read
  const factory AppListActorState.getListSuccess(AppList appList) =
      _$getListSuccess;
  const factory AppListActorState.getListError() = _$getListError;

  // Create
  const factory AppListActorState.newListCreatedError() = _$newListCreatedError;

  // Deleting
  // TODO - listen to this state
  const factory AppListActorState.deleteListError() = _$deleteListError;
}
