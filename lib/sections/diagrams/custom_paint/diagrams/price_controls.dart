import 'dart:ui';

import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/models/base_painter_painter.dart';

class PriceControls extends BaseDiagramPainter {
  PriceControls(super.config, super.model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(c, canvas);
  }


}