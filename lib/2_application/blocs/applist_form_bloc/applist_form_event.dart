part of 'applist_form_bloc.dart';

@freezed
class AppListFormEvent with _$AppListFormEvent {
  const factory AppListFormEvent.initialized(AppList initialList) = _Initialized;
  const factory AppListFormEvent.nameChanged(String newName) = _NameChanged;
  const factory AppListFormEvent.finishedEditingItem(int index, String newTitle) = _FinishedEditingItem;
  const factory AppListFormEvent.listItemAdded() = _ItemAdded;
  const factory AppListFormEvent.listItemDeleted(int index) = _ItemDeleted;
}
