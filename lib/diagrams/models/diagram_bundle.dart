import '../enums/diagram_bundle_enum.dart';
import 'base_painter_painter.dart';

class DiagramBundle {
  final DiagramBundleEnum? diagramBundleEnum;
  final String? title;
  final List<BaseDiagramPainter2> basePainterDiagrams;
  final String? description;

  // Positional parameters: required first, optional last
  DiagramBundle(this.diagramBundleEnum, this.basePainterDiagrams, {this.title, this.description});

  DiagramBundle copyWith({
    DiagramBundleEnum? diagramBundleEnum,
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
