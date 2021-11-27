import 'app_list_entity.dart';

abstract class IAppListsRepository {
  Future<AppList?> getList();
  Future<bool> writeList(AppList list);
}
