import 'package:flutter/material.dart';
import '../enums/diagram_enum.dart';
import '../models/diagram_widget.dart';
import '../models/diagram_painter_config.dart';
import 'get_diagram_widget_list.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams({required this.size, required this.colorScheme});

  List<DiagramWidgetNEW> getDiagramWidgets({List<DiagramEnum>? diagrams}) {
    // Create config (same as AllDiagrams)
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );

    // Generate all diagram widgets
    final all = getDiagramWidgetsListNEW(config).toList();

    // If filtering by enum
    if (diagrams?.isNotEmpty ?? false) {
      // return all.where((w) => diagrams)
      // return all
      //     .where((w) => diagrams!.contains(w.basePainterDiagram.diagram))
      //     .toList();
    }

    // Otherwise return all
    return all;
  }
}
