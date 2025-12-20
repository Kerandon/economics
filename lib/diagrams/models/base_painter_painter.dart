import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';

import '../custom_paint/painter_methods/legend/legend_display.dart';
import '../mixins/mixins.dart';
import 'diagram_model.dart';
import 'diagram_painter_config.dart';

abstract class BaseDiagramPainter extends CustomPainter
    with DiagramIdentifierMixin {
  final DiagramPainterConfig config;
  @override
  final DiagramModel model;

  BaseDiagramPainter(this.config, this.model);
  @override
  bool shouldRepaint(covariant BaseDiagramPainter oldDelegate) {
    return true;
  }
}

/// Make redundant
abstract class BaseDiagramPainter2 extends CustomPainter
    with DiagramIdentifierMixin2 {
  final DiagramPainterConfig config;
  @override
  final DiagramEnum bundle;

  BaseDiagramPainter2(this.config, this.bundle);
  @override
  bool shouldRepaint(covariant BaseDiagramPainter oldDelegate) {
    // Return true if something has changed that should repaint
    return true;
  }
}

abstract class BaseDiagramPainter3 extends CustomPainter
    with DiagramIdentifierMixin3 {
  final DiagramPainterConfig config;
  @override
  final DiagramEnum diagram;

  BaseDiagramPainter3(this.config, this.diagram);

  @override
  bool shouldRepaint(covariant BaseDiagramPainter3 oldDelegate) {
    return true;
  }
}
