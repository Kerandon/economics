import 'dart:ui';

import '../../models/base_painter_painter.dart';
import '../painter_methods/paint_axis.dart';

class PriceControls extends BaseDiagramPainter {
  PriceControls(super.config, super.model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(c, canvas);
  }


}