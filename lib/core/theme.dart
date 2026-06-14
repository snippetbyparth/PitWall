import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class F1Colors {
  static const background = Color(0xFF0A0A0A);
  static const surface = Color(0xFF141414);
  static const card = Color(0xFF1E1E1E);
  static const red = Color(0xFFE8002D); // F1 red
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF6B6B6B);
  static const lightGrey = Color(0xFFB0B0B0);
  static const green = Color(0xFF00D2BE); // accent
  static const yellow = Color(0xFFFFD700);
}

class F1Theme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: F1Colors.background,
      cardColor: F1Colors.card,
      primaryColor: F1Colors.red,
      colorScheme: ColorScheme.dark(
        primary: F1Colors.red,
        surface: F1Colors.surface,
      ),
      textTheme: GoogleFonts.rajdhaniTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: F1Colors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.rajdhani(color: F1Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2),
      )
    );
  }
}
