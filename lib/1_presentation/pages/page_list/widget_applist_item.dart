import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_app/2_application/blocs/applist_form_bloc/applist_form_bloc.dart';
import 'package:provider/provider.dart';

class AppListItemWidget extends HookWidget {
  const AppListItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppListFormBloc>();
    final controller =
        useTextEditingController(text: bloc.state.appList.items[index].title);

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: TextFormField(
            controller: controller,
            onChanged: (newValue) {
              bloc.add(AppListFormEvent.listItemTitleChanged(newValue, index));
            }),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => bloc.add(AppListFormEvent.listItemDeleted(index)),
          color: Colors.red,
        ),
      ),
    );
  }
}
