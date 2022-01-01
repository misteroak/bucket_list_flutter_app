import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../3_domain/applist/applist_failure.dart';
import '../../../3_domain/core/unique_id.dart';
import '../../../3_domain/entities.dart';
import 'applist_dto.dart';

class Paths {
  static const String indexRoot = '/listsIndex/';
  static const String fullRoot = '/listsFull/';
}

@LazySingleton(as: IAppListsRepository)
class AppListsFirebaseRepository implements IAppListsRepository {
  final DatabaseReference database;

  AppListsFirebaseRepository(this.database);

  List<AppListMetadataDto> rtdbListToDto(dynamic rtdbValue) {
    final valueAsJson = Map<String, dynamic>.from(rtdbValue);

    final List<AppListMetadataDto> res = valueAsJson.keys.map(
      (key) {
        final listMetadataDto = AppListMetadataDto.fromRTDB(
          key,
          Map<String, dynamic>.from(valueAsJson[key]),
        );
        return listMetadataDto;
      },
    ).toList();

    return res;
  }

  @override
  Stream<Either<AppListFailure, List<AppList>>> watchListsIndex() async* {
    yield* database.child(Paths.indexRoot).orderByChild('orderIndex').onValue.map(
      (event) {
        if (null == event.snapshot.value) {
          return right<AppListFailure, List<AppList>>(List<AppList>.empty());
        }

        final List<AppList> res = rtdbListToDto(event.snapshot.value).map((e) => e.toDomain()).toList();

        return right<AppListFailure, List<AppList>>(res);
      },
    ).onErrorReturnWith(
      (error, stackTrace) {
        // TODO: Log error properly
        return left<AppListFailure, List<AppList>>(AppListFailure.unexpected(message: error.toString()));
      },
    );
  }

  Map<String, dynamic> updateListsDtoOrderIndices(List<AppListMetadataDto> lists) {
    final Map<String, dynamic> updatedListsIndex = {};
    for (var i = 0; i < lists.length; i++) {
      updatedListsIndex[lists[i].id.toString()] = lists[i].copyWith(orderIndex: i).toJson();
    }
    return updatedListsIndex;
  }

  @override
  Future<Either<AppListFailure, Unit>> updateListsIndex(List<AppList> lists) async {
    try {
      final Map<String, dynamic> updates = {};

      final listsDtos = lists.map((e) => AppListMetadataDto.fromDomain(e, lists.indexOf(e))).toList();

      updates[Paths.indexRoot] = updateListsDtoOrderIndices(listsDtos);
      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      return Future.value(left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, AppList>> getList(UniqueId id) async {
    try {
      final appListValue = (await database.child(Paths.fullRoot + id.toString()).once()).value;
      final appListJson = Map<String, dynamic>.from(appListValue);

      final appList = AppListDto.fromRTDB(id.toString(), appListJson).toDomain();

      return Future.value(right<AppListFailure, AppList>(appList));
    } catch (e) {
      return Future.value(left<AppListFailure, AppList>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, Unit>> create(AppList appList, int orderIndex) async {
    try {
      // Error if list already exists
      final appListValue = (await database.child(Paths.indexRoot + appList.id.toString()).once()).value;
      if (null != appListValue) {
        return Future.value(left<AppListFailure, Unit>(const AppListFailure.unexpected()));
      }

      final Map<String, dynamic> updates = {
        Paths.indexRoot + appList.id.toString(): AppListMetadataDto.fromDomain(appList, orderIndex).toJson(),
        Paths.fullRoot + appList.id.toString(): AppListDto.fromDomain(appList).toJson(),
      };

      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      // TODO: Log error - list id already exists
      return Future.value(left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }

  @override
  // TODO: Create an UpdateListItem function so this is not called each time a list item is changed!!
  Future<Either<AppListFailure, Unit>> update(AppList appList) async {
    try {
      final orderIndex =
          (await database.child(Paths.indexRoot + appList.id.toString()).child('orderIndex').once()).value;

      final Map<String, dynamic> updates = {
        Paths.indexRoot + appList.id.toString(): AppListMetadataDto.fromDomain(appList, orderIndex).toJson(),
        Paths.fullRoot + appList.id.toString(): AppListDto.fromDomain(appList).toJson(),
      };

      // final Map<String, dynamic> updates = {};
      // updates[Paths.metadataRoot + appList.id.toString()] = AppListMetadataDto.fromDomain(appList).toJson();

      // updates[Paths.fullRoot + appList.id.toString()] = AppListDto.fromDomain(appList).toJson();

      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      // TODO: Log error
      return Future.value(left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }

  @override
  Future<Either<AppListFailure, Unit>> delete(UniqueId id) async {
    try {
      final Map<String, dynamic> updates = {};

      // 1) Remove the metadata item form the lists index, and update the orderIndex

      final listsIndexJson = (await database.child(Paths.indexRoot).orderByChild('orderIndex').once()).value;
      final listsDtos = rtdbListToDto(listsIndexJson);
      listsDtos.removeWhere((element) => UniqueId.fromUniqueString(element.id!) == id);
      final updatedListsIndex = updateListsDtoOrderIndices(listsDtos);

      updates[Paths.indexRoot] = updatedListsIndex;

      // 2 Remove the full list data
      updates[Paths.fullRoot + id.toString()] = null;

      await database.update(updates);

      return Future.value(right<AppListFailure, Unit>(unit));
    } catch (e) {
      // TODO: Log error
      return Future.value(left<AppListFailure, Unit>(const AppListFailure.unexpected()));
    }
  }
}
