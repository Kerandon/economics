import 'package:economics_app/home_page/pages/terms/terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/term.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../../diagrams/data/all_diagrams.dart';
import 'package:printing/printing.dart';

import '../quick_notes/quick_notes_pdf_builder.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Logic to filter terms based on the current Tab
  List<EconTerm> _getTermsForTab(int index) {
    UnitType targetUnit;
    if (index == 0)
      targetUnit = UnitType.micro;
    else if (index == 1)
      targetUnit = UnitType.macro;
    else
      targetUnit = UnitType.global;

    // Filter by unit and sort: non-HL first, then HL
    final filtered = EconTerm.values
        .where((t) => t.subunit.unit == targetUnit)
        .toList();

    filtered.sort((a, b) {
      bool aHL = a.tags.contains(Tag.hl);
      bool bHL = b.tags.contains(Tag.hl);
      if (aHL != bHL) return aHL ? 1 : -1;
      return a.termName.compareTo(b.termName);
    });

    return filtered;
  }

  Future<void> _exportGlossaryPdf(bool currentTabOnly) async {
    final List<EconTerm> exportList = currentTabOnly
        ? _getTermsForTab(_tabController.index)
        : EconTerm.values.toList();

    // Wrap terms into a Slide structure so your existing PDF builder can read them
    final List<Slide> exportSlides = [
      Slide(
        subunit: Subunit.whatIsEconomics, // Generic anchor
        title: currentTabOnly ? 'Glossary: ${_getTabTitle()}' : 'Full Glossary',
        contents: [SlideContent.econTerms(exportList)],
      ),
    ];

    final pdfBytes = await exportQuickNotesToPdf(
      exportSlides,
      AllDiagrams(
        size: const Size(500, 500),
        colorScheme: Theme.of(context).colorScheme,
      ),
      (p, s) => debugPrint(s),
      currentTabOnly
          ? 'IB Econ Glossary - ${_getTabTitle()}'
          : 'Full IB Econ Glossary',
    );

    await Printing.sharePdf(bytes: pdfBytes, filename: 'IB_Econ_Glossary.pdf');
  }

  String _getTabTitle() {
    if (_tabController.index == 0) return 'Microeconomics';
    if (_tabController.index == 1) return 'Macroeconomics';
    return 'Global Economy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Glossary of Terms'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
            onPressed: () => _showExportOptions(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.indigo,
          labelColor: Colors.indigo,
          tabs: const [
            Tab(text: 'MICRO'),
            Tab(text: 'MACRO'),
            Tab(text: 'GLOBAL'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTermList(0), _buildTermList(1), _buildTermList(2)],
      ),
    );
  }

  Widget _buildTermList(int index) {
    final terms = _getTermsForTab(index);
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: terms.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final term = terms[i];
        final isHL = term.tags.contains(Tag.hl);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    term.termName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isHL ? Colors.purple : Colors.indigo.shade900,
                    ),
                  ),
                  if (isHL) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'HL',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              HtmlWidget(
                term.explanation,
                textStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Unit ${term.subunit.id}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.tab),
              title: Text('Export current unit (${_getTabTitle()})'),
              onTap: () {
                Navigator.pop(context);
                _exportGlossaryPdf(true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('Export all terms'),
              onTap: () {
                Navigator.pop(context);
                _exportGlossaryPdf(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
