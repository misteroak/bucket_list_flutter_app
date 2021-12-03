import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

import '../entities.dart';

part 'app_list_entity.freezed.dart';
part 'app_list_entity.g.dart';

@freezed
class AppList with _$AppList {
  const AppList._(); // Added constructor

  @JsonSerializable(explicitToJson: true)
  const factory AppList({
    required UniqueId id,
    required String name,
    required List<AppListItem> items,
  }) = _AppList;

  factory AppList.empty() => AppList(
        id: UniqueId(),
        name: '',
        items: [],
      );

  factory AppList.fromJson(Map<String, dynamic> json) =>
      _$AppListFromJson(json);

  AppList copyAndAddEmptyItem() => copyWith(
        items: [...items, AppListItem.empty()],
      );

  AppList copyAndRemoveItemAtIndex(int index) {
    return copyWith(items: [...items]..removeAt(index));
  }

  AppList copyWithUpdatedItemtitle(String newTitle, int index) {
    var newList = [...items];
    newList[index] = newList[index].copyWith(title: newTitle);
    return copyWith(
      items: newList,
    );
  }
}
