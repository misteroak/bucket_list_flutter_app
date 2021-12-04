import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/3_domain/entities.dart';

import '../../../2_application/blocs/applist_watcher_bloc/applist_watcher_bloc.dart';
import '../../presenatation_constants.dart';
import 'widget_create_new_list.dart';
import 'widget_lists_listview.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListWatcherBloc>(
            create: (_) => context.read<AppListWatcherBloc>()),
      ],
      child: const _ListsOverviewPageScaffold(),
    );
  }
}

class _ListsOverviewPageScaffold extends StatelessWidget {
  const _ListsOverviewPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
                Text('List App', style: Theme.of(context).textTheme.headline3),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: state.maybeMap(
                          initial: (_) => const Center(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          loadingLists: (_) => const Text('Loading lists...'),
                          loadedSuccessfully: (e) =>
                              AppListsListView(appListsList: e.appLists),
                          loadFailed: (_) => const Text('Failed loading lists'),
                          orElse: () => Container(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 80,
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
        ),
      ),
    );
  }
}
