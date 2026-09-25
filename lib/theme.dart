import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_find_job/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static const margin = 16.0;

  static const primary = Color(0xFFD6322F);
  static const success = Color(0xFF3C9B5F);
  static const warning = Color(0xFFE56A3D);
  static const error = Color(0xFFC62828);
  static const info = Color(0xFF8B6B57);
  static const paper = Color(0xFFFFFCF7);
  static const warmSurface = Color(0xFFF7F3EC);

  static ThemeMode mode = ThemeMode.system;

  static SystemUiOverlayStyle get systemStyle => const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get systemStyleLight => systemStyle.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get systemStyleDark => systemStyle.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: const Color(0xFF0D0D0D),
        systemNavigationBarIconBrightness: Brightness.light,
      );

  static void setSystemStyle() {
    switch (mode) {
      case ThemeMode.system:
        if (Screen.mediaQuery.platformBrightness == Brightness.dark) {
          SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        } else {
          SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        }
        break;
      case ThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        break;
      case ThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        break;
    }
  }

  static ThemeData get light {
    var scheme = ColorScheme.light(
      surfaceContainer: warmSurface,
      surface: paper,
      onSurface: const Color(0xFF191716),
      primary: primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFFE3A63A),
      onSecondary: Colors.white,
      tertiary: const Color(0xFFF1E9DC),
      outline: const Color(0xFFE9E0D5),
      shadow: const Color(0xFF8A5B3D).withValues(alpha: 0.08),
      error: error,
      onError: Colors.white,
    );
    return _getTheme(scheme);
  }

  static ThemeData get dark {
    var scheme = ColorScheme.dark(
      surfaceContainer: const Color(0xFF0D0D0D),
      surface: const Color(0xFF252525),
      onSurface: Colors.white,
      primary: primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFFFFB800),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF141414),
      outline: const Color(0xFF252525),
      shadow: const Color(0xFF777777).withValues(alpha: 0.08),
      error: error,
      onError: Colors.white,
    );
    return _getTheme(scheme);
  }

  static ThemeData _getTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surfaceContainer,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: scheme.brightness == Brightness.light
            ? scheme.surface
            : scheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
      backgroundColor: scheme.surfaceContainer,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 56.w,
        iconTheme: IconThemeData(
          color: scheme.onSurface,
          size: 22.w,
        ),
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 24.w,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        toolbarTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 22.w,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16.w,
          color: scheme.onSurface,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.w,
          height: 1.2,
          color: scheme.onSurface,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: scheme.surfaceContainer,
        unselectedItemColor: scheme.onSurface.withValues(alpha: 0.5),
        selectedItemColor: scheme.primary,
        unselectedLabelStyle: TextStyle(fontSize: 13.w, height: 1.6),
        selectedLabelStyle: TextStyle(fontSize: 13.w, height: 1.6),
        unselectedIconTheme: IconThemeData(
          size: 24.w,
          color: scheme.onSurface.withValues(alpha: 0.5),
        ),
        selectedIconTheme: IconThemeData(
          size: 24.w,
          color: scheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        filled: true,
        fillColor: scheme.surface,
        labelStyle: TextStyle(
          fontSize: 16.w,
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        helperStyle: TextStyle(
          fontSize: 14.w,
          color: scheme.onSurface.withValues(alpha: 0.7),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 14.w,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.primary, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(100.w)),
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1.w,
        color: scheme.onSurface.withValues(alpha: 0.08),
      ),
    );
  }
}
