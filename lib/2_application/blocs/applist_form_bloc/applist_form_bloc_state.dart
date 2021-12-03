part of 'applist_form_bloc.dart';

@freezed
class AppListFormState with _$AppListFormState {
  const factory AppListFormState({
    required AppList appList,
    required bool isSaving,
    required bool isDirty,
    bool? saveError,
  }) = _AppListFormState;

  factory AppListFormState.initial() => AppListFormState(
        appList: AppList.empty(),
        isSaving: false,
        isDirty: false,
      );
}
