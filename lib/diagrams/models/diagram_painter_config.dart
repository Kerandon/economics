import 'package:economics_app/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';

class DiagramPainterConfig {
  final Size appSize;
  final Size painterSize;
  final ColorScheme colorScheme;

  // Cached values calculated once at initialization
  final Size sizeRatio;
  final double averageRatio;

  DiagramPainterConfig({
    required this.appSize,
    required this.painterSize,
    required this.colorScheme,
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
