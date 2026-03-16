import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}