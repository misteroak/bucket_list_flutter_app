part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherState with _$AppListWatcherState {
  const factory AppListWatcherState.initial() = _$Initial;
  const factory AppListWatcherState.loadingLists() = _$loading;
  const factory AppListWatcherState.loadedSuccessfully(List<AppList> appLists) =
      _$loadedSuccessfully;
  const factory AppListWatcherState.loadFailed() = _$loadFailed;
  const factory AppListWatcherState.savingNewList() = _$savingNewList;
  const factory AppListWatcherState.newListSavedSuccessfully() =
      _$newListSavedSuccessfully;
  const factory AppListWatcherState.newListSavedError() = _$newListSavedError;
}
