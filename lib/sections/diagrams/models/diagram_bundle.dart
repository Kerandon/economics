
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import 'base_painter_painter.dart';
import 'diagram_model.dart';

class DiagramBundle {
  final List<BaseDiagramPainter> basePainterDiagrams;
  final List<DiagramModel> diagramModels;
  final UnitType? unit;
  final DiagramType? type;
  final String? label;
  final String? description;

  DiagramBundle({
    List<BaseDiagramPainter>? basePainterDiagrams,
    List<DiagramModel>? diagramModels,
    this.unit,
    this.type,
    this.label,
    this.description,
  })
      : basePainterDiagrams = basePainterDiagrams ?? [],
        diagramModels = diagramModels ?? [];

  DiagramBundle copyWith({
    List<BaseDiagramPainter>? basePainterDiagrams,
    List<DiagramModel>? diagramModels,
    UnitType? unit,
    DiagramType? type,
    String? label,
    String? description,
  }) {
    return DiagramBundle(
      basePainterDiagrams: basePainterDiagrams ?? this.basePainterDiagrams,
      diagramModels: diagramModels ?? this.diagramModels,
      unit: unit ?? this.unit,
      type: type ?? this.type,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }
}
