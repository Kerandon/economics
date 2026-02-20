import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_widget.dart';
// Import your models (UnitType, Subunit, DiagramWidget, etc.)

class DiagramsSidebar extends StatelessWidget {
  final Map<UnitType, List<Subunit>> activeUnits;
  final Map<Subunit, List<DiagramWidget>> diagramsBySubunit;
  final Function(DiagramWidget, int) onDiagramTap;
  final VoidCallback onExportPdf;

  const DiagramsSidebar({
    super.key,
    required this.activeUnits,
    required this.diagramsBySubunit,
    required this.onDiagramTap,
    required this.onExportPdf,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        border: Border(
          right: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: FloatingActionButton.extended(
              heroTag: 'pdf_export',
              onPressed: onExportPdf,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text("Export PDF"),
              backgroundColor: theme.colorScheme.primaryContainer,
              elevation: 0,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                for (var unit in UnitType.values)
                  if (activeUnits.containsKey(unit))
                    Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        leading: Icon(
                          Icons.folder,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(
                          unit.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          for (var subunit in activeUnits[unit]!)
                            ExpansionTile(
                              initiallyExpanded: false,
                              tilePadding: const EdgeInsets.only(
                                left: 20,
                                right: 16,
                              ),
                              title: Text(
                                "${subunit.id} ${subunit.title}",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              children: [
                                for (final entry
                                    in diagramsBySubunit[subunit]!
                                        .asMap()
                                        .entries)
                                  ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: const EdgeInsets.only(
                                      left: 36,
                                      right: 16,
                                    ),
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.bar_chart,
                                      size: 16,
                                      color: theme.colorScheme.secondary,
                                    ),
                                    title: Text(
                                      entry.value.title ??
                                          entry
                                              .value
                                              .painters
                                              .first
                                              .diagram
                                              .toText,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(height: 1.3),
                                    ),
                                    onTap: () =>
                                        onDiagramTap(entry.value, entry.key),
                                    hoverColor:
                                        theme.colorScheme.surfaceContainerHigh,
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
