import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/app/app_text_style.dart';

// For more info
//
// https://m2.material.io/design/typography/the-type-system.html#type-scale
class AppTheme {
  static ThemeData get theme {
    ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: Colors.blueAccent,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Colors.blueAccent),
      scaffoldBackgroundColor: AppColors.primaryColor,

      // scaffoldBackgroundColor: Colors.white,
      cardColor: AppColors.primaryColor,
      dialogBackgroundColor: AppColors.primaryColor,
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkColor: MaterialStateProperty.all(AppColors.independenceColor),
        fillColor: MaterialStateProperty.all(AppColors.fillColor),
        side: MaterialStateBorderSide.resolveWith((states) =>
            const BorderSide(width: 1.0, color: AppColors.gainsboro)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),

      textTheme: GoogleFonts.interTextTheme().copyWith(
        headline1: AppTextStyles.font30w300(),
        headline2: AppTextStyles.font58w300(),
        headline3: AppTextStyles.font46w400(),
        headline4: AppTextStyles.font33w400(),
        headline5: AppTextStyles.font23w400(),
        headline6: AppTextStyles.font16w400(),
        subtitle1: AppTextStyles.font15w500(),
        subtitle2: AppTextStyles.font13w500(),
        bodyText1: AppTextStyles.font15w400(),
        bodyText2: AppTextStyles.font14w300(),
        caption: AppTextStyles.font12w400(),
        button: AppTextStyles.font13w500Type2(),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }
}
