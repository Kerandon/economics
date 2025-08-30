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
    String? customLabel,
    LegendShape shape = LegendShape.square,
  }) {
    return LegendEntry(
      label: customLabel ?? shade.defaultLabel,
      color: shade.setShadeColor(),
      shape: shape,
    );
  }
}
