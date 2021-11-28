part of 'applist_form_bloc.dart';

@freezed
class AppListFormEvent with _$AppListFormEvent {
  // const factory AppListFormEvent.started() = _Started;
  // const factory AppListFormEvent.saveAppList(AppList appList) = _SaveAppList;

  const factory AppListFormEvent.initialized() = _Initialized;
  const factory AppListFormEvent.nameChanged(String name) = _NameChanged;
  const factory AppListFormEvent.itemsChanged(List<AppListItem> items) =
      _ItemsChanged;
  const factory AppListFormEvent.saved() = _Saved;
}
