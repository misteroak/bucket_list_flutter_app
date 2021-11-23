import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'applist_entity.freezed.dart';
part 'applist_entity.g.dart';

@freezed
class AppList with _$AppList {
  const factory AppList(String name) = _AppList;

  factory AppList.fromJson(Map<String, dynamic> json) =>
      _$AppListFromJson(json);
}
