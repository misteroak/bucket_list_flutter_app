import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../3_domain/applist/applist_failure.dart';
import '../../../3_domain/entities.dart';

part 'applist_watcher_bloc.freezed.dart';
part 'applist_watcher_event.dart';
part 'applist_watcher_state.dart';

@injectable
class AppListWatcherBloc extends Bloc<AppListWatcherEvent, AppListWatcherState> {
  final IAppListsRepository _appListsRepository;

  AppListWatcherBloc(this._appListsRepository) : super(const AppListWatcherState.initial()) {
    on<AppListWatcherEvent>((event, emit) async {
      await event.map(
        // Load Lists
        watchLists: (e) async {
          emit(const AppListWatcherState.loadingLists());

          // See: https://github.com/felangel/bloc/issues/2784#issuecomment-963549466
          await emit.forEach(
            _appListsRepository.watchListsIndex(),
            onData: (Either<AppListFailure, List<AppList>> e) => e.fold(
              (_) => const AppListWatcherState.loadFailed(),
              (list) => AppListWatcherState.loadedSuccessfully(list),
            ),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    // await _listsStreamSubscription?.cancel();
    return super.close();
  }
}
