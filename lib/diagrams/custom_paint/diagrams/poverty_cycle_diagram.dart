import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';

class PovertyCycleDiagram extends BaseDiagramPainter {
  PovertyCycleDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintText(c, canvas, 'Low Savings', Offset(0.15,0.50), ignoreIndent: true,
    shape: DiagramShape.diamond,
    );
  }
}
