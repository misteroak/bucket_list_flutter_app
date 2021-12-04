import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';
import 'package:photo_app/3_domain/entities.dart';

part 'applist_watcher_bloc.freezed.dart';
part 'applist_watcher_event.dart';
part 'applist_watcher_state.dart';

@injectable
class AppListWatcherBloc
    extends Bloc<AppListWatcherEvent, AppListWatcherState> {
  final IAppListsRepository appListsRepository;

  AppListWatcherBloc(this.appListsRepository)
      : super(const AppListWatcherState.initial()) {
    on<AppListWatcherEvent>(
      (event, emit) async {
        await event.map(
          // Load Lists
          loadLists: (e) async {
            emit(const AppListWatcherState.loadingLists());
            final appLists = await appListsRepository.loadLists();
            emit(
              appLists == null
                  ? const AppListWatcherState.loadFailed()
                  : AppListWatcherState.loadedSuccessfully(appLists),
            );
          },
          // Create New List
          createNewList: (e) async {
            emit(const AppListWatcherState.savingNewList());
            final res = await appListsRepository.create(e.appList);
            if (!res) {
              // TODO - listen to this state when creating a new list
              emit(const AppListWatcherState.newListSavedError());
            } else {
              add(const AppListWatcherEvent.loadLists());
            }
          },
        );
      },
    );
  }
}
