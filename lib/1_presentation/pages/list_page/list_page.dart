import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';
import '../../../injection.dart';
import '../../presenatation_constants.dart';
import '../main_page/widgets/applist_form_widget.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key, this.list}) : super(key: key);

  final AppList? list;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListFormBloc>(
            create: (_) => getIt<AppListFormBloc>()
              ..add(AppListFormEvent.initialized(list))),
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
              content: state.saveError!
                  ? const Text('List saved successfully!')
                  : const Text('Error saving list'),
            ),
          );
        },
        child: Center(
          child: Container(
            decoration: gradientBackground,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  AppListFormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}