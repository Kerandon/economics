import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';

class PovertyCycleDiagram extends BaseDiagramPainter {
  PovertyCycleDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    final shape = DiagramShape.circle;

    // --- ARROWS ---

    // 1. Left (Savings) -> Top (Income)
    // Shifted Y up by 0.10 (0.50 -> 0.40)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.20, 0.40),
      bezierPoints: [
        CustomBezier(
          control: Offset(0.20, 0.05), // Shifted (0.15 -> 0.05)
          endPoint: Offset(0.50, 0.10), // Shifted (0.20 -> 0.10)
        ),
      ],
      normalizeToDiagramArea: false,
      flowArrow: DiagramFlowArrow.forward,
    );

    // 2. Top (Income) -> Right (Investment)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 0.10), // Shifted (0.20 -> 0.10)
      bezierPoints: [
        CustomBezier(
          control: Offset(0.80, 0.05), // Shifted (0.15 -> 0.05)
          endPoint: Offset(0.80, 0.40), // Shifted (0.50 -> 0.40)
        ),
      ],
      normalizeToDiagramArea: false,
      flowArrow: DiagramFlowArrow.forward,
    );

    // 3. Right (Investment) -> Bottom (Productivity)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.80, 0.40), // Shifted (0.50 -> 0.40)
      bezierPoints: [
        CustomBezier(
          control: Offset(0.80, 0.75), // Shifted (0.85 -> 0.75)
          endPoint: Offset(0.50, 0.70), // Shifted (0.80 -> 0.70)
        ),
      ],
      normalizeToDiagramArea: false,
      flowArrow: DiagramFlowArrow.forward,
    );

    // 4. Bottom (Productivity) -> Left (Savings)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 0.70), // Shifted (0.80 -> 0.70)
      bezierPoints: [
        CustomBezier(
          control: Offset(0.20, 0.75), // Shifted (0.85 -> 0.75)
          endPoint: Offset(0.20, 0.40), // Shifted (0.50 -> 0.40)
        ),
      ],
      normalizeToDiagramArea: false,
      flowArrow: DiagramFlowArrow.forward,
    );

    // --- TEXT LABELS ---

    paintText(
      c,
      canvas,
      'Low Income',
      Offset(0.20, 0.40), // Shifted Y
      ignoreIndent: true,
      shape: shape,
    );
    paintText(
      c,
      canvas,
      'Low Savings',
      Offset(0.50, 0.10), // Shifted Y
      ignoreIndent: true,
      shape: shape,
    );
    paintText(
      c,
      canvas,
      'Low Investment',
      Offset(0.80, 0.40), // Shifted Y
      ignoreIndent: true,
      shape: shape,
    );
    paintText(
      c,
      canvas,
      'Low Productivity',
      Offset(0.50, 0.70), // Shifted Y
      ignoreIndent: true,
      shape: shape,
    );

    // Description is automatically placed at the bottom area
    paintDescription(
      c,
      canvas,
      'The poverty cycle shows how poverty is a self-reinforcing system, transmitted from one generation to the next. Investment refers to spending on physical, human and natural capital',
    );
  }
}
