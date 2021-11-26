import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '1_presentation/main_page/main_page.dart';
import '2_application/bloc_observer/bloc_observer.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
