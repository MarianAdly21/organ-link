import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

abstract class BaseAppTheme {
  ThemeData get themeDataLight;

  TextTheme get txtThemeLight;

  ThemeData get themeDataDark;

  TextTheme get txtThemeDark;

  String get fontFamily;
}

class LightAppTheme implements BaseAppTheme {
  /// The Light Theme
  @override
  ThemeData get themeDataLight {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.colorSchemeSeed,
        primary: AppColors.colorPrimary,
      ),
      primaryColor: AppColors.colorPrimary,
      brightness: Brightness.light,
      focusColor: AppColors.focus,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      fontFamily: fontFamily,
      textTheme: txtThemeLight,
      cardTheme: ThemeData.light(useMaterial3: false).cardTheme.copyWith(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: ThemeData.light(
        useMaterial3: false,
      ).iconTheme.copyWith(color: AppColors.iconTheme),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.floatActionBtnIcon,
        backgroundColor: AppColors.floatActionBtnBackground,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.bottomNavigationSelectedItem,
        unselectedItemColor: AppColors.bottomNavigationUnselectedItem,
        backgroundColor: AppColors.bottomNavigationBackground,
      ),
      appBarTheme: ThemeData.light(useMaterial3: false).appBarTheme.copyWith(
        iconTheme: ThemeData.light(
          useMaterial3: false,
        ).iconTheme.copyWith(color: AppColors.appBarIcon),
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: AppColors.appBarTextColor,
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
    );
  }

  @override
  TextTheme get txtThemeLight =>
      ThemeData.light(useMaterial3: false).textTheme.copyWith(
        // black cow color
        headlineMedium: ThemeData.light(useMaterial3: false)
            .textTheme
            .headlineMedium
            ?.copyWith(
              color: AppColors.headlineMedium,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
              fontSize: 22,
            ),

        // cloud burst color
        bodyMedium: ThemeData.light(useMaterial3: false).textTheme.bodyMedium
            ?.copyWith(
              color: AppColors.bodyMedium,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: fontFamily,
            ),
        // white color
        bodyLarge: ThemeData.light(useMaterial3: false).textTheme.bodyLarge
            ?.copyWith(
              color: AppColors.bodyLarge,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: fontFamily,
            ),

        // bluish color
        titleMedium: ThemeData.light(useMaterial3: false).textTheme.titleMedium
            ?.copyWith(
              color: AppColors.titleMedium,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
            ),

        displayMedium: ThemeData.light(useMaterial3: false)
            .textTheme
            .displayMedium
            ?.copyWith(
              color: AppColors.displayMedium,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
            ),

        // black cow color
        // for subtitle
        labelLarge: ThemeData.light(useMaterial3: false).textTheme.labelLarge
            ?.copyWith(
              color: AppColors.labelLarge,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
            ),

        // alto color
        labelMedium: ThemeData.light(useMaterial3: false).textTheme.labelMedium
            ?.copyWith(
              color: AppColors.grayText,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: fontFamily,
            ),

        // alto color
        labelSmall: ThemeData.light(useMaterial3: false).textTheme.labelSmall
            ?.copyWith(color: AppColors.labelSmall, fontFamily: fontFamily),

        titleSmall: ThemeData.light(useMaterial3: false).textTheme.bodySmall
            ?.copyWith(color: AppColors.titleSmall, fontFamily: fontFamily),

        displaySmall: ThemeData.light(useMaterial3: false)
            .textTheme
            .displaySmall
            ?.copyWith(color: AppColors.displaySmall, fontFamily: fontFamily),

        displayLarge: ThemeData.light(useMaterial3: false)
            .textTheme
            .displayLarge
            ?.copyWith(color: AppColors.displayLarge, fontFamily: fontFamily),

        // nobel color
        bodySmall: ThemeData.light(useMaterial3: false).textTheme.labelSmall
            ?.copyWith(color: AppColors.bodySmall, fontFamily: fontFamily),
        // cod Gray
        titleLarge: ThemeData.light(useMaterial3: false).textTheme.displaySmall
            ?.copyWith(color: AppColors.titleLarge, fontFamily: fontFamily),

        // dove Gray
        headlineLarge: ThemeData.light(useMaterial3: false)
            .textTheme
            .displayMedium
            ?.copyWith(color: AppColors.headlineLarge, fontFamily: fontFamily),
        // amaranth
        headlineSmall: ThemeData.light(useMaterial3: false)
            .textTheme
            .headlineSmall
            ?.copyWith(color: AppColors.headlineSmall, fontFamily: fontFamily),
      );

  @override
  ThemeData get themeDataDark => themeDataLight;

  @override
  TextTheme get txtThemeDark => txtThemeLight;

  @override
  String get fontFamily => "Inter";
}
