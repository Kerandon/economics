import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../../diagrams/models/diagram_bundle.dart';

class DiagramBundleWidgetWeb extends StatelessWidget {
  final DiagramBundle bundle;
  final String id;
  final double contentWidth; // <-- ADDED: Correct width from LayoutBuilder

  const DiagramBundleWidgetWeb({
    super.key,
    required this.bundle,
    required this.id,
    required this.contentWidth, // <-- ADDED to constructor
  });

  @override
  Widget build(BuildContext context) {
    // The contentWidth is the exact width available inside the content area.

    // Calculate the size for the diagrams in the content area
    // Sizing for 2 diagrams side-by-side: reduced multiplier to prevent overflow
    final double sideBySideSize = contentWidth * 0.44;

    // Sizing for wrapped diagrams: increased divisor to prevent overflow
    final double wrapSize = contentWidth / 1.3;

    return Container(
      // The GlobalKey is associated via super.key
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              bundle.title ?? bundle.diagramBundleEnum?.toText ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 2),
          // --- Side-by-Side Layout for Bundles with 2 Diagrams ---
          if (bundle.basePainterDiagrams.length == 2)
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bundle.basePainterDiagrams
                    .map(
                      (d) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: sideBySideSize,
                      height: sideBySideSize,
                      child: CustomPaint(painter: d),
                    ),
                  ),
                )
                    .toList(),
              ),
            )
          // --- Wrapped Layout for other Bundles (1, 3, 4, etc.) ---
          else
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 2,
                runSpacing: 2,
                children: bundle.basePainterDiagrams
                    .map(
                      (d) => SizedBox(
                    width: wrapSize,
                    height: wrapSize,
                    child: CustomPaint(painter: d),
                  ),
                )
                    .toList(),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}