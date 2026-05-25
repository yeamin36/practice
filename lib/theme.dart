import 'package:currency_converter/App_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 3, 6, 85), // Deep Blue
      Color.fromARGB(255, 47, 3, 148),
      Color.fromARGB(255, 42, 109, 209),
    ],
  );

  static OutlineInputBorder _border([Color? color]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Colors.white24,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF1A1A2F),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(Color(0xFF4A90E2)),
      errorBorder: _border(AppPallete.errorColor),
      filled: true,
      fillColor: Color(0xFF2A2A40),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.poppins(
        fontSize: 32.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 36.0,
        color: Colors.white.withOpacity(0.9),
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  );

  static BoxDecoration get gradientBackground => BoxDecoration(
        gradient: primaryGradient,
      );
}
