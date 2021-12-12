import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_app/3_domain/applist/applist_failure.dart';
import 'package:photo_app/3_domain/core/i_entity.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

import '../entities.dart';

part 'applist_entity.freezed.dart';
part 'applist_entity.g.dart';

@freezed
class AppList with _$AppList implements IEntity {
  const AppList._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory AppList({
    required UniqueId id,
    required DateTime createdTimestamp,
    required String name,
    required List<AppListItem> items,
  }) = _AppList;

  factory AppList.empty() => AppList(
        id: UniqueId(),
        name: '',
        createdTimestamp: DateTime.now(),
        items: [],
      );

  factory AppList.fromJson(Map<String, dynamic> json) =>
      _$AppListFromJson(json);

  AppList copyAndAddNewItem() => copyWith(
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

  @override
  AppListFailure? get errorMessage => throw UnimplementedError();
}
