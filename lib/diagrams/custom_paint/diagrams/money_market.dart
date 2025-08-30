import 'dart:ui';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';

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
