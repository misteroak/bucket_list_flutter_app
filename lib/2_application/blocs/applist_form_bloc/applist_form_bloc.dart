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

  AppListFormBloc(this.appListsRepository) : super(AppListFormState.initial()) {
    on<AppListFormEvent>(
      (event, emit) async {
        // await event.map(
        //   // started
        //   started: (_) {},
        //   // saveAppList
        //   saveAppList: (event) async {
        //     emit(const AppListFormState.saving());
        //     final res = await appListsRepository.writeList(event.appList);
        //     emit(res
        //         ? const AppListFormState.savedSuccessfully()
        //         : const AppListFormState.saveFailed());
        //   },
        // );

        await event.map(
          initialized: (_) {},
          nameChanged: (e) {
            emit(state.copyWith(appList: state.appList.copyWith(name: e.name)));
          },
          itemsChanged: (e) {
            emit(state.copyWith(
                appList: state.appList.copyWith(items: e.items)));
          },
          saved: (_) async {
            emit(state.copyWith(isSaving: true));
            final res = await appListsRepository.writeList(state.appList);
            emit(state.copyWith(
              isSaving: false,
              saveError: res,
            ));
          },
        );
      },
    );
  }
}
