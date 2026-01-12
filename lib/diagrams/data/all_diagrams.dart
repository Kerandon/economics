import 'package:flutter/material.dart';
import '../enums/diagram_enum.dart';
import '../models/diagram_widget.dart';
import '../models/diagram_painter_config.dart';
import 'get_diagram_widget_list.dart';

class AllDiagrams2 {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams2({required this.size, required this.colorScheme});

  List<DiagramWidget> getDiagramWidgets(List<DiagramEnum>? diagramEnums) {
    // Create config (same as AllDiagrams)
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );

    // Generate all diagram widgets
    final all = getDiagramWidgetList(config).toList();

    // If filtering by enum
    if (diagramEnums?.isNotEmpty ?? false) {
      return all
          .where((w) => diagramEnums!.contains(w.basePainterDiagram.diagram))
          .toList();
    }

    // Otherwise return all
    return all;
  }
}
//
// /// Mark Redundant
// class AllDiagrams {
//   final Size size;
//   final ColorScheme colorScheme;
//
//   AllDiagrams({required this.size, required this.colorScheme});
//
//   DiagramBundle? getDiagramBundle2(DiagramEnum diagramBundleEnum) {
//     final bundles = getDiagramBundles(diagramBundleEnums: [diagramBundleEnum]);
//     return bundles.isNotEmpty ? bundles.first : null;
//   }
//
//   List<DiagramBundle> getDiagramBundles({
//     List<DiagramEnum>? diagramBundleEnums, // optional filtering
//     bool getAll = false, // new param, default false
//   }) {
//     final config = DiagramPainterConfig(
//       painterSize: size,
//       appSize: Size(size.width, size.height),
//       colorScheme: colorScheme,
//     );
//
//     // Create bundles
//     final allBundles = getBundleList(config).toList();
//
//     if (getAll) {
//       // Return all bundles
//       return List.of(allBundles);
//     } else if (diagramBundleEnums?.isNotEmpty ?? false) {
//       // Filter by provided enums
//       return allBundles
//           .where(
//             (bundle) => diagramBundleEnums!.contains(bundle.diagramBundleEnum),
//           )
//           .toList();
//     } else {
//       // Default: no bundles returned
//       return [];
//     }
//   }
// }
