import 'package:dartz/dartz.dart';

import '../core/unique_id.dart';
import '../entities.dart';
import 'applist_failure.dart';

abstract class IAppListsRepository {
  Stream<Either<AppListFailure, List<AppList>>> watchListsIndex();

  Future<Either<AppListFailure, Unit>> updateListsIndex(List<AppList> lists);

  Future<Either<AppListFailure, AppList>> getList(UniqueId id);
  Future<Either<AppListFailure, Unit>> create(AppList appList, int orderIndex);
  Future<Either<AppListFailure, Unit>> update(AppList appList);
  Future<Either<AppListFailure, Unit>> delete(UniqueId id);
}
