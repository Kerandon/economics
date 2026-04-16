import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../custom_widgets/evaluation_widget.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';
import 'handle_pdf_export.dart';


class QuestionDetailPage extends StatelessWidget {
  final Slide slide;

  const QuestionDetailPage({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    final bool isHL = slide.tags.contains(Tag.hl);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        // 🆕 Actions removed; PDF icon moved to the body
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.4),
                            children: [
                              if (isHL)
                                const TextSpan(
                                    text: '[HL] ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900)),
                              TextSpan(text: slide.question ?? slide.title),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 🆕 Modernized PDF Button moved next to title
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.picture_as_pdf_rounded,
                              color: Colors.redAccent),
                          tooltip: 'Export to PDF',
                          onPressed: () => handlePdfExport(context, slide),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Subunit Meta
                  Text(
                    slide.subunit.title,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 12),

                  // 🆕 Modernized Tags as Pill Chips
                  if (slide.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: slide.tags.map((t) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            t.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.blueGrey.shade700,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(thickness: 1.5, color: Colors.black12),
                  ),

                  // --- CONTENTS ---
                  if (slide.contents != null)
                    ...slide.contents!.map((block) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildContentBlock(context, block),
                    )),

                  // 🆕 Clean visual indicator for end of content
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      '•   •   •',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 24,
                        letterSpacing: 4.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48), // Bottom padding scroll buffer
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // HELPER BUILDERS
  // ==========================================

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              letterSpacing: 1.5)),
    );
  }

  Widget _buildTldr(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12), // 🆕 Slightly rounder borders
        border:
        Border(left: BorderSide(color: Colors.amber.shade500, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TL;DR',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber.shade800,
                  letterSpacing: 1.5)),
          const SizedBox(height: 8),
          HtmlWidget(text,
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildContentBlock(BuildContext context, SlideContent block) {
    List<Widget> widgets = [];
    const baseTextStyle =
    TextStyle(fontSize: 18, height: 1.6, color: Colors.black87);

    // 0. TL;DR
    if (block.tldr != null && block.tldr!.isNotEmpty) {
      widgets.add(_buildTldr(block.tldr!));
    }

    // 1. EconTerms List
    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      widgets.add(_buildSectionHeader('TERMS'));
      for (var econTerm in block.econTerms!) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: HtmlWidget(
              '<b>${econTerm.termName}:</b> ${econTerm.explanation}',
              textStyle: baseTextStyle,
            ),
          ),
        );
      }
    }

    // 2. Legacy Single Term
    if (block.term != null) {
      widgets.add(_buildSectionHeader('TERMS'));
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: HtmlWidget(
            '<b>${block.term!.term}:</b> ${block.term!.explanation}',
            textStyle: baseTextStyle,
          ),
        ),
      );
    }

    // 3. Standard Text / HTML
    if (block.content != null && block.content!.text.isNotEmpty) {
      widgets.add(_buildSectionHeader('EXPLANATION'));
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: HtmlWidget(
            block.content!.text,
            textStyle: baseTextStyle,
          ),
        ),
      );
    }

    // 4. Custom Widget
    if (block.widget != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: block.widget!,
        ),
      );
    }

    // 5. Diagrams (from Enums)
    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
      widgets.add(_buildSectionHeader('DIAGRAMS'));
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildDiagramsRow(context, block.diagramEnums!),
        ),
      );
    }

    // 6. Diagrams (from Widgets)
    if (block.diagramWidgets != null && block.diagramWidgets!.isNotEmpty) {
      // Check to prevent duplicate 'DIAGRAMS' header if both enums and widgets exist in the same block
      if (block.diagramEnums == null || block.diagramEnums!.isEmpty) {
        widgets.add(_buildSectionHeader('DIAGRAMS'));
      }
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildDiagramWidgetsRow(block.diagramWidgets!),
        ),
      );
    }

    // 7. Real World Examples
    if (block.realWorldExamples != null &&
        block.realWorldExamples!.isNotEmpty) {
      widgets.add(_buildSectionHeader('REAL WORLD EXAMPLES'));
      for (var rwe in block.realWorldExamples!) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ${rwe.example}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                if (rwe.explanation != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 4.0),
                    child: Text(
                      rwe.explanation!,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    }

    // 8. Evaluation Block
    if (block.evaluationData != null) {
      widgets.add(_buildSectionHeader('EVALUATION'));
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: EvaluationWidget(
            title: block.evaluationData!.title,
            leftTitle: block.evaluationData!.leftTitle,
            rightTitle: block.evaluationData!.rightTitle,
            leftItems: block.evaluationData!.leftItems,
            rightItems: block.evaluationData!.rightItems,
          ),
        ),
      );
    }

    // 9. Alerts / Warnings
    if (block.alert != null && block.alert!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.red.shade700, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    block.alert!.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 10. Tips 🆕
    if (block.tip != null && block.tip!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline,
                    color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    block.tip!.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (widgets.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // --- HELPER FOR DIAGRAM WIDGETS ROW ---
  Widget _buildDiagramWidgetsRow(List<Widget> diagramWidgets) {
    if (diagramWidgets.isEmpty) return const SizedBox.shrink();

    if (diagramWidgets.length == 1) {
      return Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: diagramWidgets.first,
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: diagramWidgets.map((diagWidget) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                child: diagWidget,
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  // --- HELPER FOR DIAGRAM ENUMS ROW ---
  Widget _buildDiagramsRow(
      BuildContext context, List<DiagramEnum> diagramEnums) {
    if (diagramEnums.isEmpty) return const SizedBox.shrink();

    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final diagramWidgets = AllDiagrams(
      size: size,
      colorScheme: theme.colorScheme,
    ).getDiagramWidgets(diagrams: diagramEnums).toList();

    return _buildDiagramWidgetsRow(diagramWidgets);
  }
}