import '../enums/diagram_enum.dart';
import 'base_painter_painter.dart';

class DiagramWidget {
  final BaseDiagramPainter3 basePainterDiagram;
  DiagramWidget(this.basePainterDiagram);
}

/// Make redundant
class DiagramBundle {
  final DiagramEnum? diagramBundleEnum;
  final String? label; // Short title (e.g., "The Market")
  final String? caption; // Longer description (e.g., "P = AR = MR")
  /// redundant
  final String? title;
  final List<BaseDiagramPainter2> basePainterDiagrams;
  final String? description;

  // Positional parameters: required first, optional last
  DiagramBundle(
    this.diagramBundleEnum,
    this.basePainterDiagrams, {
    this.label,
    this.caption,

    ///redundant
    this.title,
    this.description,
  });

  DiagramBundle copyWith({
    DiagramEnum? diagramBundleEnum,
    String? label,
    String? caption,

    ///redundant remove
    String? title,
    List<BaseDiagramPainter2>? basePainterDiagrams,

    String? description,
  }) {
    return DiagramBundle(
      diagramBundleEnum ?? this.diagramBundleEnum,
      basePainterDiagrams ?? this.basePainterDiagrams,
      label: label ?? this.label,
      caption: caption ?? this.caption,

      ///redundant
      title: title ?? this.title ?? this.diagramBundleEnum?.name,
      description: description ?? this.description,
    );
  }
}
