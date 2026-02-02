import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/data/get_diagram_widget_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// FIX 1: Use 'package:' import here to match the other imports.
// Mixing relative (../../) and package imports causes Type Mismatches in Maps.
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
  final Map<Subunit, GlobalKey> _subunitKeys = {};

  @override
  void initState() {
    super.initState();
    for (var subunit in Subunit.values) {
      _subunitKeys[subunit] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mainScrollController.dispose();
    super.dispose();
  }

  void _scrollToSubunit(Subunit subunit) {
    final key = _subunitKeys[subunit];
    // With SliverToBoxAdapter (below), the context is much more likely to be available
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.05, // Aligns to top with slight padding
      );
    } else {
      debugPrint(
        "Context not found for ${subunit.name} - widget might not be built.",
      );
    }
  }

  void _openFullScreen(
    BuildContext context,
    Widget diagramWidget,
    String title,
    String heroTag,
  ) {
    final theme = Theme.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
            title: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          body: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.1,
            maxScale: 5.0,
            child: Center(
              child: Hero(
                tag: heroTag,
                child: FittedBox(fit: BoxFit.contain, child: diagramWidget),
              ),
            ),
          ),
        ),
      ),
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
      final title = d.basePainterDiagrams.first.diagram.toText.toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    // Grouping Logic
    final Map<Subunit, List<DiagramWidget>> diagramsBySubunit = {};
    for (var d in filteredDiagrams) {
      final subunit =
          d.basePainterDiagrams.first.subunit ?? Subunit.whatIsEconomics;
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
              width: 280,
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
                      heroTag: 'pdf_export_btn',
                      onPressed: () =>
                          exportDiagramsToPdf(allDiagrams, config, context),
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      label: const Text("Export PDF"),
                      elevation: 0,
                      backgroundColor: theme.colorScheme.primaryContainer,
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
                                  Icons.folder_open,
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
                                    ListTile(
                                      visualDensity: VisualDensity.compact,
                                      dense: true,
                                      contentPadding: const EdgeInsets.only(
                                        left: 54,
                                        right: 16,
                                      ),
                                      title: Text(
                                        subunit.title,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      onTap: () => _scrollToSubunit(subunit),
                                      hoverColor: theme
                                          .colorScheme
                                          .surfaceContainerHigh,
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

          // MAIN CONTENT
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: CustomScrollView(
                  controller: _mainScrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: false,
                      snap: true,
                      backgroundColor: Colors.transparent,
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
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),

                      // FIX 2: Switched from SliverList to SliverToBoxAdapter + Column.
                      // SliverList lazily renders items (widgets off-screen don't exist).
                      // This meant GlobalKeys for Macro diagrams (at the bottom) were null, breaking scroll.
                      // Column renders all children, ensuring scroll targets always exist.
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
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Row(
            children: [
              Container(width: 8, height: 40, color: theme.colorScheme.primary),
              const SizedBox(width: 16),
              Text(
                unit.title.toUpperCase(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        for (var subunit in subunits)
          Card(
            key: _subunitKeys[subunit], // The key is now always mounted
            margin: const EdgeInsets.only(bottom: 32),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: theme.colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              shape: const Border(),
              title: Text(
                '${subunit.id} ${subunit.title}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              childrenPadding: const EdgeInsets.all(24),
              children: [
                Wrap(
                  spacing: 32,
                  runSpacing: 48,
                  alignment: WrapAlignment.center,
                  children: diagramsBySubunit[subunit]!.asMap().entries.map((
                    entry,
                  ) {
                    final index = entry.key;
                    final diagram = entry.value;
                    final uniqueTag =
                        "${unit.name}_${subunit.id}_${index}_${diagram.basePainterDiagrams.first.diagram.toText}";

                    return _buildDiagramCard(
                      context,
                      diagram,
                      theme,
                      uniqueTag,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDiagramCard(
    BuildContext context,
    DiagramWidget diagram,
    ThemeData theme,
    String heroTag,
  ) {
    final isPair = diagram.widget.length > 1;
    final title = isPair
        ? "${diagram.basePainterDiagrams.first.diagram.toText} & ${diagram.basePainterDiagrams.last.diagram.toText}"
        : diagram.basePainterDiagrams.first.diagram.toText;

    Widget contentWidget;
    if (isPair) {
      contentWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var w in diagram.widget)
            SizedBox(width: 400, height: 400, child: w),
        ],
      );
    } else {
      contentWidget = SizedBox(
        width: 400,
        height: 400,
        child: diagram.widget.first,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            InkWell(
              onTap: () =>
                  _openFullScreen(context, contentWidget, title, heroTag),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                child: Hero(tag: heroTag, child: contentWidget),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filledTonal(
                onPressed: () =>
                    _openFullScreen(context, contentWidget, title, heroTag),
                icon: const Icon(Icons.fullscreen),
                tooltip: "View Full Screen",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
