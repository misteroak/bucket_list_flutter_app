import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/1_presentation/routes/router.dart';
import 'package:photo_app/3_domain/app_list/app_list_entity.dart';

class AppListsListView extends StatelessWidget {
  const AppListsListView({
    Key? key,
    required this.appListsList,
  }) : super(key: key);

  final List<AppList> appListsList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: appListsList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 1),
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(index == 0 ? 10 : 0),
          topRight: Radius.circular(index == 0 ? 10 : 0),
          bottomLeft:
              Radius.circular(index == appListsList.length - 1 ? 10 : 0),
          bottomRight:
              Radius.circular(index == appListsList.length - 1 ? 10 : 0),
        ),
        child: Container(
          color: Colors.white54,
          child: ListTile(
            title: Text(appListsList[index].name),
            onTap: () => context.router.push(
              ListPageRoute(list: appListsList[index]),
            ),
          ),
        ),
      ),
    );
  }
}
