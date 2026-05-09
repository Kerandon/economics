import 'dart:ui' as pw;

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:printing/printing.dart';

import 'package:economics_app/home_page/pages/quick_notes/quick_notes_pdf_builder.dart';
import 'package:economics_app/home_page/pages/quick_notes/slides/global_slides.dart';
import 'package:economics_app/home_page/pages/quick_notes/slides/macro_slides.dart';
import 'package:economics_app/home_page/pages/quick_notes/slides/micro_slides.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

class QuickNotesPage extends StatefulWidget {
  const QuickNotesPage({super.key});

  @override
  State<QuickNotesPage> createState() => _QuickNotesPageState();
}

class _QuickNotesPageState extends State<QuickNotesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _microScroll = ScrollController();
  final ScrollController _macroScroll = ScrollController();
  final ScrollController _globalScroll = ScrollController();

  final Map<String, GlobalKey> _sectionKeys = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Listen to tab changes to rebuild the left menu with the correct chapters
    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _microScroll.dispose();
    _macroScroll.dispose();
    _globalScroll.dispose();
    super.dispose();
  }

  ScrollController _getControllerForIndex(int index) {
    if (index == 0) return _microScroll;
    if (index == 1) return _macroScroll;
    return _globalScroll;
  }

  void _navigateToUnit(int tabIndex, String sectionKey) {
    if (_tabController.index != tabIndex) {
      _tabController.animateTo(tabIndex);
    }

    // Reduced delay since we no longer wait for a Drawer to close
    Future.delayed(const Duration(milliseconds: 100), () {
      final key = _sectionKeys[sectionKey];
      final renderBox = key?.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final controller = _getControllerForIndex(tabIndex);
        final offset = renderBox.localToGlobal(
          Offset.zero,
          ancestor: context.findRenderObject(),
        );

        final target = controller.offset + offset.dy - kToolbarHeight - 48;

        controller.animateTo(
          target.clamp(0.0, controller.position.maxScrollExtent),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutExpo,
        );
      }
    });
  }

  // Helper properties to get current unit info
  List<Slide> get _currentUnitSlides {
    if (_tabController.index == 0) return microSlides;
    if (_tabController.index == 1) return macroSlides;
    return globalSlides;
  }

  String get _currentUnitName {
    if (_tabController.index == 0) return 'Microeconomics';
    if (_tabController.index == 1) return 'Macroeconomics';
    return 'Global Economy';
  }

  // Filter methods updated to accept a target list of slides (respecting the current unit)
  List<Slide> _getRweOnlySlides(List<Slide> targetSlides) {
    final filteredSlides = <Slide>[];

    for (var slide in targetSlides) {
      if (slide.contents == null) continue;

      final filteredContents = slide.contents!
          .where(
            (block) =>
                block.realWorldExamples != null &&
                block.realWorldExamples!.isNotEmpty,
          )
          .map(
            (block) => SlideContent(realWorldExamples: block.realWorldExamples),
          )
          .toList();

      if (filteredContents.isNotEmpty) {
        filteredSlides.add(
          Slide(
            subunit: slide.subunit,
            title: slide.title,
            question: slide.question,
            tags: slide.tags,
            contents: filteredContents,
          ),
        );
      }
    }
    return filteredSlides;
  }

  List<Slide> _getTermsOnlySlides(List<Slide> targetSlides) {
    final filteredSlides = <Slide>[];

    for (var slide in targetSlides) {
      if (slide.contents == null) continue;

      final filteredContents = slide.contents!
          .where(
            (block) => block.econTerms != null && block.econTerms!.isNotEmpty,
          )
          .map((block) => SlideContent(econTerms: block.econTerms))
          .toList();

      if (filteredContents.isNotEmpty) {
        filteredSlides.add(
          Slide(
            subunit: slide.subunit,
            title: slide.title,
            question: slide.question,
            tags: slide.tags,
            contents: filteredContents,
          ),
        );
      }
    }
    return filteredSlides;
  }

  // Generic PDF Generation Handler
  Future<void> _generatePdf(
    List<Slide> slides,
    String title,
    String filename,
  ) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Generating $title...')));

    final allDiagramsService = AllDiagrams(
      size: const Size(1000, 1000),
      colorScheme: Theme.of(context).colorScheme,
    );

    try {
      final pdfBytes = await exportQuickNotesToPdf(
        slides,
        allDiagramsService,
        (progress, status) => debugPrint('PDF Progress: $status'),
        title,
      );

      await Printing.sharePdf(bytes: pdfBytes, filename: filename);
    } catch (e) {
      debugPrint('PDF Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error generating PDF: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Revision Toolkit'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.picture_as_pdf_rounded,
              color: Colors.redAccent,
            ),
            tooltip: 'Export Revision Booklets',
            onSelected: (value) {
              switch (value) {
                case 'current_unit':
                  _generatePdf(
                    _currentUnitSlides,
                    'Revision Booklet ($_currentUnitName)',
                    'IB_Econ_${_currentUnitName.replaceAll(' ', '_')}.pdf',
                  );
                  break;
                case 'all_units':
                  _generatePdf(
                    [...microSlides, ...macroSlides, ...globalSlides],
                    'Full Revision Booklet',
                    'IB_Economics_Full_Revision.pdf',
                  );
                  break;
                case 'rwe':
                  _generatePdf(
                    _getRweOnlySlides(_currentUnitSlides),
                    'Real World Examples ($_currentUnitName)',
                    'IB_Econ_RWE_${_currentUnitName.replaceAll(' ', '_')}.pdf',
                  );
                  break;
                case 'terms':
                  _generatePdf(
                    _getTermsOnlySlides(_currentUnitSlides),
                    'Economics Terms ($_currentUnitName)',
                    'IB_Econ_Terms_${_currentUnitName.replaceAll(' ', '_')}.pdf',
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'current_unit',
                child: ListTile(
                  leading: const Icon(Icons.menu_book, color: Colors.indigo),
                  title: Text('Export $_currentUnitName'),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'all_units',
                child: ListTile(
                  leading: Icon(Icons.library_books, color: Colors.indigo),
                  title: Text('Export All Units'),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'rwe',
                child: ListTile(
                  leading: const Icon(Icons.public, color: Colors.green),
                  title: Text('Export RWE ($_currentUnitName)'),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              PopupMenuItem<String>(
                value: 'terms',
                child: ListTile(
                  leading: const Icon(Icons.spellcheck, color: Colors.orange),
                  title: Text('Export Terms ($_currentUnitName)'),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'MICRO'),
            Tab(text: 'MACRO'),
            Tab(text: 'GLOBAL'),
          ],
        ),
      ),
      body: Row(
        children: [
          // 1. MODERN LEFT SCROLL MENU
          _buildLeftMenu(),

          const VerticalDivider(width: 1, thickness: 1, color: Colors.black12),

          // 2. MAIN CONTENT
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSlideFeed(microSlides, 0, _microScroll),
                _buildSlideFeed(macroSlides, 1, _macroScroll),
                _buildSlideFeed(globalSlides, 2, _globalScroll),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- NEW: Modern Left Side Menu ---
  Widget _buildLeftMenu() {
    final List<Subunit> subunits = [];
    final Set<String> seenSubunits = {};

    for (var s in _currentUnitSlides) {
      if (!seenSubunits.contains(s.subunit.name)) {
        subunits.add(s.subunit);
        seenSubunits.add(s.subunit.name);
      }
    }

    return Container(
      width: 260,
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
            child: Text(
              'CHAPTERS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.indigo.shade300,
                letterSpacing: 2.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subunits.length,
              itemBuilder: (context, index) {
                final sub = subunits[index];
                return InkWell(
                  onTap: () => _navigateToUnit(
                    _tabController.index,
                    '${_tabController.index}_${sub.name}',
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sub.id,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            sub.title,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideFeed(
    List<Slide> slides,
    int tabIndex,
    ScrollController controller,
  ) {
    if (slides.isEmpty) return const Center(child: Text('No notes available.'));

    return ListView.builder(
      controller: controller,
      cacheExtent: 10000,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      itemCount: slides.length,
      itemBuilder: (context, index) {
        final slide = slides[index];
        final previousSlide = index > 0 ? slides[index - 1] : null;

        final bool isNewSection =
            previousSlide == null ||
            previousSlide.subunit.name != slide.subunit.name;
        final String sectionKey = '${tabIndex}_${slide.subunit.name}';

        if (isNewSection) {
          _sectionKeys[sectionKey] = GlobalKey();
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              key: isNewSection ? _sectionKeys[sectionKey] : null,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isNewSection) _buildModernSectionHeader(slide),
                _buildSlideCard(context, slide),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlideCard(BuildContext context, Slide slide) {
    final String heading = slide.question ?? slide.title;
    final Set<String> seenHeaders = {};

    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading.isNotEmpty) ...[
            Text(
              heading,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (slide.contents != null)
            ...slide.contents!.map(
              (block) => _buildContentBlock(context, block, seenHeaders),
            ),
        ],
      ),
    );
  }

  Widget _buildModernSectionHeader(Slide slide) {
    final bool isHL = slide.tags.contains(Tag.hl);
    final String label =
        '${slide.subunit.id} ${slide.subunit.title}'.toUpperCase() +
        (isHL ? ' [HL]' : '');

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isHL ? Colors.purple.shade50 : Colors.indigo.shade50,
              border: Border(
                left: BorderSide(
                  color: isHL ? Colors.purple : Colors.indigo,
                  width: 4,
                ),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isHL ? Colors.purple.shade900 : Colors.indigo.shade900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Divider(thickness: 1.5, color: Colors.black12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBlock(
    BuildContext context,
    SlideContent block,
    Set<String> seenHeaders,
  ) {
    List<Widget> widgets = [];

    void tryAddHeader(String title) {
      if (!seenHeaders.contains(title)) {
        widgets.add(
          Container(
            margin: const EdgeInsets.only(bottom: 12.0, top: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              border: const Border(
                left: BorderSide(color: Colors.indigo, width: 4),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.indigo.shade900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
        seenHeaders.add(title);
      }
    }

    // 1. TERMS
    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      tryAddHeader('TERMS');
      widgets.add(
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.8),
          },
          children: block.econTerms!.asMap().entries.map((entry) {
            final isEven = entry.key % 2 == 0;
            return TableRow(
              decoration: BoxDecoration(
                color: isEven ? Colors.white : Colors.grey.shade50,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entry.value.termName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    entry.value.explanation,
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    }

    // 2. MAIN CONTENT
    if (block.content != null && block.content!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: HtmlWidget(
            block.content!.text,
            textStyle: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      );
    }

    // 3. REAL WORLD EXAMPLES
    if (block.realWorldExamples != null &&
        block.realWorldExamples!.isNotEmpty) {
      tryAddHeader('REAL WORLD EXAMPLES');
      for (final topic in block.realWorldExamples!) {
        if (topic.examples.isEmpty) continue;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              topic.topicName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        );
        widgets.add(
          Table(
            border: TableBorder.all(color: Colors.grey.shade300, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(2.5),
            },
            children: topic.examples.asMap().entries.map((entry) {
              final isEven = entry.key % 2 == 0;
              return TableRow(
                decoration: BoxDecoration(
                  color: isEven ? Colors.white : Colors.grey.shade50,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.value.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(
                      entry.value.explanation,
                      textStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }
    }

    // 4. DIAGRAMS
    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
      tryAddHeader('DIAGRAMS');
      if (block.diagramDescription != null) {
        widgets.add(
          HtmlWidget(
            block.diagramDescription!,
            textStyle: const TextStyle(fontSize: 14, height: 1.5),
          ),
        );
      }
      widgets.add(_buildDiagramsRow(context, block.diagramEnums!));
    }

    // 5. DATA TABLES
    if (block.tableData != null) {
      final table = block.tableData!;
      if (table.title != null && table.title!.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              table.title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        );
      }
      widgets.add(
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 1),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: table.headers.map((h) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    h,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            ...table.data.asMap().entries.map((entry) {
              return TableRow(
                decoration: const BoxDecoration(color: Colors.white),
                children: entry.value.map((cell) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 8.0,
                    ),
                    child: HtmlWidget(
                      cell,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ],
        ),
      );
      if (table.figCaption != null && table.figCaption!.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              table.figCaption!,
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        );
      }
    } else if (block.widget != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: block.widget!,
        ),
      );
    }

    // 6. TIPS
    if (block.tip != null) {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(color: Colors.blue.shade200, width: 4),
            ),
          ),
          child: HtmlWidget(
            '<b>TIP:</b> ${block.tip!.text}',
            textStyle: TextStyle(color: Colors.blue.shade900, height: 1.4),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildDiagramsRow(BuildContext context, List<DiagramEnum> enums) {
    final diagWidgets = AllDiagrams(
      size: MediaQuery.of(context).size,
      colorScheme: Theme.of(context).colorScheme,
    ).getDiagramWidgets(diagrams: enums).toList();

    return Row(
      children: diagWidgets
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: w),
              ),
            ),
          )
          .toList(),
    );
  }
}
