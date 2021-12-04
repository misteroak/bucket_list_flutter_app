import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/entities.dart';
// import 'package:photo_app/app_logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

@LazySingleton(as: IAppListsRepository)
class AppListsRepository implements IAppListsRepository {
  // final SharedPreferences sp;
  final StreamingSharedPreferences sp;

  AppListsRepository(this.sp);

  @override
  Stream<List<AppList>> watchLists() async* {
    yield* sp.getKeys().map(
          (Set<String> keys) => keys.map((key) => _getList(key)).toList(),
        );

    // ids.sort();
    // try {
    //   return Future.value(ids.map((id) => _getList(id)).toList());
    // } catch (e) {
    //   AppLogger.logger.e(e);
    //   return Future.value(null);
    // }
  }

  @override
  Future<bool> create(AppList appList) {
    // We're using the list's creation date as the unique key. It
    // makes easier to sort later in the UI. Once we use a real db
    // we'll use the unique id and sort by date when we pull the data.

    if (sp.getKeys().getValue().contains(appList.createdTimestamp.toString())) {
      throw AssertionError('List with given id already exists');
    }

    return _writeList(appList);
  }

  @override
  Future<bool> update(AppList appList) {
    return _writeList(appList);
  }

  @override
  Future<bool> delete(AppList appList) {
    return sp.remove(appList.id.toString());
  }

  /// Throws [Exception] if list not found
  AppList _getList(String id) {
    String listJsonString = sp.getString(id, defaultValue: '').getValue();

    return AppList.fromJson(jsonDecode(listJsonString));
  }

  Future<bool> _writeList(AppList appList) {
    return sp.setString(appList.id.toString(), jsonEncode(appList.toJson()));
  }
}
