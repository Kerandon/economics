import 'dart:ui';

import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/sections/diagrams/models/base_painter_painter.dart';

import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';

class MoneyMarket extends BaseDiagramPainter {
  MoneyMarket({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);


  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.interestRate.label,
      xAxisLabel: DiagramLabel.quantityOfMoney.label,
    );
  }
}
