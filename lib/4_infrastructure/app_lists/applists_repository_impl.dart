import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

const listKey = 'AppList';

@LazySingleton(as: IAppListsRepository)
class AppListsRepository implements IAppListsRepository {
  final SharedPreferences sp;

  AppListsRepository(this.sp);

  @override
  Future<AppList> getList() {
    String res = sp.getString(listKey) ?? '';
    return Future.value(AppList.fromJson(jsonDecode(res)));
  }

  @override
  Future<bool> writeList(AppList list) {
    return sp.setString(listKey, jsonEncode(list.toJson()));
  }
}
