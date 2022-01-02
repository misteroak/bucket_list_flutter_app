import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            return AnimatedBuilder(
              animation: dragAnimation,
              builder: (context, child) {
                final t = dragAnimation.value;
                final elevation = lerpDouble(0, 10, t);
                // final color = Color.lerp(Colors.white, Colors.grey, t);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(20),
                    elevation: elevation!,
                    color: Theme.of(context).colorScheme.surface,
                    child: SizeFadeTransition(
                      sizeFraction: 0.3,
                      curve: Curves.easeInOut,
                      animation: itemAnimation,
                      child: Handle(
                        delay: const Duration(milliseconds: 800),
                        child: Slidable(
                          closeOnScroll: true,
                          enabled: !inDrag,
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                autoClose: true,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                icon: Icons.delete,
                                onPressed: (_) => onListDelete(i),
                              )
                            ],
                          ),
                          child: SizedBox(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
