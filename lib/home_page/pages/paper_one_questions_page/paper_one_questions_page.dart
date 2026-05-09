import 'dart:typed_data';

import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_one_questions_repository/paper_one_questions_data.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/question_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/slide.dart';

import 'export_all_questions_to_pdf.dart';

class PaperOneQuestionsPage extends StatefulWidget {
  const PaperOneQuestionsPage({super.key});

  @override
  State<PaperOneQuestionsPage> createState() => _PaperOneQuestionsPageState();
}

class _PaperOneQuestionsPageState extends State<PaperOneQuestionsPage> {
  // 1. Toggles
  bool _showHL = true;
  bool _showSL = true;
  bool _showP1a = true;
  bool _showP1b = true;

  // NEW: State variable for dynamic tile sizing. Defaulting smaller (280) to show more.
  double _tileWidth = 280.0;

  String _getCategoryForSubunit(Subunit subunit) {
    // Simply check the UnitType that is already assigned to the Subunit
    switch (subunit.unit) {
      case UnitType.macro:
        return 'Macro';
      case UnitType.global:
        return 'Global';
      case UnitType.micro:
        return 'Micro';
      case UnitType.intro:
        // Note: You don't have an 'Intro' tab in your categories list.
        // You can either return 'Intro' (it will only show up in 'All'),
        // or return 'Micro' if you want intro questions grouped there.
        return 'Micro';
    }
  }

  List<Slide> _getQuestionsByCategory(String category) {
    // 1. Get the filtered list first
    final filteredList = paperOneQuestionsData.where((q) {
      final matchesCategory =
          category == 'All' || _getCategoryForSubunit(q.subunit) == category;
      if (!matchesCategory) return false;

      final isHL = q.tags.contains(Tag.hl);
      final isSL = q.tags.contains(Tag.sl);
      bool matchesLevel = false;
      if (_showHL && isHL) matchesLevel = true;
      if (_showSL && isSL) matchesLevel = true;
      if (!isHL && !isSL) matchesLevel = true;

      final isP1a = q.tags.contains(Tag.p1a);
      final isP1b = q.tags.contains(Tag.p1b);
      bool matchesMarks = false;
      if (_showP1a && isP1a) matchesMarks = true;
      if (_showP1b && isP1b) matchesMarks = true;
      if (!isP1a && !isP1b) matchesMarks = true;

      return matchesLevel && matchesMarks;
    }).toList();

    // 2. Sort the list by the enum's index (chronological syllabus order)
    filteredList.sort((a, b) => a.subunit.index.compareTo(b.subunit.index));

    return filteredList;
  }

