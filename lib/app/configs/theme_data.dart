import 'package:flutter/material.dart';

import '../state/app_state.dart';
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
        tertiary: AppColors.defaultAppColorDarkest,

        /// Use Scrim as a 'Not Selected' Color
        scrim: isDark ? const Color(0xFF2e2e2e) : const Color(0xFFcfcfcf),
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
        onSurface: isDark ? AppColors.onSurfaceDarkTheme : Colors.black,
        onSurfaceVariant: isDark
            ? AppColors.onSurfaceVariantDarkTheme
            : AppColors.onSurfaceVariantLightTheme,
        onError: isDark ? Colors.black : Colors.white,
        onSecondary: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        backgroundColor: AppColors.defaultAppColorDarkest,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.blue,
        iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.grey);
          },
        ),
      ),
    );
  }
}
