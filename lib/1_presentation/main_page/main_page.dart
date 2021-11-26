import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../2_application/blocs.dart';
import '../../injection.dart';
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
      listenWhen: (previous, current) => current.maybeMap(
        savedSuccessfully: (_) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('List saved successfully!'),
          ),
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Save list form
              AppListFormWidget(),
              Divider(color: Colors.red),
              AppListLoaderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
