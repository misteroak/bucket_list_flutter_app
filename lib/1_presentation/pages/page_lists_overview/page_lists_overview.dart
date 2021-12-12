import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/1_presentation/routes/router.dart';
import 'package:photo_app/2_application/blocs.dart';

import '../../../injection.dart';
import 'widget_create_new_list.dart';
import 'widget_lists_listview.dart';

class ListsOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ListsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListWatcherBloc>(
          create: (_) => getIt<AppListWatcherBloc>()
            ..add(const AppListWatcherEvent.watchLists()),
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
            context.router.push(ListPageRoute(list: e.appList));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
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
                        ),
                      ),
                      loadingLists: (_) => const Text('Loading lists...'),
                      loadedSuccessfully: (e) =>
                          AppListsListView(appListsList: e.appLists),
                      loadFailed: (_) => const Text(
                          'Unexpected error loading lists, please contact support'),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CreateNewListWidget(
                  onClick: (value) => context.read<AppListActorBloc>().add(
                        AppListActorEvent.createNewList(value),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
