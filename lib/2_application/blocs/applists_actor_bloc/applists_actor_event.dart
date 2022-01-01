part of 'applists_actor_bloc.dart';

@freezed
class AppListsActorEvent with _$AppListsActorEvent {
  /// Expects [lists] order to match the order in the UI. In the future if there is a more complex UI layout (e.g., nesting, we'll need to pass another paramter to capture it)
  const factory AppListsActorEvent.updateListsIndices(List<AppList> lists) = _updateListsIndices;
  const factory AppListsActorEvent.getList(UniqueId appListId) = _getList;
  const factory AppListsActorEvent.createList(int orderIndex, {String? listName}) = _createList;
  const factory AppListsActorEvent.deleteList(AppList appList) = _deleteList;
}
