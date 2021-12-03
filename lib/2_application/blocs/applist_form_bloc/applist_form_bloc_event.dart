part of 'applist_form_bloc.dart';

@freezed
class AppListFormEvent with _$AppListFormEvent {
  // const factory AppListFormEvent.started() = _Started;
  // const factory AppListFormEvent.saveAppList(AppList appList) = _SaveAppList;

  const factory AppListFormEvent.initialized(AppList? initialList) =
      _Initialized;
  const factory AppListFormEvent.nameChanged(String name) = _NameChanged;
  // const factory AppListFormEvent.itemsChanged(List<AppListItem> items) =
  //     _ItemsChanged;
  const factory AppListFormEvent.itemTitleChanged(String newTitle, int index) =
      _ItemTitleChanged;
  const factory AppListFormEvent.itemAdded() = _ItemAdded;
  const factory AppListFormEvent.itemDeleted(int index) = _ItemDeleted;
  const factory AppListFormEvent.saved() = _Saved;
}
