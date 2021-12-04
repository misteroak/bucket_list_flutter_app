part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherEvent with _$AppListWatcherEvent {
  const factory AppListWatcherEvent.loadLists() = _loadLists;
  const factory AppListWatcherEvent.createNewList(AppList appList) =
      _createNewList;
  const factory AppListWatcherEvent.deleteList(AppList appList) = _deleteList;
}
