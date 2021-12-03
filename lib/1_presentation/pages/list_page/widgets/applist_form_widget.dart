import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/1_presentation/pages/list_page/widgets/applist_item_widget.dart';

import '../../../../2_application/blocs.dart';

class AppListFormWidget extends StatelessWidget {
  const AppListFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc appListFormBloc = context.read<AppListFormBloc>();

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'List Name',
            ),
            onChanged: (newValue) =>
                appListFormBloc.add(AppListFormEvent.nameChanged(newValue)),
          ),
          TextButton(
            onPressed: () =>
                appListFormBloc.add(const AppListFormEvent.saved()),
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
                      // key: ValueKey,
                      index: i,
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () =>
                appListFormBloc.add(const AppListFormEvent.itemAdded()),
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
