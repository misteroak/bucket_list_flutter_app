import 'applist_entity.dart';

abstract class IAppListsRepository {
  AppList getList();
  Future<bool> writeList(AppList list);
}
