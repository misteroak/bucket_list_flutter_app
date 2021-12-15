import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';

class AppListsListView extends StatelessWidget {
  const AppListsListView({
    Key? key,
    required this.appListsList,
  }) : super(key: key);

  final List<AppList> appListsList;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppListActorBloc>();

    return ListView.separated(
      itemCount: appListsList.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        thickness: 1,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(appListsList[index].name),
          onTap: () {
            bloc.add(AppListActorEvent.getList(appListsList[index].id));
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => bloc.add(
              AppListActorEvent.deleteList(appListsList[index]),
            ),
          ),
        );
      },
    );
  }
}
