import 'package:flutter/material.dart';

import '../utils/mixins.dart';
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
    // Return true if something has changed that should repaint
    return true;
  }

}
