import 'package:bloc/bloc.dart';
import 'package:photo_app/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.logger
        .d('${bloc.runtimeType}: ${transition.event} ${transition.nextState}');
  }
}
