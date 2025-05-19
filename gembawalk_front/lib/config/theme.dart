import 'package:flutter/material.dart';

// Primary Attijari theme colors
const attijariPrimary = Color(0xFFFF6600);
const attijariScaffoldBg = Color(0xFFFDF7F0);
const attijariWhite = Colors.white;
const attijariTextPrimary = Colors.black;
const attijariTextSecondary = Colors.grey;
const attijariGray3 = Color(0xFFE0E0E0);

// Main theme object
final ThemeData attijariTheme = ThemeData(
  scaffoldBackgroundColor: attijariScaffoldBg,
  colorScheme: ColorScheme.fromSeed(
    seedColor: attijariPrimary,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: attijariPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: attijariTextPrimary,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: attijariPrimary,
    foregroundColor: attijariWhite,
  ),
  useMaterial3: true,
);
