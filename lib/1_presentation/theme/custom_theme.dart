import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConsts {}

class CustomTheme {
  static const double borderRadius = 10;

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
          textBaseline: TextBaseline.ideographic,
        ),
      ),
      // Card
      cardTheme: theme.cardTheme.copyWith(
        color: theme.primaryColorLight,
        elevation: 5,
      ),
      // Input Decoration
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        fillColor: theme.primaryColorLight,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
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
