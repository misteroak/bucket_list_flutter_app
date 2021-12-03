import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/unique_id.dart';

part 'app_list_item_entity.freezed.dart';
part 'app_list_item_entity.g.dart';

@freezed
class AppListItem with _$AppListItem {
  const factory AppListItem({
    required UniqueId id,
    required String title,
    required bool chcked,
  }) = _AppListItem;

  factory AppListItem.fromJson(Map<String, dynamic> json) =>
      _$AppListItemFromJson(json);

  factory AppListItem.empty() => AppListItem(
        id: UniqueId(),
        title: '',
        chcked: false,
      );
}
