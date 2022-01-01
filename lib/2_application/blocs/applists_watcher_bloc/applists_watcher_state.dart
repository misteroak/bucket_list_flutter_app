part of 'applists_watcher_bloc.dart';

@freezed
class AppListsWatcherState with _$AppListsWatcherState {
  const factory AppListsWatcherState.initial() = _$Initial;

  const factory AppListsWatcherState.watchingLists() = _$watchingLists;
  const factory AppListsWatcherState.watchListsSuccess(List<AppList> appLists) = _$watchListsSuccess;
  const factory AppListsWatcherState.watchListsFailed({String? message}) = _$watchListsFailed;
}
