import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/2_application/blocs.dart';

class AppListLoaderWidget extends StatelessWidget {
  const AppListLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => context
              .read<AppListWatcherBloc>()
              .add(const AppListWatcherEvent.loadList()),
          child: const Text('Load List'),
        ),
        BlocBuilder<AppListWatcherBloc, AppListWatcherState>(
          builder: (context, state) {
            return Text(
              state.map(
                  initial: (_) => '',
                  loadingList: (_) => 'Loading..',
                  loadedListSuccessfully: (event) => event.appList.name,
                  loadListFailed: (_) => 'Error loading list!'),
            );
          },
        ),
      ],
    );
  }
}
