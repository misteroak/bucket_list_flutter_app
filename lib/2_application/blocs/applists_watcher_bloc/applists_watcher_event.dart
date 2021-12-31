part of 'applists_watcher_bloc.dart';

@freezed
class AppListsWatcherEvent with _$AppListsWatcherEvent {
  const factory AppListsWatcherEvent.watchLists() = _watchLists;
}
