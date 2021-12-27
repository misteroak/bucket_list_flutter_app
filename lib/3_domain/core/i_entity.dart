import '../applist/applist_failure.dart';
import 'unique_id.dart';

abstract class IEntity {
  UniqueId get id;
  AppListFailure? get errorMessage => null;
}
