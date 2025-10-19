import '../enums/diagram_bundle_enum.dart';
import 'base_painter_painter.dart';

class DiagramBundle {
  final DiagramBundleEnum? diagramBundleEnum;
  final String? title;
  final List<BaseDiagramPainter2> basePainterDiagrams;

  // Positional parameters: required first, optional last
  DiagramBundle(this.diagramBundleEnum, this.basePainterDiagrams, [this.title]);

  DiagramBundle copyWith({
    DiagramBundleEnum? diagramBundleEnum,
    String? title,
    List<BaseDiagramPainter2>? basePainterDiagrams,
  }) {
    return DiagramBundle(
      diagramBundleEnum ?? this.diagramBundleEnum,
      basePainterDiagrams ?? this.basePainterDiagrams,
      title ?? this.title ?? this.diagramBundleEnum?.name,
    );
  }
}
