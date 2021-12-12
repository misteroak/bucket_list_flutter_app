part of 'applist_actor_bloc.dart';

@freezed
class AppListActorEvent with _$AppListActorEvent {
  const factory AppListActorEvent.getList(UniqueId appListId) = _getList;

  const factory AppListActorEvent.createNewList(String listName) =
      _createNewList;
  const factory AppListActorEvent.deleteList(AppList appList) = _deleteList;
}
