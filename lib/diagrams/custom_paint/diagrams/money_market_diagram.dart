import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';

class MoneyMarketDiagram extends BaseDiagramPainter3 {
  MoneyMarketDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      default:
    }
  }
}
