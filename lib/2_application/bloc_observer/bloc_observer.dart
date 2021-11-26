import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  var logger = Logger(
    printer: PrettyPrinter(
      noBoxingByDefault: true,
      methodCount: 0,
    ),
  );

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d('${bloc.runtimeType}: $transition');
  }
}
