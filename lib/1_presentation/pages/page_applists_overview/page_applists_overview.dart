import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../injection.dart';
import '../../routes/router.dart';
import 'widget_applists_listview.dart';

class ListsOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListWatcherBloc>(
          create: (_) => getIt<AppListWatcherBloc>()..add(const AppListWatcherEvent.watchLists()),
        ),
        BlocProvider<AppListActorBloc>(
          create: (_) => getIt<AppListActorBloc>(),
        )
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppListActorBloc, AppListActorState>(
      listener: (context, state) {
        state.maybeMap(
          getListSuccess: (e) {
            context.router.push(AppListFormPageRoute(list: e.appList));
          },
          orElse: () {},
        );
      },
      child: const _ListOvewScaffold(),
    );
  }
}

class _ListOvewScaffold extends StatelessWidget {
  const _ListOvewScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Buckets List',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            BlocBuilder<AppListWatcherBloc, AppListWatcherState>(
              builder: (context, state) {
                return Expanded(
                  child: state.maybeMap(
                    orElse: () => const _LoadingIndicator(),
                    loadedSuccessfully: (e) => AppListsListView(appListsList: e.appLists),
                    loadFailed: (_) => const Text('Unexpected error loading lists'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () => context.read<AppListActorBloc>().add(
              const AppListActorEvent.createNewList(),
            ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
    );
  }
}