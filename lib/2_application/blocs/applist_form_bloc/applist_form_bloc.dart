import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../3_domain/entities.dart';

part 'applist_form_bloc.freezed.dart';
part 'applist_form_bloc_event.dart';
part 'applist_form_bloc_state.dart';

@injectable
class AppListFormBloc extends Bloc<AppListFormEvent, AppListFormState> {
  final logger = Logger();

  final IAppListsRepository appListsRepository;

  AppListFormBloc(this.appListsRepository) : super(const _Initial()) {
    on<AppListFormEvent>((event, emit) async {
      await event.map(
        // started
        started: (_) {},
        // saveAppList
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
