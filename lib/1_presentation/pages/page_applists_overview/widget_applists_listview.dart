import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import '../../../3_domain/entities.dart';
import '../../../common.dart';

typedef AppListsCallback = void Function(List<AppList>);

class AppListsListView extends StatelessWidget {
  const AppListsListView({
    Key? key,
    required this.appListsList,
    required this.onListTap,
    required this.onListDelete,
    required this.onOrderChanged,
  }) : super(key: key);

  final List<AppList> appListsList;
  final IntCallback onListTap;
  final IntCallback onListDelete;
  final AppListsCallback onOrderChanged;

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedReorderableList<AppList>(
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      items: appListsList,
      itemBuilder: (context, itemAnimation, item, i) {
        return Reorderable(
          key: ValueKey(item.id),
          builder: (context, dragAnimation, inDrag) {
            final t = dragAnimation.value;
            final elevation = lerpDouble(0, 8, t);
            final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);

            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: itemAnimation,
              child: Material(
                color: color,
                elevation: elevation!,
                type: MaterialType.transparency,
                child: Handle(
                  child: ListTile(
                    title: Text(item.name),
                    onTap: () => onListTap(i),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onListDelete(i),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onReorderFinished: (item, from, to, newItems) {
        onOrderChanged(newItems);
      },
    );
  }
}
