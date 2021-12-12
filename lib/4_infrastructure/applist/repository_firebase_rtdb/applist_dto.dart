import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

import '../../../3_domain/entities.dart';

part 'applist_dto.freezed.dart';
part 'applist_dto.g.dart';

@freezed
class AppListDto with _$AppListDto {
  const AppListDto._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true, anyMap: true)
  factory AppListDto({
    // ignore: invalid_annotation_target
    @JsonKey(ignore: true) String? id,
    required String name,
    required int createdDate,
    required List<AppListItemDto>? items,
  }) = _AppListDto;

  factory AppListDto.fromDomain(AppList list) {
    return AppListDto(
      id: list.id.toString(),
      name: list.name,
      createdDate: list.createdTimestamp.millisecondsSinceEpoch,
      items: list.items
          .mapIndexed((index, element) => AppListItemDto.fromDomain(element))
          .toList(),
    );
  }

  factory AppListDto.fromJson(Map<String, dynamic> json) =>
      _$AppListDtoFromJson(json);

  factory AppListDto.fromRTDB(String id, Map<String, dynamic> list) =>
      AppListDto.fromJson(list).copyWith(id: id);

  AppList toDomain() {
    return AppList(
      id: UniqueId.fromUniqueString(id!),
      name: name,
      createdTimestamp: DateTime.fromMillisecondsSinceEpoch(createdDate),
      items: items?.map((element) => element.toDomain()).toList() ?? [],
    );
  }
}

@freezed
class AppListMetadataDto with _$AppListMetadataDto {
  const AppListMetadataDto._();

  factory AppListMetadataDto({
    // ignore: invalid_annotation_target
    @JsonKey(ignore: true) String? id,
    required String name,
    required int createdDate,
  }) = _AppListMetadataDto;

  factory AppListMetadataDto.fromDomain(AppList list) {
    return AppListMetadataDto(
      id: list.id.toString(),
      name: list.name,
      createdDate: list.createdTimestamp.millisecondsSinceEpoch,
    );
  }

  factory AppListMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$AppListMetadataDtoFromJson(json);

  factory AppListMetadataDto.fromRTDB(
          String id, Map<String, dynamic> listJson) =>
      AppListMetadataDto.fromJson(listJson).copyWith(id: id);

  AppList toDomain() {
    return AppList(
      id: UniqueId.fromUniqueString(id!),
      name: name,
      createdTimestamp: DateTime.fromMillisecondsSinceEpoch(createdDate),
      items: [],
    );
  }
}

@freezed
class AppListItemDto with _$AppListItemDto {
  const AppListItemDto._();

  factory AppListItemDto({
    // ignore: invalid_annotation_target
    required String id,
    required String title,
    required bool checked,
  }) = _AppListItemDto;

  factory AppListItemDto.fromDomain(AppListItem item) {
    return AppListItemDto(
      id: item.id.toString(),
      title: item.title,
      checked: item.checked,
    );
  }

  factory AppListItemDto.fromJson(Map<String, dynamic> json) =>
      _$AppListItemDtoFromJson(json);

  AppListItem toDomain() {
    return AppListItem(
      id: UniqueId.fromUniqueString(id),
      title: title,
      checked: this.checked,
    );
  }
}
