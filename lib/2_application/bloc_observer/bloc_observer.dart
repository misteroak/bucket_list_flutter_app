import 'package:bloc/bloc.dart';
import 'package:photo_app/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.logger.d('${bloc.runtimeType} event  💥: ${event.toString()}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.logger.d('${bloc.runtimeType} change 🔁: ${change.toString()}');
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   AppLogger.logger.d('${bloc.runtimeType} trans 🔁: ${transition.event} ${transition.nextState}');
  // }
}
