import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/axis_enum.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_text.dart';

class JCurveDiagram extends BaseDiagramPainter {
  JCurveDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(c, canvas, axisType: AxisType.jCurve);
    switch (diagram) {
      case DiagramEnum.globalJCurveDeficit:
        _paintJCurveDeficit(c, canvas);
        break;
      case DiagramEnum.globalJCurveSurplus:
        _paintJCurveSurplus(c, canvas);
        break;
      default:
    }
  }
}

_paintJCurveDeficit(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.60),
    bezierPoints: [
      CustomBezier(control: Offset(0.15, 0.60), endPoint: Offset(0.15, 0.60)),
      CustomBezier(control: Offset(0.45, 1.2), endPoint: Offset(0.80, 0.30)),
    ],
    label2: DiagramLabel.jCurve.label,
    label2Align: LabelAlign.right,
    textType: DiagramTextType.label,
  );
  paintText(
    c,
    canvas,
    'Depreciation/\nDevaluation',
    Offset(0.40, 0.60),
    pointerLine: Offset(0.15, 0.60),
    type: DiagramTextType.label,
  );
  paintText(
    c,
    canvas,
    'PEDX + PEDM > 1',
    Offset(0.4, 0.95),
    pointerLine: Offset(0.4, 0.84),
    type: DiagramTextType.label,
  );
}

_paintJCurveSurplus(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.40),
    bezierPoints: [
      CustomBezier(control: Offset(0.15, 0.40), endPoint: Offset(0.15, 0.40)),
      CustomBezier(control: Offset(0.45, -0.20), endPoint: Offset(0.80, 0.70)),
    ],
    label2: DiagramLabel.jCurve.label,
    label2Align: LabelAlign.right,
    textType: DiagramTextType.label,
  );
  paintText(
    c,
    canvas,
    'Appreciation/\nRevaluation',
    Offset(0.40, 0.40),
    pointerLine: Offset(0.15, 0.40),
    type: DiagramTextType.label,
  );
  paintText(
    c,
    canvas,
    'PEDX + PEDM > 1',
    Offset(0.4, 0.05),
    pointerLine: Offset(0.4, 0.16),
    type: DiagramTextType.label,
  );
}
