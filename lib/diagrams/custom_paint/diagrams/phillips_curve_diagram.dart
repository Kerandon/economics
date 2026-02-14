import 'dart:ui';
import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class PhillipsCurveDiagram extends BaseDiagramPainter {
  PhillipsCurveDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.macroSRPC:
        _paintSRPC(c, canvas);
      default:
    }
  }
}

void _paintSRPC(DiagramPainterConfig c, IDiagramCanvas canvas) {}
