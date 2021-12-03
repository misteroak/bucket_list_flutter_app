import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:photo_app/config.dart';

class AppBlocObserver extends BlocObserver {
  var logger = Logger(printer: logPrettyPrinter);

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger
        .d('${bloc.runtimeType}: ${transition.event} ${transition.nextState}');
  }
}
