import 'package:auto_route/auto_route.dart';
import 'package:bucket_list_flutter_app/3_domain/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../2_application/blocs.dart';
import '../../../injection.dart';
import '../../common/common.dart';
import '../../routes/router.dart';
import 'widget_applists_listview.dart';

class ListsOverviewPage extends HookWidget implements AutoRouteWrapper {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListsWatcherBloc>(
          create: (_) => getIt<AppListsWatcherBloc>()..add(const AppListsWatcherEvent.watchLists()),
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
    final appLists = useState(
      List<AppList>.empty(),
    ); // Used to maintain the visual order of lists. In the future may be used for nesting as well.

    final blocActor = context.read<AppListActorBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AppListsWatcherBloc, AppListsWatcherState>(
          listener: (context, state) {
            state.maybeMap(
              loadedSuccessfully: (e) => appLists.value = e.appLists,
              orElse: () => null,
            );
          },
        ),
        BlocListener<AppListActorBloc, AppListActorState>(
          listener: (context, state) {
            state.maybeMap(
                getListError: (_) => showSnackBar(context, 'Unable to load list'),
                newListCreatedError: (_) => showSnackBar(context, 'Unable to create new list'),
                deleteListError: (_) => showSnackBar(context, 'Unable to delete list'),
                updateListsIndexError: (_) => showSnackBar(context, 'Error ordering list'),
                newListCreatedSuccessfully: (e) =>
                    context.router.push(AppListFormPageRoute(list: e.newAppList, createNew: true)),
                getListSuccess: (e) => context.router.push(AppListFormPageRoute(list: e.appList)),
                orElse: () {});
          },
        ),
      ],
      child: Scaffold(
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
              BlocBuilder<AppListsWatcherBloc, AppListsWatcherState>(
                builder: (context, state) {
                  return Expanded(
                    child: state.maybeMap(
                      orElse: () => const _LoadingIndicator(),
                      loadedSuccessfully: (e) {
                        return AppListsListView(appListsList: appLists.value);
                      },
                      loadFailed: (_) => const Text('Unexpected error loading lists'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: BlocBuilder<AppListsWatcherBloc, AppListsWatcherState>(
          builder: (context, state) {
            return FloatingActionButton(
              child: const Icon(Icons.add_rounded),
              onPressed: () => blocActor.add(AppListActorEvent.createNewList(appLists.value.length)),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator()));
  }
}
