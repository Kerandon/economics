import 'package:economics_app/app/enums/font_size.dart';
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

    final displayColor = isDark ? Colors.white : Colors.black;
    final defaultTextTheme = isDark
        ? Typography.material2021().white
        : Typography.material2021().black;

    return ThemeData(
      fontFamily: GoogleFonts.robotoCondensed().fontFamily,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.defaultAppColor,
        secondary: AppColors.defaultAppColorDarker,
        tertiary: AppColors.defaultAppColorDarkest,
        scrim: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        surfaceDim: isDark ? Colors.grey.shade600 : Colors.grey.shade900,
        surface: isDark
            ? AppColors.surfaceDarkTheme
            : Colors.white.withAlpha(245),
        surfaceContainerHighest: isDark
            ? AppColors.surfaceDarkTheme
            : AppColors.surfaceLightTheme,
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
          color: isDark ? Colors.white : Colors.black,
          fontSize: 20,
        ),
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
        disabledElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.blue,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),
      switchTheme: const SwitchThemeData(),
      listTileTheme: ListTileThemeData(
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
        leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
      ),

      textTheme: GoogleFonts.robotoCondensedTextTheme(defaultTextTheme)
          .copyWith(
            displaySmall: defaultTextTheme.displaySmall?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.displaySmall?.fontSize ??
                  36 * state.fontSize.multiplier,
            ),
            displayMedium: defaultTextTheme.displayMedium?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.displayMedium?.fontSize ??
                  45 * state.fontSize.multiplier,
            ),
            displayLarge: defaultTextTheme.displayLarge?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.displayLarge?.fontSize ??
                  57 * state.fontSize.multiplier,
            ),
            headlineSmall: defaultTextTheme.headlineSmall?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.headlineSmall?.fontSize ??
                  24 * state.fontSize.multiplier,
            ),
            headlineMedium: defaultTextTheme.headlineMedium?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.headlineMedium?.fontSize ??
                  28 * state.fontSize.multiplier,
            ),
            headlineLarge: defaultTextTheme.headlineLarge?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.headlineLarge?.fontSize ??
                  32 * state.fontSize.multiplier,
            ),
            titleSmall: defaultTextTheme.titleSmall?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.titleSmall?.fontSize ??
                  14 * state.fontSize.multiplier,
            ),
            titleMedium: defaultTextTheme.titleMedium?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.titleMedium?.fontSize ??
                  16 * state.fontSize.multiplier,
            ),
            titleLarge: defaultTextTheme.titleLarge?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.titleLarge?.fontSize ??
                  24 * state.fontSize.multiplier,
            ),
            bodySmall: defaultTextTheme.bodySmall?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.bodySmall?.fontSize ??
                  16 * state.fontSize.multiplier,
            ),
            bodyMedium: defaultTextTheme.bodyMedium?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.bodyMedium?.fontSize ??
                  18 * state.fontSize.multiplier,
            ),
            bodyLarge: defaultTextTheme.bodyLarge?.copyWith(
              color: displayColor,
              fontSize:
                  defaultTextTheme.bodyLarge?.fontSize ??
                  22 * state.fontSize.multiplier,
            ),
          ),

      // IconButton theme
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return isDark ? Colors.grey.shade700 : Colors.grey.shade400;
            }
            return isDark ? Colors.white : Colors.black;
          }),
          shadowColor: WidgetStateProperty.resolveWith<Color>((states) {
            return isDark ? Colors.grey.shade900 : Colors.grey.shade200;
          }),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearTrackColor: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
        color: AppColors.defaultAppColor,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          fixedSize: WidgetStateProperty.all(
            Size.fromWidth(MediaQuery.of(context).size.width * 0.92),
          ),
          visualDensity: VisualDensity.compact,
        ),
        textStyle: TextStyle(fontSize: 14, color: displayColor),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.defaultAppColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: isDark
            ? AppColors.dividerDarkTheme
            : AppColors.dividerLightTheme,
        unselectedLabelColor: isDark
            ? AppColors.onSurfaceDarkTheme
            : AppColors.onSurfaceLightTheme,
        unselectedLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.defaultAppColor, width: 2.0),
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
