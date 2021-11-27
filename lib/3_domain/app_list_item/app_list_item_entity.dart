import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_list_item_entity.freezed.dart';
part 'app_list_item_entity.g.dart';

@freezed
class AppListItem with _$AppListItem {
  const factory AppListItem({
    required String title,
    required bool chcked,
  }) = _AppListItem;

  factory AppListItem.fromJson(Map<String, dynamic> json) =>
      _$AppListItemFromJson(json);
}
