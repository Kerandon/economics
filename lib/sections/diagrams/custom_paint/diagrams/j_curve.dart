import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_normalized_within_axis.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class JCurve extends BaseDiagramPainter {
  JCurve({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0),
      polylineOffsets: [Offset(0, 1)],
    );

    paintTextNormalizedWithinAxis(c, canvas, 'X > M\nSurplus', Offset(-0.05, 0.10),
      align: LabelAlign.centerLeft,
      );

    paintTextNormalizedWithinAxis(c, canvas, 'X = M\nBalance', Offset(-0.05, 0.50),
      align: LabelAlign.centerLeft,
    );

    paintTextNormalizedWithinAxis(c, canvas, 'X  < M\nDeficit', Offset(-0.05, 0.90),
      align: LabelAlign.centerLeft,
    );



    paintCustomBezier(c, canvas, startPos: Offset(kAxisIndent, 0.60), points: [
      CustomBezier(
        control: Offset(kAxisIndent + 0.10, 0.60),
        endPoint: Offset(kAxisIndent + 0.10, 0.60),
      ),
      CustomBezier(
        control: Offset(kAxisIndent + 0.40, 0.90),
        endPoint: Offset(kAxisIndent + 0.70, 0.20),
      ),
    ]);
  }
}
