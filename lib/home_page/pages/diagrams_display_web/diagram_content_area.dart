import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_bundle.dart';
import 'diagram_bundle_widget.dart';

class DiagramsContentArea extends StatelessWidget {
  final List<UnitType> sortedUnits;
  final Map<UnitType, Map<Subunit, List<DiagramBundle>>> bundlesByUnit;
  final Map<String, GlobalKey> diagramKeys;
  final ScrollController scrollController;

  const DiagramsContentArea({
    super.key,
    required this.sortedUnits,
    required this.bundlesByUnit,
    required this.diagramKeys,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: LayoutBuilder(
            // Use LayoutBuilder to get the actual width inside the padding
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sortedUnits.expand((unit) {
                  final subunits = bundlesByUnit[unit]!;

                  final sortedSubunits = subunits.keys.toList()
                    ..sort((a, b) => _compareSubunits(a, b));

                  return sortedSubunits.expand((subunit) {
                    final bundles = subunits[subunit]!;

                    return bundles.map((bundle) {
                      final id =
                          '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';

                      return DiagramBundleWidgetWeb(
                        key:
                            diagramKeys[id], // Using the GlobalKey as the widget key
                        bundle: bundle,
                        id: id,
                        contentWidth:
                            contentWidth, // Pass the constrained width
                      );
                    });
                  });
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  // Helper to sort subunits (copied from original class)
  int _compareSubunits(Subunit a, Subunit b) {
    final aNum = double.tryParse(a.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final bNum = double.tryParse(b.id.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    return aNum.compareTo(bNum);
  }
}
