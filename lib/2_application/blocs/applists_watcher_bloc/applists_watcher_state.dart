part of 'applists_watcher_bloc.dart';

@freezed
class AppListsWatcherState with _$AppListsWatcherState {
  const factory AppListsWatcherState.initial() = _$Initial;
  const factory AppListsWatcherState.loadingLists() = _$loading;
  const factory AppListsWatcherState.loadedSuccessfully(List<AppList> appLists) = _$loadedSuccessfully;
  const factory AppListsWatcherState.loadFailed() = _$loadFailed;
}
