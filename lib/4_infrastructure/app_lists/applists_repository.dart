import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:photo_app/3_domain/app_lists/applist_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../3_domain/app_lists/i_applists_repository.dart';

const listKey = 'AppList';

@LazySingleton(as: IAppListsRepository)
class AppListsRepository implements IAppListsRepository {
  final SharedPreferences sp;

  AppListsRepository(this.sp);

  @override
  AppList getList() {
    String res = sp.getString(listKey) ?? '';
    return AppList.fromJson(jsonDecode(res));
  }

  @override
  Future<bool> writeList(AppList list) {
    return sp.setString(listKey, jsonEncode(list.toJson()));
  }
}
