import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_solid_line.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
  bool makeDashed = true,
  Color? color,
}) {
  final c = color ?? config.colorScheme.onSurface;
  final normalize = 1 - (kAxisIndent * 1.50);
  final yPos = yAxisStartPos * normalize + (kAxisIndent / 2);
  final xEndPosNormalized =
      xAxisEndPos * (1 - (kAxisIndent * 1.5)) + kAxisIndent;
  final xLabelY = 1 - kAxisIndent * normalize;
  if (!hideYLine) {
    final p1 = Offset(kAxisIndent, yPos);
    final p2 = Offset(xEndPosNormalized, yPos);

    if (makeDashed) {
      paintDashedLine(config, canvas, p1: p1, p2: p2, color: c);
    } else {
      paintSolidLine(config, canvas, p1: p1, p2: p2, color: c);
    }
  }
  if (yLabel != null) {
    paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      Offset(0, yPos),
      CustomAxis.y,
    );
  }

  if (!hideXLine) {
    paintDashedLine(
      config,
      canvas,
      p1: Offset(xEndPosNormalized, yPos),
      p2: Offset(xEndPosNormalized, 1 - kAxisIndent),
    );
  }
  if (xLabel != null) {
    paintTextForDashedLines(
      config,
      canvas,
      xLabel,
      Offset(xEndPosNormalized, xLabelY),
      CustomAxis.x,
    );
  }
}

void paintTextForDashedLines(
  DiagramPainterConfig config,
  Canvas canvas,
  String label,
  Offset position,
  CustomAxis axis, {
  double fontSize = kFontSize,
}) {
  fontSize *= config.averageRatio;

  final width = config.painterSize.width;
  final height = config.painterSize.height;

  final textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(color: config.colorScheme.onSurface, fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: width);

  Offset offset;
  switch (axis) {
    case CustomAxis.x:
      offset = Offset(
        position.dx * width - textPainter.width / 2,
        height - (kAxisIndent * height) + (textPainter.height / 4),
        //position.dy * height - kAxisIndent / 2 + (textPainter.height / 2),
      );
      break;
    case CustomAxis.y:
      offset = Offset(
        position.dx -
            textPainter.width +
            (kAxisIndent * width) -
            (width * 0.015),
        position.dy * height - textPainter.height / 2,
      );
      break;
  }

  canvas.save();
  textPainter.paint(canvas, offset);
  canvas.restore();
}

enum CustomAxis { x, y }
