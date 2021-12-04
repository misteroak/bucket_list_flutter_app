import 'package:injectable/injectable.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// @module
// abstract class SharedPreferenceInjectableModule {
//   @preResolve
//   Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
// }
@module
abstract class StreamingSharedPreferenceInjectableModule {
  @preResolve
  Future<StreamingSharedPreferences> get prefs =>
      StreamingSharedPreferences.instance;
}
