import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../diagrams/data/all_diagrams.dart';
import '../diagrams/models/diagram_bundle.dart';


class AllDiagramsPage extends StatefulWidget {
  const AllDiagramsPage({super.key});

  @override
  State<AllDiagramsPage> createState() => _AllDiagramsPageState();
}

class _AllDiagramsPageState extends State<AllDiagramsPage> {
  final Map<DiagramType, int> _selectedBundleIndex = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final allBundles =
        AllDiagrams(size: size, colorScheme: Theme.of(context).colorScheme)
            .getDiagramBundles();

    // Group bundles by DiagramType
    final Map<DiagramType, List<DiagramBundle>> sortedBundles = {};
    for (var b in allBundles) {
      if (b.type != null) {
        sortedBundles.putIfAbsent(b.type!, () => []).add(b);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Diagrams'),
      ),
      body: ListView(
        children: sortedBundles.entries.map((entry) {
          final type = entry.key;
          final bundles = entry.value;

          // Currently selected index for this type
          final selectedIndex = _selectedBundleIndex[type] ?? 0;
          final selectedBundle = bundles[selectedIndex];

          return ExpansionTile(
            title: Text(type.toText()),
            childrenPadding: const EdgeInsets.all(16.0),
            children: [
              // Diagram rendering
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ...selectedBundle.diagramModels.map((diagram) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: size.width * 0.30,
                            height: size.width * 0.30,
                            child: CustomPaint(
                              painter: diagram.painter,
                            ),
                          ),
                        ],
                      );
                    }),
                    if (selectedBundle.description != null || selectedBundle.diagramModels.first.description != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: size.width * 0.8),
                          child: HtmlWidget(selectedBundle.description ?? selectedBundle.diagramModels.first.description ?? ''),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              // Chips to select bundles by subtype
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List.generate(bundles.length, (index) {
                  final bundle = bundles[index];
                  final label = bundle.label ?? bundle.basePainterDiagrams
                          .map((d) => d.model.subtype?.toText() ?? '')
                          .join(' & ') ;

                  return CustomChipButton(
                    label: label,
                    selected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedBundleIndex[type] = index;
                      });
                    },

                  );
                }),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
