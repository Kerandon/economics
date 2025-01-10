import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';

class CircularFlowOfIncome extends BaseDiagramPainter {
  CircularFlowOfIncome({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintTextBox(
      c,
      canvas,
      lineColor: c.colorScheme.primary,
      text: kHouseholds,
      position: Offset(0.15, 0.50),
    );

    paintTextBox(
      c,
      canvas,
      lineColor: c.colorScheme.primary,
      text: kFirms,
      position: Offset(0.85, 0.50),
    );

    /// Factors of production to firms
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.10, 0.40),
      points: [
        CustomBezier(
          control: Offset(0.50, 0.10),
          endPoint: Offset(0.90, 0.40),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi * 0.85,
    );

    paintText(c, canvas, kLaborLandCapitalEntrepreneurship, Offset(0.50, 0.20));

    /// Factor payments to households
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.20, 0.40),
      points: [
        CustomBezier(
          control: Offset(0.50, 0.20),
          endPoint: Offset(0.80, 0.40),
        ),
      ],
      drawArrowOnStart: true,
      arrowOnStartAngle: pi * 1.15,
    );
    paintText(c, canvas, kWagesRentInterestProfit, Offset(0.50, 0.38));

    /// Household expenditure
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.20, 0.60),
      points: [
        CustomBezier(
          control: Offset(0.50, 0.80),
          endPoint: Offset(0.80, 0.60),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi * 0.15,
    );
    paintText(c, canvas, kHouseholdExpenditureFirmRevenue, Offset(0.50, 0.60));

    /// Sale of goods & services
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.10, 0.60),
      points: [
        CustomBezier(
          control: Offset(0.50, 0.90),
          endPoint: Offset(0.90, 0.60),
        ),
      ],
      drawArrowOnStart: true,
      arrowOnStartAngle: -pi * 0.15,
    );

    paintText(c, canvas, kSaleOfGoodsAndServices, Offset(0.50, 0.80));
  }
}
