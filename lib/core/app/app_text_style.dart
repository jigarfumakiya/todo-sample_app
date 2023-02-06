import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font Family text style
  static TextStyle font15w500() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15);
  }

  static TextStyle font13w500() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1);
  }

  static TextStyle font15w400() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5);
  }

  static TextStyle font14w600() {
    return _interFont(
        color: AppColors.fontColor, fontSize: 16, fontWeight: FontWeight.w600);
  }

  static TextStyle font14w300() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25);
  }

  static TextStyle font12w400() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4);
  }

  static TextStyle font13w500Type2() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25);
  }

  static TextStyle font30w300() {
    return _interFont(
      color: AppColors.fontColor,
      fontSize: 30,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    );
  }

  static TextStyle font58w300() {
    return _interFont(
      color: AppColors.fontColor,
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5,
    );
  }

  static TextStyle font24w600() {
    return _interFont(
        color: AppColors.fontColor, fontSize: 24, fontWeight: FontWeight.w600);
  }

  static TextStyle font46w400() {
    return _interFont(
        color: AppColors.fontColor, fontSize: 44, fontWeight: FontWeight.w400);
  }

  static TextStyle font33w400() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 33,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w400);
  }

  static TextStyle font23w400() {
    return _interFont(
        color: AppColors.fontColor, fontSize: 23, fontWeight: FontWeight.w400);
  }

  static TextStyle font16w400() {
    return _interFont(
        color: AppColors.fontColor,
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15);
  }

  static TextStyle font16w600() {
    return _interFont(
        color: AppColors.fontColor, fontSize: 16, fontWeight: FontWeight.w600);
  }

  // In Future we need change font family then we need to change only line of coe
  static TextStyle _interFont({
    required FontWeight fontWeight,
    required double fontSize,
    required Color color,
    double letterSpacing = 1,
  }) {
    return GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        color: color,
        letterSpacing: letterSpacing);
  }
}
