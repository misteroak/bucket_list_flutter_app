import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  DatabaseReference get firebaseDatabase {
    return FirebaseDatabase().reference();
  }
}
