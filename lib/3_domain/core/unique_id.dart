import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'unique_id.g.dart';

@immutable
@JsonSerializable()
// @_UniqueIdJsonConverter()
class UniqueId {
  final String value;

  factory UniqueId() {
    return UniqueId._(const Uuid().v1());
  }

  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }

  const UniqueId._(this.value);

  @override
  String toString() => value.toString();

  // factory UniqueId.fromJson(Map<String, dynamic> json) =>
  //     _$UniqueIdFromJson(json);

  // Map<String, dynamic> toJson() => _$UniqueIdToJson(this);

  factory UniqueId.fromJson(String json) => UniqueId.fromUniqueString(json);

  String toJson() => toString();
}

class _UniqueIdJsonConverter implements JsonConverter<UniqueId, String> {
  const _UniqueIdJsonConverter();

  @override
  UniqueId fromJson(String json) => UniqueId.fromUniqueString(json);

  @override
  String toJson(UniqueId object) => object.toString();
}

// @JsonSerializable()
// @_DateTimeEpochConverter()
// class DateTimeExample {
//   final DateTime when;

//   DateTimeExample(this.when);

//   factory DateTimeExample.fromJson(Map<String, dynamic> json) =>
//       _$DateTimeExampleFromJson(json);

//   Map<String, dynamic> toJson() => _$DateTimeExampleToJson(this);
// }

// class _DateTimeEpochConverter implements JsonConverter<DateTime, int> {
//   const _DateTimeEpochConverter();

//   @override
//   DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

//   @override
//   int toJson(DateTime object) => object.millisecondsSinceEpoch;
// }
