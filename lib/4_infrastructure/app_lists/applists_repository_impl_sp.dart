import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/entities.dart';
import 'package:photo_app/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAppListsRepository)
class AppListsRepository implements IAppListsRepository {
  final SharedPreferences sp;

  AppListsRepository(this.sp);

  @override
  Future<List<AppList>?> loadLists() {
    final ids = sp.getKeys();
    try {
      return Future.value(ids.map((id) => _getList(id)).toList());
    } catch (e) {
      AppLogger.logger.e(e);
      return Future.value(null);
    }
  }

  @override
  Future<bool> create(AppList appList) {
    if (sp.containsKey(appList.id.toString())) {
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
    // TODO: implement delete
    throw UnimplementedError();
  }

  /// Throws [Exception] if list not found
  AppList _getList(String id) {
    String? listJsonString = sp.getString(id);

    return AppList.fromJson(jsonDecode(listJsonString!));
  }

  Future<bool> _writeList(AppList appList) {
    return sp.setString(appList.id.toString(), jsonEncode(appList.toJson()));
  }
}
