part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherEvent with _$AppListWatcherEvent {
  const factory AppListWatcherEvent.loadList() = _loadList;
  const factory AppListWatcherEvent.listLoaded(AppList appList) = _listLoaded;
}
