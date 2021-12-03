import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'unique_id.g.dart';

@immutable
@JsonSerializable()
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

  factory UniqueId.fromJson(String json) => UniqueId.fromUniqueString(json);

  String toJson() => toString();
}
