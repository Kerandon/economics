import 'dart:ui';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../paint_text.dart';

void paintZero(DiagramPainterConfig config, Canvas canvas) {
  final padding = 0.02;
  paintText(
    config,
    canvas,
    '0',
    Offset(kAxisIndent * 1.5 - padding, 1 - kAxisIndent * 1.5 + padding),
  );
}
