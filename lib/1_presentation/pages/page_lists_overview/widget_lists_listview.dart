import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/1_presentation/routes/router.dart';
import 'package:photo_app/2_application/blocs/applist_watcher_bloc/applist_watcher_bloc.dart';
import 'package:photo_app/3_domain/app_list/app_list_entity.dart';
import 'package:provider/provider.dart';

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
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(appListsList[index].name),
              onTap: () => context.router.push(
                ListPageRoute(list: appListsList[index]),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {
                  context.read<AppListWatcherBloc>().add(
                        AppListWatcherEvent.deleteList(
                          appListsList[index],
                        ),
                      )
                },
              ),
            ),
          );
        });
  }
}
