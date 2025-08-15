import 'package:economics_app/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';

class DiagramPainterConfig {
  final Size appSize;
  final Size painterSize;
  final ColorScheme colorScheme;

  const DiagramPainterConfig({
    required this.appSize,
    required this.painterSize,
    required this.colorScheme,
  });

  /// A getter that calculates the ratio of `painterSize` to `appSize`
  Size get sizeRatio {
    return Size(
      appSize.width == 0 ? 0 : painterSize.width / appSize.width,
      appSize.height == 0 ? 0 : painterSize.height / appSize.height,
    );
  }

  /// A getter that calculates the average ratio (normalized value)
  double get averageRatio {
    final ratio = sizeRatio;
    return (ratio.width + ratio.height) / 2;
  }

  DiagramPainterConfig copyWith({
    Size? appSize,
    Size? painterSize,
    ColorScheme? colorScheme,
    SizeAdjustor? adjustedSize,
  }) {
    return DiagramPainterConfig(
      appSize: appSize ?? this.appSize,
      painterSize: painterSize ?? this.painterSize,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
