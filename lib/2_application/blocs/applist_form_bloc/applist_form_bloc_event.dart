part of 'applist_form_bloc.dart';

@freezed
class AppListFormEvent with _$AppListFormEvent {
  const factory AppListFormEvent.initialized(AppList initialList) =
      _Initialized;
  const factory AppListFormEvent.nameChanged(String name) = _NameChanged;

  const factory AppListFormEvent.listItemTitleChanged(
      String newTitle, int index) = _ItemTitleChanged;
  const factory AppListFormEvent.listItemAdded() = _ItemAdded;
  const factory AppListFormEvent.listItemDeleted(int index) = _ItemDeleted;
  const factory AppListFormEvent.listSaved() = _Saved;
}
