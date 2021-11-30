import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorPrimaryAccent = Colors.pink;
const inputBackground = Colors.white24;

ThemeData appThemeLight = ThemeData(
  brightness: Brightness.light,
  textTheme: appTextTheme,
  inputDecorationTheme: inputDecorationTheme,
  hintColor: Colors.black38,
  textButtonTheme: appTextButtonThemeData,
  // outlinedButtonTheme: appOutlinedButtonTheme,
);

TextTheme appTextTheme = GoogleFonts.oxygenTextTheme(
  const TextTheme(
    button: TextStyle(fontSize: 20),
  ),
);

TextButtonThemeData appTextButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.white10,
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  ),
);

// OutlinedButtonThemeData appOutlinedButtonTheme = OutlinedButtonThemeData(
//   style: TextButton.styleFrom(
//     primary: Colors.white,
//     backgroundColor: Colors.orange.shade700.withAlpha(0),
//     side: BorderSide.none,
//   ),
// );

// AppBarTheme appAppBarTheme = AppBarTheme(
//   // titleTextStyle: Theme.of(context).textTheme.headline4,
// );

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  fillColor: inputBackground,
  filled: true,
  contentPadding: const EdgeInsets.all(10),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 0, color: Colors.transparent),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 2, color: Colors.white12),
  ),
);

const BoxDecoration gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.9],
    colors: [Color(0xff00d2ff), Color(0xff0052D4)],
  ),
);