  void _exportToPdf(String category, List<Slide> questions) async {
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No questions to export for this category.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        double currentProgress = 0.0;
        String currentStatus = "Initializing export...";
        bool hasStarted = false;

        // 🌟 NEW: Variable to hold the final PDF bytes
        Uint8List? finalPdfBytes;

        return StatefulBuilder(
          builder: (context, setState) {
            void updateProgress(double progress, String status) {
              setState(() {
                currentProgress = progress;
                currentStatus = status;
              });
            }

            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!hasStarted) {
                hasStarted = true;
                try {
                  // 🌟 THE FIX: Grab the exact same screen size as the single slide export!
                  final diagramSize = MediaQuery.of(context).size;
                  final colorScheme = Theme.of(context).colorScheme;

                  // Capture the returned bytes using the screen-sized diagram service
                  final bytes = await exportAllQuestionsToPdf(
                    questions,
                    AllDiagrams(size: diagramSize, colorScheme: colorScheme),
                    updateProgress,
                  );

                  // Update UI to show the download button
                  setState(() {
                    finalPdfBytes = bytes;
                    currentStatus = "PDF generated successfully!";
                  });
                } catch (e) {
                  print("Export failed: $e");
                  setState(() {
                    currentStatus = "Error: Something went wrong.";
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  if (mounted && Navigator.canPop(dialogContext)) {
                    Navigator.pop(dialogContext);
                  }
                }
              }
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                category == 'All'
                    ? 'Exporting Full Booklet'
                    : 'Exporting $category Section',
                textAlign: TextAlign.center,
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Only show the progress bar if we aren't finished
                    if (finalPdfBytes == null) ...[
                      LinearProgressIndicator(
                        value: currentProgress,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(6),
                        backgroundColor: Colors.grey.shade200,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "${(currentProgress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),
                    Text(
                      currentStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),

                    // 🌟 NEW: The Download Button that satisfies Chrome's security rule
                    if (finalPdfBytes != null) ...[
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text(
                            'Download PDF',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // Because this is a direct, instant result of a click, Chrome allows it!
                            await Printing.sharePdf(
                              bytes: finalPdfBytes!,
                              filename:
                                  'IB_Econ_Toolkit_${category}_Revision.pdf',
                            );
                            if (mounted && Navigator.canPop(dialogContext)) {
                              Navigator.pop(dialogContext);
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Micro', 'Macro', 'Global'];

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paper 1 Questions'),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((c) => Tab(text: c)).toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'Export All to PDF',
              onPressed: () =>
                  _exportToPdf('All', _getQuestionsByCategory('All')),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips & Slider Row
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 12),
                      FilterChip(
                        label: const Text('HL'),
                        selected: _showHL,
                        selectedColor: Colors.deepPurple.shade100,
                        checkmarkColor: Colors.deepPurple.shade900,
                        onSelected: (bool selected) =>
                            setState(() => _showHL = selected),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('SL'),
                        selected: _showSL,
                        selectedColor: Colors.teal.shade100,
                        checkmarkColor: Colors.teal.shade900,
                        onSelected: (bool selected) =>
                            setState(() => _showSL = selected),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('1a [10]'),
                        selected: _showP1a,
                        selectedColor: Colors.blue.shade100,
                        checkmarkColor: Colors.blue.shade900,
                        onSelected: (bool selected) =>
                            setState(() => _showP1a = selected),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('1b [15]'),
                        selected: _showP1b,
                        selectedColor: Colors.orange.shade100,
                        checkmarkColor: Colors.orange.shade900,
                        onSelected: (bool selected) =>
                            setState(() => _showP1b = selected),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.grid_view, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 120,
                        child: Slider(
                          value: _tileWidth,
                          min: 200,
                          max: 500,
                          divisions: 6,
                          label: 'Size: ${_tileWidth.round()}',
                          onChanged: (value) =>
                              setState(() => _tileWidth = value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // The actual content below the filters
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  final filteredQuestions = _getQuestionsByCategory(category);
                  return _buildQuestionGrid(category, filteredQuestions);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionGrid(String category, List<Slide> questions) {
    if (questions.isEmpty) {
      return const Center(child: Text('No questions match your filters.'));
    }

    const double stripMaxWidth = 900;

    return Column(
      children: [
        if (category != 'All')
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: stripMaxWidth),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.print, size: 18),
                    label: Text('Export $category'),
                    onPressed: () => _exportToPdf(category, questions),
                  ),
                ),
              ),
            ),
          ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: stripMaxWidth),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: questions.map((question) {
                      return SizedBox(
                        width: _tileWidth,
                        height: _tileWidth / 1.2,
                        child: _QuestionCard(
                          slide: question,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QuestionDetailPage(slide: question),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Slide slide;
  final VoidCallback onTap;

  const _QuestionCard({required this.slide, required this.onTap});

  String _formatTag(Tag tag) {
    switch (tag) {
      case Tag.hl:
        return 'HL';
      case Tag.sl:
        return 'SL';
      case Tag.p1a:
        return 'P1a [10]';
      case Tag.p1b:
        return 'P1b [15]';
      default:
        return tag.name.toUpperCase();
    }
  }

  Color _getTagColor(Tag tag) {
    switch (tag) {
      case Tag.hl:
        return Colors.deepPurple.shade100;
      case Tag.sl:
        return Colors.teal.shade100;
      case Tag.p1a:
        return Colors.blue.shade100;
      case Tag.p1b:
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: slide.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTagColor(tag),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _formatTag(tag),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Text(
                  slide.question ?? 'No question provided.',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
