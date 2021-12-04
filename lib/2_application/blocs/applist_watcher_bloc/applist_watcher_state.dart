part of 'applist_watcher_bloc.dart';

@freezed
class AppListWatcherState with _$AppListWatcherState {
  // Initial
  const factory AppListWatcherState.initial() = _$Initial;
  // Loading
  const factory AppListWatcherState.loadingLists() = _$loading;
  const factory AppListWatcherState.loadedSuccessfully(List<AppList> appLists) =
      _$loadedSuccessfully;
  const factory AppListWatcherState.loadFailed() = _$loadFailed;
  // Saving
  const factory AppListWatcherState.savingNewList() = _$savingNewList;
  const factory AppListWatcherState.newListSavedSuccessfully() =
      _$newListSavedSuccessfully;
  const factory AppListWatcherState.newListSavedError() = _$newListSavedError;
  // Deleting
  const factory AppListWatcherState.deletingList() = _$deletingList;
  const factory AppListWatcherState.deletedListSuccessfully() =
      _$deletedListSuccessfully;
  const factory AppListWatcherState.deleteListError() = _$deleteListError;
}
