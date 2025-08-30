import '../enums/diagram_bundle_enum.dart';
import 'base_painter_painter.dart';

// class DiagramBundle {
//   final DiagramBundleEnum? diagramBundleEnum;
//   final String? title;
//   final List<BaseDiagramPainter> basePainterDiagrams;
//   final List<DiagramModel> diagramModels;
//
//   DiagramBundle({
//     this.diagramBundleEnum,
//     this.title,
//     List<BaseDiagramPainter>? basePainterDiagrams,
//     List<DiagramModel>? diagramModels,
//   }) : basePainterDiagrams = basePainterDiagrams ?? [],
//        diagramModels = diagramModels ?? [];
//
//   DiagramBundle copyWith({
//     DiagramBundleEnum? diagramBundleEnum,
//     String? title,
//     List<BaseDiagramPainter>? basePainterDiagrams,
//     List<DiagramModel>? diagramModels,
//   }) {
//     return DiagramBundle(
//       diagramBundleEnum: diagramBundleEnum ?? this.diagramBundleEnum,
//       title: title ?? this.diagramBundleEnum?.name,
//       basePainterDiagrams: basePainterDiagrams ?? this.basePainterDiagrams,
//       diagramModels: diagramModels ?? this.diagramModels,
//     );
//   }
// }
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
