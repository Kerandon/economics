import '../enums/diagram_bundle_enum.dart';
import 'base_painter_painter.dart';
import 'diagram_model.dart';

class DiagramBundle {
  final DiagramBundleEnum? diagramBundleEnum;
  final List<BaseDiagramPainter> basePainterDiagrams;
  final List<DiagramModel> diagramModels;


  DiagramBundle({
    this.diagramBundleEnum,
    List<BaseDiagramPainter>? basePainterDiagrams,
    List<DiagramModel>? diagramModels,

  })  :
        basePainterDiagrams = basePainterDiagrams ?? [],
        diagramModels = diagramModels ?? [];


  DiagramBundle copyWith({
    DiagramBundleEnum? diagramBundleEnum,
    List<BaseDiagramPainter>? basePainterDiagrams,
    List<DiagramModel>? diagramModels,
  }) {
    return DiagramBundle(
      diagramBundleEnum: diagramBundleEnum ?? this.diagramBundleEnum,
      basePainterDiagrams: basePainterDiagrams ?? this.basePainterDiagrams,
      diagramModels: diagramModels ?? this.diagramModels,

    );
  }
}
