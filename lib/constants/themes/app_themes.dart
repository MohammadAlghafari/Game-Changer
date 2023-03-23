import 'package:flutter/material.dart';

import '../colors/colors.dart';

// App Theme Style

class AppThemes {
  // This is theme for app
  static ThemeData appTheme = ThemeData(
    primarySwatch: Colors.indigo,
    primaryColor: AppColors.blueColor,
    appBarTheme: const AppBarTheme(color: AppColors.whiteColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.whiteColor,
  );
}
