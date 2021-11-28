import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorPrimaryAccent = Colors.pink;
const inputBackground = Colors.white24;

ThemeData appThemeLight = ThemeData(
  brightness: Brightness.light,
  textTheme: appTextTheme,
  inputDecorationTheme: inputDecorationTheme,
  hintColor: Colors.black38,
);

TextTheme appTextTheme = GoogleFonts.oxygenTextTheme(
  const TextTheme(),
);

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
