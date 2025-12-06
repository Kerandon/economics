import '../enums/diagram_bundle_enum.dart';
import 'base_painter_painter.dart';

class DiagramWidget {
  final BaseDiagramPainter3 basePainterDiagram;
  DiagramWidget(this.basePainterDiagram);
}

/// Make redundant
class DiagramBundle {
  final DiagramEnum? diagramBundleEnum;
  final String? title;
  final List<BaseDiagramPainter2> basePainterDiagrams;
  final String? description;

  // Positional parameters: required first, optional last
  DiagramBundle(
    this.diagramBundleEnum,
    this.basePainterDiagrams, {
    this.title,
    this.description,
  });

  DiagramBundle copyWith({
    DiagramEnum? diagramBundleEnum,
    String? title,
    List<BaseDiagramPainter2>? basePainterDiagrams,
    String? description,
  }) {
    return DiagramBundle(
      diagramBundleEnum ?? this.diagramBundleEnum,
      basePainterDiagrams ?? this.basePainterDiagrams,
      title: title ?? this.title ?? this.diagramBundleEnum?.name,
      description: description ?? this.description,
    );
  }
}
