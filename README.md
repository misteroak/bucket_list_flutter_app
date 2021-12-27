## Stting Up

0) __Download packages__: Assuming VS Code hasn't done that for you already, run `flutter pub get`
1) __Generate code__: Run `flutter pub run build_runner build` (or if you want to watch file changes `flutter pub run build_runner watch --delete-conflicting-outputs`)
2) __Setup Firebase Realtime Database__: You'll need to get set up with Firebase Realtime Database. Follow these [instructions](https://firebase.flutter.dev/docs/database/overview). You will need to download a `GoogleService-Info.plist` file under the *ios* folder.
