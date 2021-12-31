part of 'applist_actor_bloc.dart';

@freezed
class AppListActorEvent with _$AppListActorEvent {
  /// Expects [lists] order to match the order in the UI. In the future if there is a more complex UI layout (e.g., nesting, we'll need to pass another paramter to capture it)
  const factory AppListActorEvent.updateListsIndex(List<AppList> lists) = _updateListsIndex;
  const factory AppListActorEvent.getList(UniqueId appListId) = _getList;
  const factory AppListActorEvent.createNewList(int orderIndex, {String? listName}) = _createNewList;
  const factory AppListActorEvent.deleteList(AppList appList) = _deleteList;
}
