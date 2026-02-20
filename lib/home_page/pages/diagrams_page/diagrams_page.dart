import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/data/get_diagram_widget_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:economics_app/diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_painter_config.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/helper_methods/export_diagrams_to_pdf.dart';
import 'diagrams_gallery.dart';
import 'diagrams_side_bar.dart';

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

  // Helper to generate IDs
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
    }
  }

  // --- UPDATED DIALOG LOGIC ---
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
            final data = allDiagrams[initialIndex];
            final title = data.title ?? data.painters.first.diagram.toText;

            final effectiveDescription =
                data.description ?? data.painters.first.diagram.description;

            final hasPrevious = initialIndex > 0;
            final hasNext = initialIndex < allDiagrams.length - 1;

            // 1. Fixed Card Width logic matches the Container size below
            const double cardWidth = 516.0;
            final double layoutWidth = (data.axis == Axis.vertical)
                ? cardWidth
                : cardWidth * data.painters.length;

            final subtleButtonStyle = IconButton.styleFrom(
              backgroundColor: theme.colorScheme.onSurface.withOpacity(0.05),
              hoverColor: theme.colorScheme.onSurface.withOpacity(0.1),
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
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${initialIndex + 1} of ${allDiagrams.length}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                style: subtleButtonStyle,
                                onPressed: hasPrevious
                                    ? () => setDialogState(() => initialIndex--)
                                    : null,
                                icon: const Icon(Icons.arrow_back_ios_new),
                              ),
                              const SizedBox(width: 8),

                              // --- GRAPH AREA ---
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
                                          width: layoutWidth,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (effectiveDescription
                                                  .isNotEmpty)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 24,
                                                        left: 8,
                                                        right: 8,
                                                      ),
                                                  child: Text(
                                                    effectiveDescription,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              Flex(
                                                direction: data.axis,
                                                mainAxisSize: MainAxisSize.min,
                                                // Center alignment helps distribute extra space if any
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: data.painters.map((
                                                  painter,
                                                ) {
                                                  // --- FIX IS HERE ---
                                                  // Removed external Padding widget.
                                                  // Added padding INSIDE the Container.
                                                  return Container(
                                                    width: 500,
                                                    height: 500,
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    // This shrinks the canvas to 436x436
                                                    // leaving 32px of safe space for overflow
                                                    padding:
                                                        const EdgeInsets.all(
                                                          32.0,
                                                        ),
                                                    color: Colors.white,
                                                    child: CustomPaint(
                                                      painter: painter,
                                                      // Ensure we don't clip the overflow
                                                      foregroundPainter: null,
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

    // Config & Data Loading
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: theme.colorScheme,
    );
    final allDiagrams = getDiagramWidgetsListNEW(config);

    // Filtering
    final filteredDiagrams = allDiagrams.where((d) {
      final enumTitle = d.painters.first.diagram.toText.toLowerCase();
      final displayTitle = d.title?.toLowerCase() ?? "";
      return enumTitle.contains(_searchQuery.toLowerCase()) ||
          displayTitle.contains(_searchQuery.toLowerCase());
    }).toList();

    // Grouping
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
          // SIDEBAR (Standalone Widget)
          if (isWideScreen)
            DiagramsSidebar(
              activeUnits: activeUnits,
              diagramsBySubunit: diagramsBySubunit,
              onExportPdf: () =>
                  exportDiagramsToPdf(allDiagrams, config, context),
              onDiagramTap: (d, index) =>
                  _scrollToDiagram(_getDiagramId(d, index)),
            ),

          // MAIN CONTENT
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  controller: _mainScrollController,
                  slivers: [
                    // SEARCH BAR (Sliver)
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

                    // GALLERY (Standalone Widget)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(32, 10, 32, 100),
                      sliver: SliverToBoxAdapter(
                        child: DiagramsGallery(
                          activeUnits: activeUnits,
                          diagramsBySubunit: diagramsBySubunit,
                          filteredDiagrams: filteredDiagrams,
                          // Pass key generation logic
                          getDiagramKey: (d, i) {
                            final id = _getDiagramId(d, i);
                            if (!_diagramKeys.containsKey(id)) {
                              _diagramKeys[id] = GlobalKey();
                            }
                            return _diagramKeys[id]!;
                          },
                          onCardTap: (diagram) {
                            final index = allDiagrams.indexOf(diagram);
                            if (index != -1) {
                              _showDiagramDialog(context, allDiagrams, index);
                            }
                          },
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
}
