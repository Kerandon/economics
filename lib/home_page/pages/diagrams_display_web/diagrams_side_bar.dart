import 'package:economics_app/diagrams/data/all_diagrams.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/home_page/state_management/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_bundle.dart';

class DiagramsSidebar extends ConsumerWidget {
  final Map<UnitType, Map<Subunit, List<DiagramBundle>>> bundlesByUnit;
  final List<UnitType> sortedUnits;
  final Function(String) onDiagramSelected;

  const DiagramsSidebar({
    super.key,
    required this.bundlesByUnit,
    required this.sortedUnits,
    required this.onDiagramSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageState = ref.watch(homePageProvider);

    return Container(
      width: 350,
      color: Colors.grey[200],
      child: ListView(
        children: sortedUnits.map((unit) {
          final subunits = bundlesByUnit[unit]!;

          final sortedSubunits = subunits.keys.toList()
            ..sort((a, b) => _compareSubunits(a, b));

          return ExpansionTile(
            title: Text(
              '${unit.id} ${unit.title}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: sortedSubunits.map((subunit) {
              final diagrams = subunits[subunit]!;

              return ExpansionTile(
                title: Text('${subunit.id} ${subunit.title}'),
                initiallyExpanded: true,
                children: diagrams.map((bundle) {
                  final id =
                      '${unit.id}_${subunit.id}_${bundle.diagramBundleEnum?.toText}';
                  final isSelected = homePageState.selectedDiagramId == id;

                  return ListTile(
                    dense: true,
                    title: Text(bundle.diagramBundleEnum?.toText ?? ''),
                    selected: isSelected,
                    selectedTileColor: Colors.blue.shade100,
                    onTap: () => onDiagramSelected(id),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
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
