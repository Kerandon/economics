import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/data/get_diagram_widget_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:economics_app/diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_painter_config.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/helper_methods/export_diagrams_to_pdf.dart';

class DiagramsPage extends ConsumerStatefulWidget {
  const DiagramsPage({super.key});

  @override
  ConsumerState<DiagramsPage> createState() => _DiagramsPageState();
}

class _DiagramsPageState extends ConsumerState<DiagramsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final ScrollController _mainScrollController = ScrollController();
  final Map<String, GlobalKey> _diagramKeys = {};

  @override
  void dispose() {
    _searchController.dispose();
    _mainScrollController.dispose();
    super.dispose();
  }

  String _getDiagramId(DiagramWidget d, int index) {
    final subunitId = d.painters.first.subunit?.id ?? "misc";
    final textId = d.painters.first.diagram.toText;
    return "${subunitId}_${textId}_$index";
  }

  void _scrollToDiagram(String diagramId) {
    final key = _diagramKeys[diagramId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.1,
      );
    } else {
      debugPrint("Cannot scroll to $diagramId - context is null");
    }
  }

  void _showDiagramDialog(
    BuildContext context,
    List<DiagramWidget> allDiagrams,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final size = MediaQuery.of(context).size;
            final theme = Theme.of(context);

            // 1. TREAT WIDGET AS DATA
            final data = allDiagrams[initialIndex];
            final title = data.title ?? data.painters.first.diagram.toText;

            // Fallback Description Logic
            final effectiveDescription =
                data.description ?? data.painters.first.diagram.description;

            final hasPrevious = initialIndex > 0;
            final hasNext = initialIndex < allDiagrams.length - 1;

            // 2. CALCULATE EXACT CONTENT WIDTH
            const double cardWidth = 516.0;
            final double layoutWidth = (data.axis == Axis.vertical)
                ? cardWidth
                : cardWidth * data.painters.length;

            // Define a common subtle button style
            final ButtonStyle subtleButtonStyle = IconButton.styleFrom(
              backgroundColor: theme.colorScheme.onSurface.withOpacity(0.05),
              hoverColor: theme.colorScheme.onSurface.withOpacity(0.1),
              highlightColor: theme.colorScheme.onSurface.withOpacity(0.2),
              foregroundColor: theme.colorScheme.onSurface.withOpacity(
                0.6,
              ), // Icon color
            );

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: (size.width * 0.95).clamp(0, 1600),
                    height: (size.height * 0.95).clamp(0, 1000),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // HEADER
                        Column(
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${initialIndex + 1} of ${allDiagrams.length}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // CONTENT AREA
                        Expanded(
                          child: Row(
                            children: [
                              // PREV BUTTON (SUBTLE)
                              IconButton(
                                style: subtleButtonStyle,
                                onPressed: hasPrevious
                                    ? () => setDialogState(() => initialIndex--)
                                    : null,
                                icon: const Icon(Icons.arrow_back_ios_new),
                              ),

                              const SizedBox(width: 8),

                              // CUSTOM DIAGRAM BUILDER
                              Expanded(
                                child: ClipRect(
                                  child: InteractiveViewer(
                                    key: ValueKey(initialIndex),
                                    minScale: 0.1,
                                    maxScale: 5.0,
                                    boundaryMargin: const EdgeInsets.all(
                                      double.infinity,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: SizedBox(
                                          // 3. APPLY EXACT WIDTH CONSTRAINT
                                          width: layoutWidth,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Description (Custom or Default)
                                              if (effectiveDescription
                                                  .isNotEmpty)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 24.0,
                                                        left: 8.0,
                                                        right: 8.0,
                                                      ),
                                                  child: Text(
                                                    effectiveDescription,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),

                                              // The Diagrams
                                              Flex(
                                                direction: data.axis,
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: data.painters.map((
                                                  painter,
                                                ) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Container(
                                                      width: 500,
                                                      height: 500,
                                                      color: Colors.white,
                                                      child: CustomPaint(
                                                        painter: painter,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              // NEXT BUTTON (SUBTLE)
                              IconButton(
                                style: subtleButtonStyle,
                                onPressed: hasNext
                                    ? () => setDialogState(() => initialIndex++)
                                    : null,
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CLOSE BUTTON (SUBTLE)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      style: subtleButtonStyle,
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isWideScreen = size.width > 900;

    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: theme.colorScheme,
    );

    final allDiagrams = getDiagramWidgetsListNEW(config);

    final filteredDiagrams = allDiagrams.where((d) {
      final enumTitle = d.painters.first.diagram.toText.toLowerCase();
      final displayTitle = d.title?.toLowerCase() ?? "";
      return enumTitle.contains(_searchQuery.toLowerCase()) ||
          displayTitle.contains(_searchQuery.toLowerCase());
    }).toList();

    final Map<Subunit, List<DiagramWidget>> diagramsBySubunit = {};
    for (var d in filteredDiagrams) {
      final subunit = d.painters.first.subunit ?? Subunit.whatIsEconomics;
      diagramsBySubunit.putIfAbsent(subunit, () => []).add(d);
    }

    final Map<UnitType, List<Subunit>> activeUnits = {};
    for (var subunit in Subunit.values) {
      if (diagramsBySubunit.containsKey(subunit)) {
        activeUnits.putIfAbsent(subunit.unit, () => []).add(subunit);
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SIDEBAR
          if (isWideScreen)
            Container(
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
                      onPressed: () =>
                          exportDiagramsToPdf(allDiagrams, config, context),
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
                              data: theme.copyWith(
                                dividerColor: Colors.transparent,
                              ),
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
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                      ),
                                      children: [
                                        for (final entry
                                            in diagramsBySubunit[subunit]!
                                                .asMap()
                                                .entries)
                                          ListTile(
                                            dense: true,
                                            visualDensity:
                                                VisualDensity.compact,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                  left: 36,
                                                  right: 16,
                                                ),
                                            minLeadingWidth: 0,
                                            leading: Icon(
                                              Icons.bar_chart,
                                              size: 16,
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                            // TEXT WRAPPING ENABLED
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
                                            onTap: () => _scrollToDiagram(
                                              _getDiagramId(
                                                entry.value,
                                                entry.key,
                                              ),
                                            ),
                                            hoverColor: theme
                                                .colorScheme
                                                .surfaceContainerHigh,
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
            ),

          // MAIN GALLERY AREA
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  controller: _mainScrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      backgroundColor: theme.colorScheme.surface,
                      toolbarHeight: 90,
                      title: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          margin: const EdgeInsets.only(top: 16),
                          child: SearchBar(
                            controller: _searchController,
                            hintText: "Search diagrams...",
                            leading: const Icon(Icons.search),
                            onChanged: (val) =>
                                setState(() => _searchQuery = val),
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all(
                              theme.colorScheme.surfaceContainerHigh,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(32, 10, 32, 100),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (filteredDiagrams.isEmpty)
                              Container(
                                height: 300,
                                alignment: Alignment.center,
                                child: Text(
                                  "No diagrams match your search.",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),

                            for (var unit in UnitType.values)
                              if (activeUnits.containsKey(unit))
                                _buildUnitSection(
                                  context,
                                  theme,
                                  unit,
                                  activeUnits[unit]!,
                                  diagramsBySubunit,
                                  filteredDiagrams,
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSection(
    BuildContext context,
    ThemeData theme,
    UnitType unit,
    List<Subunit> subunits,
    Map<Subunit, List<DiagramWidget>> diagramsBySubunit,
    List<DiagramWidget> fullFilteredList,
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
                  final id = _getDiagramId(diagram, index);

                  if (!_diagramKeys.containsKey(id)) {
                    _diagramKeys[id] = GlobalKey();
                  }

                  return Container(
                    key: _diagramKeys[id],
                    child: _buildGalleryTile(
                      context,
                      theme,
                      diagram,
                      fullFilteredList,
                    ),
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
    List<DiagramWidget> fullList,
  ) {
    final title = diagram.title ?? diagram.painters.first.diagram.toText;

    // FIX: Create a display-only version of the widget.
    // We strip the title and description so they don't affect the aspect ratio
    // or width calculation inside the FittedBox.
    final displayWidget = DiagramWidget(
      diagram.painters,
      axis: diagram.axis,
      title: null, // Title is already in the card footer
      description:
          null, // HIDE description in tile (only shown on tap in dialog)
    );

    final responsiveWidget = FittedBox(
      fit: BoxFit.contain,
      child: displayWidget,
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
        onTap: () {
          final index = fullList.indexOf(diagram);
          if (index != -1) {
            _showDiagramDialog(context, fullList, index);
          }
        },
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
                child: AbsorbPointer(child: Center(child: responsiveWidget)),
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
