import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_custom_bezier.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_text_2.dart';

class JCurve extends BaseDiagramPainter {
  JCurve({required DiagramPainterConfig config, required DiagramModel model})
    : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintText2(
      c,
      canvas,
      DiagramLabel.tradeBalance.label,
      Offset(-0.08, -0.08),
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0),
      polylineOffsets: [Offset(0, 1)],
      arrowOnStart: true,
      arrowOnEnd: true,
      arrowOnEndAngle: pi,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.tradeSurplus.label,
      Offset(-0.05, 0.10),
    );

    paintText2(
      c,
      canvas,
      DiagramLabel.tradeBalanced.label,
      Offset(-0.05, 0.50),
    );

    paintText2(
      c,
      canvas,
      DiagramLabel.tradeDeficit.label,
      Offset(-0.05, 0.90),
    );
    if (model.subtype == DiagramSubtype.correctDeficit) {
      paintCustomBezier(
        c,
        canvas,
        startPos: Offset(kAxisIndent, 0.60),
        points: [
          CustomBezier(
            control: Offset(kAxisIndent + 0.10, 0.60),
            endPoint: Offset(kAxisIndent + 0.10, 0.60),
          ),
          CustomBezier(
            control: Offset(kAxisIndent + 0.40, 0.90),
            endPoint: Offset(kAxisIndent + 0.70, 0.20),
          ),
        ],
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.a.label,
        Offset(0.15, 0.82),
        pointerLine: Offset(0.15, 0.72),
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.b.label,
        Offset(0.40, 0.94),
        pointerLine: Offset(0.40, 0.84),
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.c.label,
        Offset(0.83, 0.60),
        pointerLine: Offset(0.83, 0.50),
      );
    }

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      polylineOffsets: [Offset(1, 0.50)],
      curveStyle: CurveStyle.dashed,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.time.label,
      Offset(1.0, 0.50),
    );
    if (model.subtype == DiagramSubtype.correctSurplus) {
      paintCustomBezier(
        c,
        canvas,
        startPos: Offset(kAxisIndent, 0.30),
        points: [
          CustomBezier(
            control: Offset(kAxisIndent + 0.10, 0.30),
            endPoint: Offset(kAxisIndent + 0.10, 0.30),
          ),
          CustomBezier(
            control: Offset(kAxisIndent + 0.40, 0.0),
            endPoint: Offset(kAxisIndent + 0.60, 0.60),
          ),
        ],
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.a.label,
        Offset(0.15, 0.18),
        pointerLine: Offset(0.15, 0.28),
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.b.label,
        Offset(0.40, 0.04),
        pointerLine: Offset(0.40, 0.14),
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.c.label,
        Offset(0.78, 0.40),
        pointerLine: Offset(0.78, 0.50),
      );
    }
  }
}
