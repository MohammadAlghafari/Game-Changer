import '../colors/colors.dart';
import '../fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// These class to define the text styles in the app
class AppTextStyles {
  // Nunito Font TextStyle
  static TextStyle nunitoRegular({double fontSize = 14, Color color = AppColors.blackColor}) => TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontFamily: AppFonts.nunitoFamily,
      fontWeight: FontWeight.w400);
  static TextStyle nunitoBold({double fontSize = 16, Color color = AppColors.blackColor}) => TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontFamily: AppFonts.nunitoFamily,
      fontWeight: FontWeight.bold);

}
