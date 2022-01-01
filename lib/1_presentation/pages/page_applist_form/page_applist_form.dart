import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';
import '../../../injection.dart';
import '../../common/common.dart';
import '../../common/widget_padding_button.dart';
import 'widget_appbar_text_field.dart';
import 'widget_applist_form.dart';

class AppListFormPage extends StatelessWidget implements AutoRouteWrapper {
  const AppListFormPage({Key? key, required this.list, this.createNew = false}) : super(key: key);

  final AppList list;
  final bool createNew;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppListFormBloc>(create: (_) {
          return getIt<AppListFormBloc>()..add(AppListFormEvent.initialized(list));
        }),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppListFormBloc _bloc = context.read<AppListFormBloc>();

    return GestureDetector(
      onTap: () {
        // Add this to enable unfocus text boxes when clicking outside
        // FocusScope.of(context).requestFocus(FocusNode());
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<AppListFormBloc, AppListFormState>(
        listenWhen: (previous, current) {
          if (current.saveError == null) return false;
          return (previous.isSaving && !current.isSaving);
        },
        listener: (context, state) {
          if (state.saveError!) {
            showSnackBar(context, 'Error saving list :(');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarTextInput(
                initialValue: state.appList.name,
                onUnfocus: (newValue) => _bloc.add(AppListFormEvent.listNameChanged(newValue)),
                autoFocus: createNew,
              ),
              actions: const [
                PaddingButton(),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: AppListFormWidget(state.appList),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add_task_outlined),
              onPressed: () => _bloc.add(const AppListFormEvent.listItemAdded()),
            ),
          );
        },
      ),
    );
  }
}
