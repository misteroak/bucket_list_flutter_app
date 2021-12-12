import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

const databaseURL = 'http://localhost:9000/?ns=photo-app-edf67';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  DatabaseReference get firebaseDatabase {
    return FirebaseDatabase(databaseURL: databaseURL).reference();
  }
}
