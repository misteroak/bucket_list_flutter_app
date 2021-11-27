import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities.dart';

part 'app_list_entity.freezed.dart';
part 'app_list_entity.g.dart';

@freezed
// @JsonSerializable(explicitToJson: true)
class AppList with _$AppList {
  @JsonSerializable(explicitToJson: true)
  const factory AppList(
    String name, {
    @Default([]) List<AppListItem> items,
  }) = _AppList;

  factory AppList.fromJson(Map<String, dynamic> json) =>
      _$AppListFromJson(json);
}
