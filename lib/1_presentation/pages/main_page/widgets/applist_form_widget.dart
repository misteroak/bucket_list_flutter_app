import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ],
      ),
    );
  }
}
