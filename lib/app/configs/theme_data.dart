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
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    // Text color for typography
    final displayColor = isDark ? Colors.white : Colors.black;

    return ThemeData(
      fontFamily: GoogleFonts.robotoCondensed().fontFamily,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.defaultAppColor,
        secondary: AppColors.defaultAppColorDarker,
        tertiary: AppColors.defaultAppColorDarkest,

        /// Use [scrim] and [surfaceDim] for disabled
        scrim: isDark ? Colors.grey.shade900 : Colors.grey.shade400,
        surfaceDim: isDark ? Colors.grey.shade600 : Colors.grey.shade900,
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
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: AppColors.defaultAppColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.defaultAppColor,
          foregroundColor: Colors.white,
          disabledElevation: 0),
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
      switchTheme: const SwitchThemeData(),
      listTileTheme: ListTileThemeData(
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
        leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      // Adding the textTheme for display styles
      textTheme: GoogleFonts.robotoCondensedTextTheme().copyWith(
        displaySmall: TextStyle(color: displayColor),
        displayMedium: TextStyle(color: displayColor),
        displayLarge: TextStyle(color: displayColor),
        headlineSmall: TextStyle(color: displayColor),
        headlineMedium: TextStyle(color: displayColor),
        headlineLarge: TextStyle(color: displayColor),
        titleLarge: TextStyle(color: displayColor),
        bodySmall: TextStyle(color: displayColor),
        bodyMedium: TextStyle(color: displayColor),
        bodyLarge: TextStyle(color: displayColor),
      ),
      // IconButton theme
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return isDark
                  ? Colors.grey.shade700
                  : Colors.grey.shade400; // Disabled color with shading
            }
            return isDark ? Colors.white : Colors.black; // Enabled color
          }),
          shadowColor: WidgetStateProperty.resolveWith<Color>((states) {
            return isDark
                ? Colors.grey.shade900
                : Colors.grey.shade200; // Shadow for both light and dark theme
          }),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor:
              isDark ? Colors.grey.shade900 : Colors.grey.shade300,
          color: AppColors.defaultAppColor),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          fixedSize: WidgetStateProperty.all(
            Size.fromWidth(MediaQuery.of(context).size.width * 0.92),
          ), // Maximum allowable width
          visualDensity: VisualDensity.compact, // Compact height for menu items
        ),
        textStyle: TextStyle(fontSize: 14, color: displayColor),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors
                  .defaultAppColor, // Makes the default border invisible
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
