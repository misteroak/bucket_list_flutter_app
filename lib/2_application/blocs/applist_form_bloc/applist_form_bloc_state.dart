part of 'applist_form_bloc.dart';

@freezed
class AppListFormState with _$AppListFormState {
  const factory AppListFormState.initial() = _Initial;
  const factory AppListFormState.saving() = _Saving;
  const factory AppListFormState.savedSuccessfully() = _SavedSuccessfully;
  const factory AppListFormState.saveFailed() = _SavedFailed;
  const factory AppListFormState.listLoadedSuccessfully(AppList list) =
      _LoadedSuccessfully;
  const factory AppListFormState.listLoadFailed() = _LoadFailed;
}
