import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/core/unique_id.dart';
import 'package:rxdart/rxdart.dart';

import '../../../3_domain/applist/applist_failure.dart';
import '../../../3_domain/entities.dart';
import 'applist_dto.dart';

class DatabasePaths {
  static const String listsIndexRoot = '/listMetadata/';
  static const String listsRoot = '/listsFull/';
}

@LazySingleton(as: IAppListsRepository)
class AppListsFirebaseRepository implements IAppListsRepository {
  final DatabaseReference database;

  AppListsFirebaseRepository(this.database);

  @override
  Stream<Either<AppListFailure, List<AppList>>> watchListsIndex() async* {
    yield* database.child(DatabasePaths.listsIndexRoot).onValue.map(
      (event) {
        if (null == event.snapshot.value) {
          return right<AppListFailure, List<AppList>>([]);
        }

        final listsJsons = Map<String, dynamic>.from(event.snapshot.value);

        final List<AppList> res = listsJsons.keys.map(
          (key) {
            final listMetadataDto = AppListMetadataDto.fromRTDB(
              key,
              Map<String, dynamic>.from(listsJsons[key]),
            );
            return listMetadataDto.toDomain();
          },
        ).toList();

        return right<AppListFailure, List<AppList>>(res);
      },
    ).onErrorReturnWith(
      (error, stackTrace) {
        // TODO: Log error
        return left<AppListFailure, List<AppList>>(
            const AppListFailure.unexpected());
      },
    );
  }

  @override
  Future<Either<AppListFailure, AppList>> getList(UniqueId id) async {
    try {
      final appListValue =
          (await database.child(DatabasePaths.listsRoot + id.toString()).once())
              .value;
      final appListJson = Map<String, dynamic>.from(appListValue);

      final appList =
          AppListDto.fromRTDB(id.toString(), appListJson).toDomain();

      return Future.value(right<AppListFailure, AppList>(appList));
    } catch (e) {
      return Future.value(
          left<AppListFailure, AppList>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, Unit>> create(AppList appList) async {
    try {
      // Check if list already exists. This is just for extra safety, probably not really needed
      final appListValue = (await database
              .child(DatabasePaths.listsIndexRoot + id.toString())
              .once())
          .value;
      if (null != appListValue) {
        return Future.value(
            left<AppListFailure, Unit>(const AppListFailure.unexpected()));
      }

      return _update(appList);
    } catch (e) {
      // TODO: Log error - list id already exists
      return Future.value(
          left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, Unit>> update(AppList appList) {
    return _update(appList);
  }

  Future<Either<AppListFailure, Unit>> _update(AppList appList) async {
    try {
      final Map<String, dynamic> updates = {};

      updates[DatabasePaths.listsIndexRoot + appList.id.toString()] =
          AppListMetadataDto.fromDomain(appList).toJson();

      updates[DatabasePaths.listsRoot + appList.id.toString()] =
          AppListDto.fromDomain(appList).toJson();

      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      // TODO: Log error
      return Future.value(
          left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, Unit>> delete(UniqueId id) async {
    try {
      final Map<String, dynamic> updates = {};

      updates[DatabasePaths.listsIndexRoot + id.toString()] = null;
      updates[DatabasePaths.listsRoot + id.toString()] = null;

      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      // TODO: Log error
      return Future.value(
          left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }
}
