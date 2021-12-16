import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../2_application/blocs.dart';
import 'widget_applist_item.dart';

class AppListFormWidget extends HookWidget {
  const AppListFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc _bloc = context.read<AppListFormBloc>();

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BlocBuilder<AppListFormBloc, AppListFormState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.appList.items.length,
                  itemBuilder: (context, i) {
                    return AppListItemWidget(
                      key: ValueKey(state.appList.items[i].id),
                      index: i,
                      initialTitle: state.appList.items[i].title,
                      onUpdate: (newValue) => _bloc.add(AppListFormEvent.finishedEditingItem(i, newValue)),
                      onDelete: (index) => _bloc.add(AppListFormEvent.listItemDeleted(index)),
                      autoFocus: _bloc.state.isNewItemAdded && i == state.appList.items.length - 1,
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () => _bloc.add(const AppListFormEvent.listItemAdded()),
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
