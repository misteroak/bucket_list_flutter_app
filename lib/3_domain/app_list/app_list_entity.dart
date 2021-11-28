import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities.dart';

part 'app_list_entity.freezed.dart';
part 'app_list_entity.g.dart';

@freezed
// @JsonSerializable(explicitToJson: true)
class AppList with _$AppList {
  @JsonSerializable(explicitToJson: true)
  const factory AppList({
    required String name,
    required List<AppListItem> items,
  }) = _AppList;

  factory AppList.empty() => const AppList(
        name: '',
        items: [],
      );

  factory AppList.fromJson(Map<String, dynamic> json) =>
      _$AppListFromJson(json);
}
