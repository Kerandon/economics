import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';

import 'package:flutter/material.dart';

import '../../paint_enums/world_trade_types.dart';

class WorldTradeExportSubsidies extends CustomPainter {
  final WorldTradeType type;
  final Color color;
  final Color highlightedColor;

  WorldTradeExportSubsidies(this.type,
      {this.color = Colors.white, this.highlightedColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    paintAxis(size, canvas, xAxisLabel: kXLabelWine, yAxisLabel: kYLabelWine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
