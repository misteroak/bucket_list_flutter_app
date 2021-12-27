part of 'applist_form_bloc.dart';

@freezed
class AppListFormState with _$AppListFormState {
  const AppListFormState._();

  const factory AppListFormState({
    required AppList appList,
    required bool isNewItemAdded,
    required bool isSaving,
    required bool
        didJustDelete, // TODO: This is a major hack that was added to solve a problem when you delete an item while another item has the focus. The problem is that hitting the delete button generates 2 events: 1) The select item to be deleted, then 2) The item that had to focus is then updating (remember - I wanted items to autosave on focus loss). So to deal with this I added this bool to the state and made the bloc sequential (see applist_form_bloc transformer).
    bool? saveError,
  }) = _AppListFormState;

  factory AppListFormState.initial() => AppListFormState(
        appList: AppList.empty(),
        isNewItemAdded: false,
        isSaving: false,
        didJustDelete: false,
      );

  @override
  String toString() {
    return appList.items.length.toString();
  }
}
