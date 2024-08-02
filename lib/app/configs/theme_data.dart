import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      fontFamily: GoogleFonts.robotoCondensed().fontFamily,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.defaultAppColor,
        secondary: AppColors.defaultAppColorDarker,
        tertiary: AppColors.defaultAppColorDarkest,

        /// Use Scrim as a 'Not Selected' Color
        scrim: isDark ? const Color(0xFF2e2e2e) : const Color(0xFFcfcfcf),
        surface: isDark
            ? AppColors.backgroundDarkTheme
            : AppColors.backgroundLightTheme,
        surfaceContainerHighest: isDark
            ? AppColors.surfaceVariantDarkTheme
            : AppColors.surfaceVariantLightTheme,
        surfaceTint:
            isDark ? AppColors.dialogDarkTheme : AppColors.dialogLightTheme,
        shadow: isDark ? AppColors.shadowDarkTheme : AppColors.shadowLightTheme,
        error: Colors.red,
        onPrimary: isDark ? Colors.black : Colors.white,
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
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: AppColors.defaultAppColorDarkest,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.blue,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.grey);
          },
        ),
      ),
    );
  }
}
