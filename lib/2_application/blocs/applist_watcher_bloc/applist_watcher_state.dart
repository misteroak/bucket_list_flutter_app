part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherState with _$AppListWatcherState {
  const factory AppListWatcherState.initial() = _$Initial;
  const factory AppListWatcherState.loadingList() = _$loadingList;
  const factory AppListWatcherState.loadedListSuccessfully(AppList appList) =
      _$loadedListSuccessfully;
  const factory AppListWatcherState.loadListFailed() = _$loadListFailed;
}
