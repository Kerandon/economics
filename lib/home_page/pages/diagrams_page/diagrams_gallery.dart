import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_widget.dart';
// Import your models (UnitType, Subunit, DiagramWidget, etc.)
import 'package:flutter/material.dart';
// Import your models

class DiagramsGallery extends StatelessWidget {
  final Map<UnitType, List<Subunit>> activeUnits;
  final Map<Subunit, List<DiagramWidget>> diagramsBySubunit;
  final List<DiagramWidget> filteredDiagrams;
  final Function(DiagramWidget) onCardTap;
  final Function(DiagramWidget, int) getDiagramKey; // Helper to pass keys back

  const DiagramsGallery({
    super.key,
    required this.activeUnits,
    required this.diagramsBySubunit,
    required this.filteredDiagrams,
    required this.onCardTap,
    required this.getDiagramKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (filteredDiagrams.isEmpty) {
      return Container(
        height: 300,
        alignment: Alignment.center,
        child: Text(
          "No diagrams match your search.",
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var unit in UnitType.values)
          if (activeUnits.containsKey(unit))
            _buildUnitSection(context, theme, unit, activeUnits[unit]!),
      ],
    );
  }

  Widget _buildUnitSection(
    BuildContext context,
    ThemeData theme,
    UnitType unit,
    List<Subunit> subunits,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48.0, bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.title.toUpperCase(),
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  color: theme.colorScheme.onSurface,
                  fontSize: 28,
                ),
              ),
              Container(
                height: 6,
                width: 80,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
        for (var subunit in subunits)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.label_important,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${subunit.id} ${subunit.title}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemCount: diagramsBySubunit[subunit]!.length,
                itemBuilder: (ctx, index) {
                  final diagram = diagramsBySubunit[subunit]![index];
                  // Assign key via callback
                  final key = getDiagramKey(diagram, index);

                  return Container(
                    key: key as Key?, // Cast depending on your implementation
                    child: _buildGalleryTile(context, theme, diagram),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
      ],
    );
  }

  Widget _buildGalleryTile(
    BuildContext context,
    ThemeData theme,
    DiagramWidget diagram,
  ) {
    final title = diagram.title ?? diagram.painters.first.diagram.toText;

    // Display-only version (no description)
    final displayWidget = DiagramWidget(
      diagram.painters,
      axis: diagram.axis,
      title: null,
      description: null,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => onCardTap(diagram),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12.withOpacity(0.05)),
                ),
                padding: const EdgeInsets.all(12),
                child: AbsorbPointer(
                  child: Center(
                    child: FittedBox(fit: BoxFit.contain, child: displayWidget),
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.open_in_full,
                    size: 18,
                    color: theme.colorScheme.primary.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
