import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
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
    // Return true if something has changed that should repaint
    return true;
  }
}

abstract class BaseDiagramPainter2 extends CustomPainter
    with DiagramIdentifierMixin2 {
  final DiagramPainterConfig config;
  @override
  final DiagramBundleEnum diagramBundleEnum;
  @override
  final LegendDisplay legendDisplay;

  BaseDiagramPainter2(
    this.config,
    this.diagramBundleEnum, {
    LegendDisplay? legendDisplay, // optional param
  }) : legendDisplay = legendDisplay ?? diagramBundleEnum.defaultLegendDisplay;

  @override
  bool shouldRepaint(covariant BaseDiagramPainter2 oldDelegate) => true;
}
