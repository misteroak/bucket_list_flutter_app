import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ulid/ulid.dart';

part 'unique_id.g.dart';

@immutable
@JsonSerializable()
class UniqueId {
  final String value;

  factory UniqueId() {
    return UniqueId._(Ulid().toString());
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
