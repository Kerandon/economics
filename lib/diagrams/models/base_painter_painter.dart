import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';

import '../custom_paint/i_diagram_canvas.dart';
import '../custom_paint/painter_methods/legend/legend_display.dart';
import '../enums/unit_type.dart';
import '../mixins/mixins.dart';
import 'diagram_model.dart';
import 'diagram_painter_config.dart';

abstract class BaseDiagramPainter3 extends CustomPainter
    with DiagramIdentifierMixin3 {
  final DiagramPainterConfig config;

  @override
  final DiagramEnum diagram;
  final Subunit subunit;

  BaseDiagramPainter3(this.config, this.diagram) : subunit = diagram.subunit;

  // Standard Flutter entry point
  @override
  void paint(Canvas canvas, Size size) {
    drawDiagram(canvas, size);
  }

  // PDF/Bridge entry point
  // We use Canvas? so it can be null during PDF generation
  void drawDiagram(Canvas? canvas, Size size, {IDiagramCanvas? iCanvas}) {
    // This is where your subclasses (Supply, Demand, etc.) will
    // put their drawing logic.
  }

  @override
  bool shouldRepaint(covariant BaseDiagramPainter3 oldDelegate) => true;
}
