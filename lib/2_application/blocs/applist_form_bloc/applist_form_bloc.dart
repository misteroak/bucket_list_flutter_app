import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../3_domain/entities.dart';

part 'applist_form_bloc.freezed.dart';
part 'applist_form_bloc_event.dart';
part 'applist_form_bloc_state.dart';

@injectable
class AppListFormBloc extends Bloc<AppListFormEvent, AppListFormState> {
  final IAppListsRepository appListsRepository;

  AppListFormBloc(this.appListsRepository) : super(const _Initial()) {
    on<AppListFormEvent>((event, emit) async {
      await event.map(
        started: (_) {
          // add(const AppListFormEvent.loadList());
        },
        // loadList: (_) async {
        //   final AppList? list = await appListsRepository.getList();
        //   emit(list == null
        //       ? const AppListFormState.listLoadFailed()
        //       : AppListFormState.listLoadedSuccessfully(list));
        // },
        saveAppList: (event) async {
          emit(const AppListFormState.saving());
          final res = await appListsRepository.writeList(event.appList);
          emit(res
              ? const AppListFormState.savedSuccessfully()
              : const AppListFormState.saveFailed());
        },
      );
    });
  }
}
