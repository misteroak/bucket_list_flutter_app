part of 'applist_form_bloc.dart';

@freezed
class AppListFormEvent with _$AppListFormEvent {
  const factory AppListFormEvent.started() = _Started;
  const factory AppListFormEvent.saveAppList(AppList appList) = _SaveAppList;
}
