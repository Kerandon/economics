import 'package:flutter/material.dart';
import '../enums/diagram_enum.dart';
import '../models/diagram_widget.dart';
import '../models/diagram_painter_config.dart';
import 'get_diagram_widget_list.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;
  final double indent;

  AllDiagrams({required this.size, required this.colorScheme, this.indent = 0.12});

  List<DiagramWidget> getDiagramWidgets({List<DiagramEnum>? diagrams}) {
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
      indent: indent,
    );

    final all = getDiagramWidgetsListNEW(config).toList();

    // If filtering by enum
    if (diagrams?.isNotEmpty ?? false) {
      return all.where((w) {
        // We check if ANY of the painters inside this widget match the requested enums.
        // NOTE: Replace `painters` and `diagram` with whatever you named
        // those variables inside your DiagramWidget and BasePainter classes!
        return w.painters.any((painter) => diagrams!.contains(painter.diagram));
      }).toList();
    }

    return all;
  }
}
