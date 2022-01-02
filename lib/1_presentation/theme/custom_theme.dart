import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConsts {
  static const double borderRadius = 0;
}

class CustomTheme {
  static ThemeData get lightTheme {
    // Main Theme
    final ThemeData theme = FlexThemeData.light(
      scheme: FlexScheme.hippieBlue,
      fontFamily: GoogleFonts.dosis().fontFamily,
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 60),
        headline2: TextStyle(fontSize: 40),
        button: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    print(theme.textTheme);
    // Overrides
    return theme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFDDE3F1),
      textTheme: theme.textTheme.copyWith(
        subtitle1: theme.textTheme.subtitle1!.copyWith(
          fontSize: 20,
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        titleTextStyle: theme.textTheme.headline1!.copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.secondary,
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomAppBarTheme: theme.bottomAppBarTheme.copyWith(
        color: const Color(0xFFDDE3F1).darken(5),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: theme.colorScheme.secondary,
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        contentPadding: const EdgeInsets.symmetric(
          // vertical: 0,
          horizontal: 8,
        ),
        fillColor: theme.inputDecorationTheme.fillColor?.withAlpha(30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConsts.borderRadius),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConsts.borderRadius),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
    );
  }
}
