import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'list_entity.freezed.dart';

@freezed
class List with _$List {
  const factory List(String name) = _List;
}
