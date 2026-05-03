import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Негізгі түстер
  static const Color primaryGreen = Color(0xFF00D09E);
  static const Color darkBackground = Color(0xFF121212);

  // Светлый тема
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      );

  // Темный тема
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: darkBackground,
          elevation: 0,
        ),
      );
}