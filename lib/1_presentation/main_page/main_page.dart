import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../2_application/blocs.dart';
import '../../injection.dart';
import '../constants.dart';
import 'widgets/applist_form_widget.dart';
import 'widgets/applist_loader_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AppListFormBloc>(
            create: (_) => getIt<AppListFormBloc>(),
          ),
          BlocProvider<AppListWatcherBloc>(
            create: (_) => getIt<AppListWatcherBloc>(),
          ),
        ],
        child: const _MainPageLayout(),
      ),
    );
  }
}

class _MainPageLayout extends StatelessWidget {
  const _MainPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppListFormBloc, AppListFormState>(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Save list form
                Text(
                  'Save List',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppListFormWidget(),
                const Divider(color: Colors.red),
                const AppListLoaderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
