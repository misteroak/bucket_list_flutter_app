import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import 'widget_applist_item.dart';

class AppListFormWidget extends StatelessWidget {
  const AppListFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc appListFormBloc = context.read<AppListFormBloc>();

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'List Name',
            ),
            onChanged: (newValue) =>
                appListFormBloc.add(AppListFormEvent.nameChanged(newValue)),
          ),
          TextButton(
            onPressed: () =>
                appListFormBloc.add(const AppListFormEvent.listSaved()),
            child: const Text('Save List'),
          ),
          Expanded(
            child: BlocBuilder<AppListFormBloc, AppListFormState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.appList.items.length,
                  itemBuilder: (context, i) {
                    return AppListItemWidget(
                      key: ValueKey(state.appList.items[i].id),
                      index: i,
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () =>
                appListFormBloc.add(const AppListFormEvent.listItemAdded()),
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
