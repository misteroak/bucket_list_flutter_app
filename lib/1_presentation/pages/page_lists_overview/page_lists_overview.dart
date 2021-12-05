import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../3_domain/entities.dart';

import '../../../2_application/blocs/applist_watcher_bloc/applist_watcher_bloc.dart';
import '../../../injection.dart';

import 'widget_create_new_list.dart';
import 'widget_lists_listview.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListWatcherBloc>(
          create: (_) => getIt<AppListWatcherBloc>()
            ..add(const AppListWatcherEvent.watchLists()),
        )
      ],
      child: const _ListsOverviewPageScaffold(),
    );
  }
}

class _ListsOverviewPageScaffold extends StatelessWidget {
  const _ListsOverviewPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        title: Text(
          'Bucket Lists',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<AppListWatcherBloc, AppListWatcherState>(
              buildWhen: (p, c) => c.maybeWhen(
                loadingLists: () => true,
                loadedSuccessfully: (_) => true,
                loadFailed: () => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                return Expanded(
                  child: state.maybeMap(
                    orElse: () => const Center(
                        child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    )),
                    loadingLists: (_) => const Text('Loading lists...'),
                    loadedSuccessfully: (e) =>
                        AppListsListView(appListsList: e.appLists),
                    loadFailed: (_) => const Text('Failed loading lists'),
                    // orElse: () => Container(color: Colors.red),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateNewListWidget(
                onClick: (value) => context.read<AppListWatcherBloc>().add(
                      AppListWatcherEvent.createNewList(
                        AppList.empty(name: value),
                      ),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
