import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_app/3_domain/app_list_item/app_list_item_entity.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

part 'app_list_entity.freezed.dart';
part 'app_list_entity.g.dart';

@freezed
class AppList with _$AppList {
  const AppList._();

  @JsonSerializable(explicitToJson: true)
  const factory AppList({
    required UniqueId id,
    required DateTime createdTimestamp,
    required String name,
    required List<AppListItem> items,
  }) = _AppList;

  factory AppList.empty({String? name}) => AppList(
        id: UniqueId(),
        createdTimestamp: DateTime.now(),
        name: name ?? '',
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
