import 'package:flutter/material.dart';

class AppTheme {
  // Define the primary color
  static const primaryColor = Color(0xFFC42727);
  static const darkSurfaceColor = Color(0xFF1E1E1E);

  static ThemeData getTheme(ThemeMode mode) {
    return lightTheme;
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Colors
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFF8E8E93),
      surface: Colors.white,
      onSurface: darkSurfaceColor,
      tertiary: Color(0xFF7CBEC2),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w500),
      fillColor: Colors.grey.shade100,
      filled: true,
    ),

    // Message Bubbles
    cardTheme: CardThemeData(
      // ignore: deprecated_member_use
      color: primaryColor.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Icons
    iconTheme: const IconThemeData(color: Colors.black87),

    // Text Themes
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Inter'),
      titleMedium: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Inter'),
      labelMedium: TextStyle(color: Colors.grey, fontFamily: 'Inter'),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
