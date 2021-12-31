import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:provider/provider.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';

/// Expects to get the list in the correct order
class AppListsListView extends StatelessWidget {
  const AppListsListView({
    Key? key,
    required this.appListsList,
  }) : super(key: key);

  final List<AppList> appListsList;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppListActorBloc>();

    return ImplicitlyAnimatedReorderableList<AppList>(
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      items: appListsList,
      itemBuilder: (context, animation, item, i) {
        return Reorderable(
          key: ValueKey(item.id),
          child: Handle(
            child: ListTile(
              title: Text(item.name),
              onTap: () {
                bloc.add(AppListActorEvent.getList(item.id));
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => bloc.add(
                  AppListActorEvent.deleteList(item),
                ),
              ),
            ),
          ),
        );
      },
      onReorderFinished: (item, from, to, newItems) {
        bloc.add(AppListActorEvent.updateListsIndex(newItems));
      },
    );
  }
}
