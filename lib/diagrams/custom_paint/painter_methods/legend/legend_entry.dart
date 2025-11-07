import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_shape.dart';

import '../../shade/shade_type.dart';

class LegendEntry {
  final String label;
  final Color color;
  final LegendShape shape;

  LegendEntry({
    required this.label,
    required this.color,
    this.shape = LegendShape.square, // Default shape
  });

  /// Convenience constructor for ShadeType with custom label and shape
  factory LegendEntry.fromShade(
      ShadeType shade, {
        String? customLabel, // Allows overriding the label
        LegendShape shape = LegendShape.square,
      }) {
    return LegendEntry(
      // Automatically uses the enum's defaultLabel if customLabel is null
      label: customLabel ?? shade.defaultLabel,
      // Automatically uses the enum's color
      color: shade.setShadeColor(),
      shape: shape,
    );
  }
}