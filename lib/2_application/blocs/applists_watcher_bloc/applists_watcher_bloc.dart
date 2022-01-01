import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../3_domain/applist/applist_failure.dart';
import '../../../3_domain/entities.dart';

part 'applists_watcher_bloc.freezed.dart';
part 'applists_watcher_event.dart';
part 'applists_watcher_state.dart';

@injectable
class AppListsWatcherBloc extends Bloc<AppListsWatcherEvent, AppListsWatcherState> {
  final IAppListsRepository _appListsRepository;

  AppListsWatcherBloc(this._appListsRepository) : super(const AppListsWatcherState.initial()) {
    on<AppListsWatcherEvent>(
      (event, emit) async {
        await event.map(
          // Load Lists
          watchLists: (e) async {
            emit(const AppListsWatcherState.watchingLists());

            // See: https://github.com/felangel/bloc/issues/2784#issuecomment-963549466
            await emit.forEach(
              _appListsRepository.watchListsIndex(),
              onData: (Either<AppListFailure, List<AppList>> e) => e.fold(
                (f) => AppListsWatcherState.watchListsFailed(message: f.message),
                (list) => AppListsWatcherState.watchListsSuccess(list),
              ),
            );
          },
        );
      },
    );
  }
}
