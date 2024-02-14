import 'package:economics_app/state/app_state.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomAppTheme {
  final AppState state;
  final BuildContext context;

  CustomAppTheme(this.state, this.context);

  ThemeData get appTheme {
    bool isDark = state.isDarkTheme;
    Brightness brightness = Brightness.dark;
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.defaultAppColor,
        secondary: AppColors.defaultAppColorDarker,
        // isDark
        //     ? AppColors.onSurfaceDarkTheme
        //     : AppColors.onSurfaceLightTheme,
        tertiary: AppColors.defaultAppColorDarkest,

        // isDark
        //     ? AppColors.onSurfaceDarkTheme
        //     : AppColors.onSurfaceLightTheme,
        background: isDark
            ? AppColors.backgroundDarkTheme
            : AppColors.backgroundLightTheme,
        surface:
            isDark ? AppColors.surfaceDarkTheme : AppColors.surfaceLightTheme,
        surfaceVariant: isDark
            ? AppColors.surfaceVariantDarkTheme
            : AppColors.surfaceVariantLightTheme,
        surfaceTint:
            isDark ? AppColors.dialogDarkTheme : AppColors.dialogLightTheme,
        shadow: isDark ? AppColors.shadowDarkTheme : AppColors.shadowLightTheme,
        error: Colors.red,
        onPrimary: isDark ? Colors.black : Colors.white,
        onBackground: isDark ? Colors.white : Colors.black,
        onSurface: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
        onSurfaceVariant: isDark
            ? AppColors.onSurfaceVariantDarkTheme
            : AppColors.onSurfaceVariantLightTheme,
        onError: isDark ? Colors.black : Colors.white,
        onSecondary: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
      ),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          backgroundColor: AppColors.defaultAppColorDarkest),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
