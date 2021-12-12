import 'package:freezed_annotation/freezed_annotation.dart';

part 'applist_failure.freezed.dart';

@freezed
class AppListFailure with _$AppListFailure {
  const factory AppListFailure.unexpected() = Unexpected;
  const factory AppListFailure.listIdAlreadyExists() = ListIdAlreadyExists;
}
