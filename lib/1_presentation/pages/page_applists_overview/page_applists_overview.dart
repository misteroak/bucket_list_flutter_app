import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../injection.dart';
import '../../common/common.dart';
import '../../routes/router.dart';
import 'widget_applists_listview.dart';

class ListsOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListsWatcherBloc>(
          create: (_) => getIt<AppListsWatcherBloc>()..add(const AppListsWatcherEvent.watchLists()),
        ),
        BlocProvider<AppListsActorBloc>(create: (_) => getIt<AppListsActorBloc>())
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final actorBloc = context.read<AppListsActorBloc>();

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
      body: BlocListener<AppListsActorBloc, AppListsActorState>(
        listener: (context, state) {
          // I intentionally not using mapMaybe, I want to make sure all states are treated
          state.map(
            getListFailed: (_) => showSnackBar(context, 'Unable to load list'),
            createListFailed: (_) => showSnackBar(context, 'Unable to create new list'),
            deleteListError: (_) => showSnackBar(context, 'Unable to delete list'),
            updateListsIndicesFailed: (_) => showSnackBar(context, 'Error ordering list'),
            createListSuccess: (e) => context.router.push(AppListFormPageRoute(list: e.newAppList, createNew: true)),
            getListSuccess: (e) => context.router.push(AppListFormPageRoute(list: e.appList)),
            initial: (_) {},
          );
        },
        child: BlocConsumer<AppListsWatcherBloc, AppListsWatcherState>(
          listener: (context, state) {
            state.map(
              watchListsFailed: (_) => showSnackBar(context, 'Error loading lists'),
              initial: (_) {},
              watchListsSuccess: (_) {},
              watchingLists: (_) {},
            );
          },
          builder: (context, state) {
            return state.map(
              initial: (_) => Container(),
              watchingLists: (_) =>
                  const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator())),
              watchListsFailed: (_) => Container(),
              watchListsSuccess: (e) {
                return AppListsListView(
                  appListsList: e.appLists,
                  onListDelete: (i) {
                    actorBloc.add(AppListsActorEvent.deleteList(e.appLists[i]));
                  },
                  onListTap: (i) => {},
                  onOrderChanged: (newLists) {
                    actorBloc.add(AppListsActorEvent.updateListsIndices(newLists));
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: BlocBuilder<AppListsWatcherBloc, AppListsWatcherState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => Container(),
            watchListsSuccess: (e) => FloatingActionButton(
              child: const Icon(Icons.add_rounded),
              onPressed: () => actorBloc.add(AppListsActorEvent.createList(e.appLists.length)),
              // onPressed: () => {},
            ),
          );
        },
      ),
    );
  }
}
