import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';
import '../../../injection.dart';
import '../../theme/custom_theme.dart';
import 'widget_applist_form.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key, this.list}) : super(key: key);

  final AppList? list;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListFormBloc>(
          create: (_) => getIt<AppListFormBloc>()
            ..add(
              AppListFormEvent.initialized(list),
            ),
        ),
      ],
      child: const _ListPageScaffold(),
    );
  }
}

class _ListPageScaffold extends StatelessWidget {
  const _ListPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppListFormBloc, AppListFormState>(
            buildWhen: (p, c) => !c.isDirty,
            builder: (context, state) => Text(state.appList.name)),
      ),
      body: BlocListener<AppListFormBloc, AppListFormState>(
        listenWhen: (previous, current) {
          if (current.saveError == null) return false;
          return (previous.isSaving && !current.isSaving);
        },
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: !state.saveError!
                  ? const Text('List saved successfully!')
                  : const Text('Error saving list'),
            ),
          );
        },
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: AppListFormWidget(),
          ),
        ),
      ),
    );
  }
}
