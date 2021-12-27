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
      scheme: FlexScheme.damask,
      fontFamily: GoogleFonts.oswald().fontFamily,
    );

    // Overrides
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        subtitle1: theme.textTheme.subtitle1!.copyWith(
          fontSize: 20,
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        titleTextStyle: const TextStyle(fontSize: 30),
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

// TextButtonThemeData appTextButtonThemeData = TextButtonThemeData(
//   style: TextButton.styleFrom(
//     primary: Colors.white,
//     backgroundColor: Colors.white10,
//     padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(6),
//     ),
//   ),
// );
