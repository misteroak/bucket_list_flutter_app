import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';
import 'widget_applist_item.dart';

class AppListFormWidget extends HookWidget {
  const AppListFormWidget(this.appList, {Key? key}) : super(key: key);

  final AppList appList;

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc _bloc = context.read<AppListFormBloc>();

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appList.items.length,
              itemBuilder: (context, i) {
                return AppListItemWidget(
                  key: ValueKey(appList.items[i].id.toString()),
                  initialTitle: appList.items[i].title,
                  onUpdate: (newValue) => _bloc.add(AppListFormEvent.finishedEditingItem(i, newValue)),
                  onDelete: () => _bloc.add(AppListFormEvent.listItemDeleted(i)),
                  autoFocus: _bloc.state.isNewItemAdded && i == appList.items.length - 1,
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              _bloc.add(const AppListFormEvent.listItemAdded());
            },
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
