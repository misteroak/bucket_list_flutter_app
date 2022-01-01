import 'package:freezed_annotation/freezed_annotation.dart';

part 'applist_failure.freezed.dart';

@freezed
class AppListFailure with _$AppListFailure {
  const factory AppListFailure.unexpected({String? message}) = Unexpected;
  const factory AppListFailure.listIdAlreadyExists(String? message) = ListIdAlreadyExists;
}
