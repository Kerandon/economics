import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import 'base_painter_painter.dart';

import 'package:flutter/material.dart';

class DiagramWidget extends StatelessWidget {
  final List<BaseDiagramPainter> painters;
  final String? title;
  final String? description;
  final Axis axis;

  const DiagramWidget(
    this.painters, {
    super.key,
    this.title,
    this.description,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDescription =
        description ?? painters.first.diagram.description;

    // 🆕 Calculate the exact width this widget needs.
    // Each painter is strictly 500 wide + 8 horizontal padding on each side = 516.
    // This forces the Column to have a defined width, allowing Text to wrap
    // and FittedBox to scale the whole block cleanly.
    final double calculatedWidth = axis == Axis.horizontal
        ? painters.length * 516.0
        : 516.0;

    return SizedBox(
      width: calculatedWidth, // 🆕 The magic fix
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Optional Title
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
          ],

          // 2. Description (Custom OR Default)
          if (effectiveDescription.isNotEmpty) ...[
            Text(
              effectiveDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],

          // 3. The Diagrams
          Flex(
            direction: axis,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: painters.map((painter) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 500,
                    minHeight: 500,
                    maxWidth: 500,
                    maxHeight: 500,
                  ),
                  child: CustomPaint(painter: painter),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
