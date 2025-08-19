import 'package:flutter/material.dart';
import '../models/diagram_bundle.dart';

class DiagramBundleWidget extends StatelessWidget {
  final DiagramBundle diagramBundle;

  const DiagramBundleWidget({
    super.key,
    required this.diagramBundle,
    this.fitAll = true,
  });

  final bool fitAll;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (diagramBundle.basePainterDiagrams.isEmpty) {
      return const SizedBox.shrink(); // No diagrams to show
    }

    final maxDimension = size.width < size.height ? size.width : size.height;
    final maxAllowedSize = maxDimension * 0.90;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InteractiveViewer(
        maxScale: 5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                diagramBundle.basePainterDiagrams.length == 1
                    ? Center(
                        child: SizedBox(
                          width: maxAllowedSize,
                          height: maxAllowedSize,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                            ),
                            child: CustomPaint(
                              painter: diagramBundle.basePainterDiagrams.first,
                              size: Size(maxAllowedSize, maxAllowedSize),
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: diagramBundle.basePainterDiagrams.map((
                            diagram,
                          ) {
                            int count = 1;
                            if (fitAll) {
                              count = diagramBundle.basePainterDiagrams.length;
                            }
                            final individualSize =
                                (maxAllowedSize)
                                    .clamp(50, maxAllowedSize)
                                    .toDouble() /
                                count;

                            return Padding(
                              padding: EdgeInsets.all(
                                fitAll ? 0 : size.width * 0.03,
                              ),
                              child: SizedBox(
                                width: individualSize,
                                height: individualSize,
                                child: CustomPaint(
                                  painter:
                                      diagram,
                                  size: Size(individualSize, individualSize),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
