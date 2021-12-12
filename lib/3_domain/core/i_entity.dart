import 'package:photo_app/3_domain/applist/applist_failure.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';

abstract class IEntity {
  UniqueId get id;
  AppListFailure? get errorMessage => null;
}
