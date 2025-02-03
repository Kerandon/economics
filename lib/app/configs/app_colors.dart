import 'package:flutter/material.dart';

class AppColors {
  static const defaultAppColor = Color(0xff008080);
  static const defaultAppColorDarker = Color(0xff003931);
  static const defaultAppColorDarkest = Color(0xff00322B);

  static const backgroundLightTheme = Color(0xfff5f5f5);
  static const backgroundDarkTheme = Color(0xFF121212);

  static const surfaceVariantDarkTheme = Color(0xFF808080);
  static const surfaceVariantLightTheme = Color(0xFF808080);

  static const onBackgroundLightTheme = Colors.black;
  static const onBackgroundDarkTheme = Colors.white;

  static const onSurfaceLightTheme = Color(0xff5c5e60);
  static const onSurfaceDarkTheme = Color(0xFFBDBDBD);

  static const onSurfaceVariantLightTheme = Color(0xFFFAFAFA); // Off-white
  static const onSurfaceVariantDarkTheme = Color(0xFF121212); // Off-black
// Light theme colors: Closer to white, softer contrast (unchanged)
  static const surfaceOffWhiteLightTheme = Color(0xFFF5F5F5); // Very light, almost white
  static const surfaceLightThemeStronger = Color(0xFFEEEEEE); // Slightly darker for subtle contrast

// Dark theme colors: More greyish-black for better contrast
  static const surfaceOffBlackDarkTheme = Color(0xFF181818); // More greyish-black
  static const surfaceDarkThemeStronger = Color(0xFF242424); // Even more greyish-black for contrast

// Light theme shadow: Soft and subtle (unchanged)
  static const shadowLightTheme = Color(0x1A000000); // Black with 10% opacity (0x1A)

// Dark theme shadow: Soft and subtle (unchanged)
  static const shadowDarkTheme = Color(0x1AFFFFFF); // White with 10% opacity (0x1A)
}
