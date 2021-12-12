part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherState with _$AppListWatcherState {
// TODO: Check all states are used

  // Initial
  const factory AppListWatcherState.initial() = _$Initial;
  // Loading
  const factory AppListWatcherState.loadingLists() = _$loading;
  const factory AppListWatcherState.loadedSuccessfully(List<AppList> appLists) =
      _$loadedSuccessfully;
  const factory AppListWatcherState.loadFailed() = _$loadFailed;
}
