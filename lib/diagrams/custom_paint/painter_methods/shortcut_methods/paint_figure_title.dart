import 'package:economics_app/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../paint_text.dart';

void paintFigureTitle(
  DiagramPainterConfig c,
  Canvas canvas,
  String figIndex,
  String title,
) {
  paintText(
    c,
    canvas,
    'Fig. $figIndex: $title',
    style: TextStyle(fontStyle: FontStyle.italic),
    Offset(0.02, 0.96),
    alignment: TextAlignment.left,
  );
}
