import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../injection.dart';
import '../../presenatation_constants.dart';
import '../../routes/router.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListWatcherBloc>(
          create: (_) => getIt<AppListWatcherBloc>(),
        ),
      ],
      child: const _MainPageLayout(),
    );
  }
}

class _MainPageLayout extends StatelessWidget {
  const _MainPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppListWatcherBloc, AppListWatcherState>(
        listenWhen: (previous, current) => current.maybeMap(
          loadedListSuccessfully: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.maybeMap(
            loadedListSuccessfully: (e) {
              context.router.push(ListPageRoute(list: e.appList));
            },
            orElse: () {},
          );
        },
        child: Container(
          decoration: gradientBackground,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Load List'),
                  onPressed: () => context
                      .read<AppListWatcherBloc>()
                      .add(const AppListWatcherEvent.loadList()),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: BlocBuilder<AppListWatcherBloc, AppListWatcherState>(
                    builder: (context, state) {
                      return state.maybeMap(
                        loadingList: (_) => const CircularProgressIndicator(),
                        orElse: () => Container(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
