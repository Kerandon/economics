import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';

import '../custom_paint/flutter_diagram_canvas.dart';
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

  // --- Standard Flutter Entry Point ---
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Wrap the native Flutter canvas in your adapter
    final flutterBridge = FlutterDiagramCanvas(canvas);

    // 2. Call the shared drawing logic
    drawDiagram(flutterBridge, size);
  }

  // --- Unified Entry Point ---
  // Subclasses now receive ONE canvas object that works for both PDF and Flutter.
  void drawDiagram(IDiagramCanvas canvas, Size size);

  @override
  bool shouldRepaint(covariant BaseDiagramPainter3 oldDelegate) => true;
}
