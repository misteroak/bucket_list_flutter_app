import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/1_presentation/common_widgets/widget_padding_button.dart';

import '../../../2_application/blocs.dart';
import '../../../3_domain/entities.dart';
import '../../../injection.dart';
import 'widget_appbar_text_field.dart';
import 'widget_applist_form.dart';

class AppListFormPage extends StatelessWidget implements AutoRouteWrapper {
  const AppListFormPage({Key? key, required this.list}) : super(key: key);

  final AppList list;

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
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AppListFormBloc, AppListFormState>(
            builder: (context, state) {
              return AppBarTextInput(
                initialValue: state.appList.name,
                onUnfocus: (newValue) => _bloc.add(AppListFormEvent.nameChanged(newValue)),
              );
            },
          ),
          actions: const [
            PaddingButton(),
          ],
        ),
        body: BlocListener<AppListFormBloc, AppListFormState>(
          listenWhen: (previous, current) {
            if (current.saveError == null) return false;
            return (previous.isSaving && !current.isSaving);
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: !state.saveError! ? const Text('List saved successfully!') : const Text('Error saving list'),
              ),
            );
          },
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: AppListFormWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
