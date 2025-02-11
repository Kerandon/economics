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
        scrim: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        surfaceDim: isDark ? Colors.grey.shade600 : Colors.grey.shade900,
        surface:
            isDark ? AppColors.surfaceDarkTheme : AppColors.surfaceLightTheme,
        surfaceContainerHighest:
            isDark ? AppColors.surfaceDarkTheme : AppColors.surfaceLightTheme,
        surfaceTint: isDark
            ? AppColors.surfaceDarkThemeStronger
            : AppColors.surfaceLightThemeStronger,
        shadow: isDark ? AppColors.shadowDarkTheme : AppColors.shadowLightTheme,
        error: Colors.red,
        onPrimary: isDark ? Colors.black : Colors.white,
        onSurface: isDark ? AppColors.onSurfaceDarkTheme : Colors.black,
        onSurfaceVariant: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
        onError: isDark ? Colors.black : Colors.white,
        onSecondary: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black, fontSize: 20),
        backgroundColor: isDark
            ? AppColors.surfaceDarkThemeStronger
            : AppColors.surfaceLightThemeStronger,
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
        titleSmall: TextStyle(color: displayColor),
        titleMedium: TextStyle(color: displayColor),
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
      tabBarTheme: TabBarThemeData(
        dividerColor:
            isDark ? AppColors.dividerDarkTheme : AppColors.dividerLightTheme,
        unselectedLabelColor: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
        // Active tab style
        unselectedLabelStyle:
            TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        // Inactive tab style
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.defaultAppColor,
              width: 2.0, // Indicator thickness
            ),
          ),
        ),
        labelStyle: TextStyle(
          color: AppColors.defaultAppColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
