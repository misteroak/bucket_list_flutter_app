part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherEvent with _$AppListWatcherEvent {
  const factory AppListWatcherEvent.watchLists() = _watchLists;
}
