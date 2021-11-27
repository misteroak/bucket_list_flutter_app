import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/2_application/blocs.dart';
import 'package:photo_app/3_domain/app_list/app_list_entity.dart';

class AppListFormWidget extends StatefulWidget {
  const AppListFormWidget({Key? key}) : super(key: key);

  @override
  _AppListFormWidgetState createState() => _AppListFormWidgetState();
}

class _AppListFormWidgetState extends State<AppListFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _listName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'List Name',
            ),
            onChanged: (newValue) => _listName = newValue,
          ),
          TextButton(
            onPressed: () => context
                .read<AppListFormBloc>()
                .add(AppListFormEvent.saveAppList(AppList(_listName ?? ''))),
            child: const Text('Save List'),
          ),
        ],
      ),
    );
  }
}
