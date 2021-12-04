import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/entities.dart';

part 'applist_watcher_bloc.freezed.dart';
part 'applist_watcher_event.dart';
part 'applist_watcher_state.dart';

@injectable
class AppListWatcherBloc
    extends Bloc<AppListWatcherEvent, AppListWatcherState> {
  final IAppListsRepository _appListsRepository;

  StreamSubscription<List<AppList>>? _listsStreamSubscription;

  AppListWatcherBloc(this._appListsRepository)
      : super(const AppListWatcherState.initial()) {
    on<AppListWatcherEvent>(
      (event, emit) async {
        await event.map(
          // Load Lists
          watchLists: (e) async {
            emit(const AppListWatcherState.loadingLists());
            await _listsStreamSubscription?.cancel();
            _listsStreamSubscription = _appListsRepository.watchLists().listen(
                  (e) => add(
                    AppListWatcherEvent.listsReceived(e),
                  ),
                );
            // emit(
            //   appLists == null
            //       ? const AppListWatcherState.loadFailed()
            //       : AppListWatcherState.loadedSuccessfully(appLists),
            // );
          },
          listsReceived: (e) {
            //TODO - Error handling???
            emit(AppListWatcherState.loadedSuccessfully(e.lists));
          },
          // Create New List
          createNewList: (e) async {
            emit(const AppListWatcherState.savingNewList());
            final res = await _appListsRepository.create(e.appList);
            if (!res) {
              // TODO - listen to this state when creating a new list
              emit(const AppListWatcherState.newListSavedError());
            }
            // else {
            //   add(const AppListWatcherEvent.loadLists());
            // }
          },
          // Delete List
          deleteList: (e) async {
            emit(const AppListWatcherState.deletingList());
            final res = await _appListsRepository.delete(e.appList);
            if (!res) {
              // TODO - listen to this state when creating a new list
              emit(const AppListWatcherState.deleteListError());
            }
            // else {
            //   add(const AppListWatcherEvent.loadLists());
            // }
          },
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _listsStreamSubscription?.cancel();
    return super.close();
  }
}
