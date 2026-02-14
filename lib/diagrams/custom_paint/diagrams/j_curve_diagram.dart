import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/axis_enum.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';

import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';

class JCurveDiagram extends BaseDiagramPainter {
  JCurveDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(c, canvas, axisType: AxisType.jCurve);
  }
}
