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

class _QuickNotesPageState extends State<QuickNotesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dedicated controllers for each tab to ensure independent scrolling on Web
  final ScrollController _microScroll = ScrollController();
  final ScrollController _macroScroll = ScrollController();
  final ScrollController _globalScroll = ScrollController();

  // Registry for section keys
  final Map<String, GlobalKey> _sectionKeys = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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

  /// 🎯 PRECISION NAVIGATION: Handles switching tabs -> offset calculation -> scrolling
  void _navigateToUnit(int tabIndex, String sectionKey) {
    Navigator.pop(context); // Close Drawer

    if (_tabController.index != tabIndex) {
      _tabController.animateTo(tabIndex);
    }

    // Wait for the TabBarView to swap and the ListView to build
    Future.delayed(const Duration(milliseconds: 400), () {
      final key = _sectionKeys[sectionKey];
      final renderBox = key?.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final controller = _getControllerForIndex(tabIndex);

        // Calculate the absolute position of the element relative to the viewport
        final offset = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject());

        // Target calculation: current position + relative distance - (AppBar + TabBar height)
        final target = controller.offset + offset.dy - kToolbarHeight - 48;

        controller.animateTo(
          target.clamp(0.0, controller.position.maxScrollExtent),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutExpo,
        );
      }
    });
  }

  /// 📄 PDF GENERATION LOGIC
  Future<void> handleGenerateBooklet(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating Revision Booklet...')),
    );

    final allSlides = [...microSlides, ...macroSlides, ...globalSlides];

    final allDiagramsService = AllDiagrams(
      size: const Size(1000, 1000),
      colorScheme: Theme.of(context).colorScheme,
    );

    try {
      final pdfBytes = await exportQuickNotesToPdf(
        allSlides,
        allDiagramsService,
            (progress, status) => debugPrint('PDF Progress: $status'),
      );

      await Printing.sharePdf(
          bytes: pdfBytes,
          filename: 'IB_Economics_Quick_Revision.pdf'
      );
    } catch (e) {
      debugPrint('PDF Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating PDF: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildNavigationDrawer(),
      appBar: AppBar(
        title: const Text('Revision Toolkit'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent),
            tooltip: 'Export Revision Booklet',
            onPressed: () => handleGenerateBooklet(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo,
          indicatorWeight: 3,
          tabs: const [Tab(text: 'MICRO'), Tab(text: 'MACRO'), Tab(text: 'GLOBAL')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping from breaking scroll logic
        children: [
          _buildSlideFeed(microSlides, 0, _microScroll),
          _buildSlideFeed(macroSlides, 1, _macroScroll),
          _buildSlideFeed(globalSlides, 2, _globalScroll),
        ],
      ),
    );
  }

  // --- DRAWER / TOC COMPONENTS ---

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo.shade900),
            child: const Center(
              child: Text(
                'UNIT NAVIGATOR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerSection('Microeconomics', microSlides, 0),
                _buildDrawerSection('Macroeconomics', macroSlides, 1),
                _buildDrawerSection('Global Economy', globalSlides, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<Slide> slides, int tabIndex) {
    final List<Subunit> subunits = [];
    final Set<String> seenSubunits = {};
    for (var s in slides) {
      if (!seenSubunits.contains(s.subunit.name)) {
        subunits.add(s.subunit);
        seenSubunits.add(s.subunit.name);
      }
    }

    return ExpansionTile(
      initiallyExpanded: tabIndex == _tabController.index,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
      children: subunits.map((sub) {
        return ListTile(
          dense: true,
          leading: const Icon(Icons.subdirectory_arrow_right, size: 18),
          title: Text('${sub.id} ${sub.title}', style: const TextStyle(fontSize: 13)),
          onTap: () => _navigateToUnit(tabIndex, '${tabIndex}_${sub.name}'),
        );
      }).toList(),
    );
  }

  // --- FEED COMPONENTS ---

  Widget _buildSlideFeed(List<Slide> slides, int tabIndex, ScrollController controller) {
    if (slides.isEmpty) return const Center(child: Text('No notes available.'));

    return ListView.builder(
      controller: controller,
      cacheExtent: 10000,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      itemCount: slides.length,
      itemBuilder: (context, index) {
        final slide = slides[index];
        final previousSlide = index > 0 ? slides[index - 1] : null;

        final bool isNewSection = previousSlide == null || previousSlide.subunit.name != slide.subunit.name;
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87, height: 1.3),
            ),
            const SizedBox(height: 16),
          ],
          if (slide.contents != null)
            ...slide.contents!.map((block) => _buildContentBlock(context, block, seenHeaders)),
        ],
      ),
    );
  }

  Widget _buildModernSectionHeader(Slide slide) {
    final bool isHL = slide.tags.contains(Tag.hl);
    final String label = '${slide.subunit.id} ${slide.subunit.title}'.toUpperCase() + (isHL ? ' [HL]' : '');

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isHL ? Colors.purple.shade50 : Colors.indigo.shade50,
              border: Border(left: BorderSide(color: isHL ? Colors.purple : Colors.indigo, width: 4)),
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: isHL ? Colors.purple.shade900 : Colors.indigo.shade900, letterSpacing: 1.2),
            ),
          ),
          const Expanded(child: Padding(padding: EdgeInsets.only(left: 16.0), child: Divider(thickness: 1.5, color: Colors.black12))),
        ],
      ),
    );
  }

  Widget _buildContentBlock(BuildContext context, SlideContent block, Set<String> seenHeaders) {
    List<Widget> widgets = [];

    void tryAddHeader(String title) {
      if (!seenHeaders.contains(title)) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
          child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.2)),
        ));
        seenHeaders.add(title);
      }
    }

    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      tryAddHeader('TERMS');
      widgets.addAll(block.econTerms!.map((t) => Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: HtmlWidget('<b>${t.termName}:</b> ${t.explanation}', textStyle: const TextStyle(fontSize: 16)),
      )));
    }

    if (block.content != null && block.content!.text.isNotEmpty) {
      tryAddHeader('EXPLANATION');
      widgets.add(HtmlWidget(block.content!.text, textStyle: const TextStyle(fontSize: 16, height: 1.6)));
    }

    if (block.tableData != null || block.widget != null) {
      widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: block.widget ?? const SizedBox.shrink()
      ));
    }

    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
      tryAddHeader('DIAGRAMS');
      widgets.add(_buildDiagramsRow(context, block.diagramEnums!));
    }

    if (block.tip != null) {
      widgets.add(Container(
        margin: const EdgeInsets.only(top: 16, bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: Colors.blue.shade200, width: 4))
        ),
        child: HtmlWidget(block.tip!.text, textStyle: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500, height: 1.4)),
      ));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _buildDiagramsRow(BuildContext context, List<DiagramEnum> enums) {
    final diagWidgets = AllDiagrams(size: MediaQuery.of(context).size, colorScheme: Theme.of(context).colorScheme)
        .getDiagramWidgets(diagrams: enums).toList();

    return Row(
        children: diagWidgets.map((w) => Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(child: w),
        ))).toList()
    );
  }
}