import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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
    on<AppListWatcherEvent>((event, emit) async {
      await event.map(
        loadList: (_) async {
          emit(const AppListWatcherState.loadingList());
          // Try to get list from repository
          final appList = await appListsRepository.getList();

          // List load failed
          if (appList == null) {
            emit(const AppListWatcherState.loadListFailed());
            // List load succeeded
          } else {
            add(AppListWatcherEvent.listLoaded(appList));
          }
        },
        listLoaded: (event) async =>
            emit(AppListWatcherState.loadedListSuccessfully(event.appList)),
      );
    });
  }
}
