## What is this?

This app is very closely following Reso Coder's __Flutter Firebase and Design-Driven Development__ [tutorial series](https://resocoder.com/2020/03/09/flutter-firebase-ddd-course-1-domain-driven-design-principles/). I liked Reso's structure and instructions and wanted to have a base app that's using the key design components.

If you're new to Flutter, I highly encourage you follow his tutorial which links to many other tutorials. I think he's doing a really good job walking you through how to develop scalable apps. It will be long, about 30 something episodes, each about 30 to 60 minutes, but it is really worth it.

## Disclaimer
I'm a novice Flutter developer. Doing it mostly for fun and some side projects. I created this repository as I wanted to a starting point for new apps that follow clean architecture. I trust there're many issues with how I implemented things. Use at your own risk :) And feel free to share feedback!

## About the app
This is a VERY SIMPLE app that let's use manage multiple lists. CRUD lists and for each lists CRUD list items.

## What concepts will you find here

1) Clean architecture - separation to presentation, application (biz logic), domain and infrastructure layers.
2) Use of [Bloc](https://bloclibrary.dev/#/gettingstarted) for app business logic and state management. Updated to version 8.0.
3) Use of Firebase Realtime Database as a database. Why not Cloud Firestore? Well, I debated between the two, and ended up going with RTDB because I need it for another app where the pricing model makes more sense. You can use either, just implement another `IAppListsRepository` (see `bucket_list_flutter_app/lib/3_domain/applist/i_applists_repository.dart`).
3) Leveraging some really cool libraries:
    1) [Freezed](https://pub.dev/packages/freezed) - for unions and sealed classes when dealing with bloc states and events.
    2) [flutter_hooks](https://pub.dev/packages/flutter_hooks) because they are fun and better than StatefulWidgets :)
    3) [auto_route](https://pub.dev/packages/auto_route) to ease with the setup of routes.
    4) [flex_color_scheme](https://pub.dev/packages/flex_color_scheme) for theming

I built this in steps, each has it's own [release tag](https://github.com/misteroak/bucket_list_flutter_app/releases). You can follow them if you want to see the progress.
1) Basic clean architecture with SharedPreferences as repository, only a single list.
2) Added list items.
3) Support for multiple lists.
4) Changed to a [streaming version of SP](https://pub.dev/packages/streaming_shared_preferences) (in preparation to switching to a streaming Firebase repository on the next step)
5) Plug in a Firebase
6) Lots of cleanups...


## Stting Up

0) __Download packages__: Assuming VS Code hasn't done that for you already, run `flutter pub get`
1) __Generate code__: Run `flutter pub run build_runner build` (or if you want to watch file changes `flutter pub run build_runner watch --delete-conflicting-outputs`)
2) __Setup Firebase Realtime Database__: You'll need to get set up with Firebase Realtime Database. Follow these [instructions](https://firebase.flutter.dev/docs/database/overview). You will need to download a `GoogleService-Info.plist` file under the *ios* folder.
