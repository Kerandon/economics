
import 'package:flutter/material.dart';

class DiagramPainterConfig {
  final Size appSize;
  final Size painterSize;
  final ColorScheme colorScheme;
  final double indent;

  // Cached values calculated once at initialization
  final Size sizeRatio;
  final double averageRatio;

  DiagramPainterConfig({
    required this.appSize,
    required this.painterSize,
    required this.colorScheme,
    this.indent = 0.15,
  }) : sizeRatio = Size(
         appSize.width == 0 ? 0 : painterSize.width / appSize.width,
         appSize.height == 0 ? 0 : painterSize.height / appSize.height,
       ),
       averageRatio = (appSize.width == 0 || appSize.height == 0)
           ? 0
           : ((painterSize.width / appSize.width) +
                     (painterSize.height / appSize.height)) /
                 2;

  DiagramPainterConfig copyWith({
    Size? appSize,
    Size? painterSize,
    ColorScheme? colorScheme,
  }) {
    return DiagramPainterConfig(
      appSize: appSize ?? this.appSize,
      painterSize: painterSize ?? this.painterSize,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
