part of 'applist_form_bloc.dart';

@freezed
class AppListFormState with _$AppListFormState {
  const AppListFormState._();

  const factory AppListFormState({
    required AppList appList,
    required bool isNewItemAdded,
    required bool isSaving,
    bool? saveError,
  }) = _AppListFormState;

  factory AppListFormState.initial() => AppListFormState(
        appList: AppList.empty(),
        isNewItemAdded: false,
        isSaving: false,
      );

  @override
  String toString() {
    return appList.items.length.toString();
  }
}
