import 'package:car_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ThemesManager {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsManager.scaffoldColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.scaffoldColor,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
  );
}
