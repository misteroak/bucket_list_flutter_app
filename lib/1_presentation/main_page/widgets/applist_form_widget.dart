import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/2_application/blocs.dart';

class AppListFormWidget extends StatefulWidget {
  const AppListFormWidget({Key? key}) : super(key: key);

  @override
  _AppListFormWidgetState createState() => _AppListFormWidgetState();
}

class _AppListFormWidgetState extends State<AppListFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc appListFormBloc = context.read<AppListFormBloc>();

    return Form(
      key: _formKey,
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
        ],
      ),
    );
  }
}
