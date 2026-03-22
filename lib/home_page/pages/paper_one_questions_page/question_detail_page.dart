import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../custom_widgets/evaluation_widget.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';
import 'handle_pdf_export.dart';


class QuestionDetailPage extends StatelessWidget {
  final PaperQuestion question;

  const QuestionDetailPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final answer = question.answer;
    final bool isHL = question.tags?.contains(Tag.hl) ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
            tooltip: 'Export Diagrams to PDF',
            onPressed: () => handlePdfExport(context, question),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              // --- HEADER ---
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.4),
                  children: [
                    if (isHL)
                      const TextSpan(text: '[HL] ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900)),
                    TextSpan(text: question.question),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question.subunit.name.toUpperCase(),
                style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600, letterSpacing: 1.2),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Divider(thickness: 2, color: Colors.black12),
              ),

              // --- 0. TL;DR ---
              if (answer.tldr != null && answer.tldr!.isNotEmpty) ...[
                _buildTldr(answer.tldr!),
                const SizedBox(height: 32),
              ],

              // --- 1. DEFINITIONS ---
              if (answer.terms != null && answer.terms!.isNotEmpty) ...[
                _buildSectionHeader('DEFINITIONS'),
                ...answer.terms!.map((econTerm) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: HtmlWidget(
                    '<b>${econTerm.termName}:</b> ${econTerm.explanation}',
                    textStyle: const TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
                  ),
                )),
                const SizedBox(height: 32),
              ],

              // --- 2. EXPLANATION ---
              if (answer.explanation != null && answer.explanation!.isNotEmpty) ...[
                _buildSectionHeader('EXPLANATION'),
                ...answer.explanation!.map((content) => _buildContentBlock(context, content)),
                const SizedBox(height: 32),
              ],

              // --- 3. DIAGRAMS ---
              if (answer.diagrams != null && answer.diagrams!.enums.isNotEmpty) ...[
                _buildSectionHeader('DIAGRAMS'),
                _buildDiagramsRow(context, answer.diagrams!.enums),
                if (answer.diagrams!.explanation != null) ...[
                  const SizedBox(height: 16),
                  HtmlWidget(
                    answer.diagrams!.explanation!,
                    textStyle: const TextStyle(fontSize: 16, color: Colors.black87, fontStyle: FontStyle.italic),
                  ),
                ],
                const SizedBox(height: 32),
              ],

              // --- 4. REAL WORLD EXAMPLES (Updated for your new Enum) ---
              if (answer.realWorldExamples != null && answer.realWorldExamples!.isNotEmpty) ...[
                _buildSectionHeader('REAL WORLD EXAMPLES'),
                ...answer.realWorldExamples!.map((rwe) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ${rwe.example}', // The main title from the enum
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      if (rwe.explanation != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 4.0),
                          child: Text(
                            rwe.explanation!, // The context from the enum
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade800, fontStyle: FontStyle.italic),
                          ),
                        ),
                    ],
                  ),
                )),
                const SizedBox(height: 32),
              ],

              // --- 5. EVALUATION (Updated to handle multiple items) ---
              if (answer.evaluation != null && answer.evaluation!.isNotEmpty) ...[
                _buildSectionHeader('EVALUATION'),
                ...answer.evaluation!.map((evalData) => Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: EvaluationWidget(
                    title: evalData.title,
                    leftTitle: evalData.leftTitle,
                    rightTitle: evalData.rightTitle,
                    leftItems: evalData.leftItems,
                    rightItems: evalData.rightItems,
                  ),
                )),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // TL;DR Helper to keep build clean
  Widget _buildTldr(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: Colors.amber.shade500, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TL;DR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.amber.shade800, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.5)),
    );
  }



  /// Helper builder that translates SlideContent into UI
  Widget _buildContentBlock(BuildContext context, SlideContent block) {
    List<Widget> widgets = [];
    const baseTextStyle = TextStyle(fontSize: 18, height: 1.6, color: Colors.black87);

    // A. Terms
    if (block.term != null) {
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

    // B. Text / HTML Blocks
    if (block.content != null && block.content!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: HtmlWidget(
            block.content!.text,
            textStyle: baseTextStyle,
          ),
        ),
      );
    }

    // C. Custom Widgets
    if (block.widget != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: block.widget!,
        ),
      );
    }

    // D. Diagram Widgets (Now fully populated!)
// D. Diagram Widgets (Now side-by-side if multiple)
// D. Diagram Widgets (Now side-by-side without overflowing!)
    if (block.diagramWidgets != null && block.diagramWidgets!.isNotEmpty) {
      if (block.diagramWidgets!.length == 1) {
        // Single diagram: standard centered view
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: block.diagramWidgets!.first),
          ),
        );
      } else {
        // Multiple diagrams: render them side-by-side in a Row
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: block.diagramWidgets!.map((diagWidget) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // ✨ THE FIX: Scales the diagram perfectly into the available half-width
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: diagWidget,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }
    }
    // E. Alert / Warning Blocks (Red shaded box)
    if (block.alert != null && block.alert!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.red.shade50, // Soft red background
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200), // Subtle border
              // Optional: Add a left accent bar like the TL;DR section
              // border: Border(left: BorderSide(color: Colors.red.shade600, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 24),
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


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );

  }
}// --- HELPER FOR DIAGRAMS ROW ---
Widget _buildDiagramsRow(BuildContext context, List<DiagramEnum> diagramEnums) {
  if (diagramEnums.isEmpty) return const SizedBox.shrink();

  // 1. Grab the context-specific size and theme
  final size = MediaQuery.of(context).size;
  final theme = Theme.of(context);

  // 2. Hydrate the slides: Convert diagramEnums to diagramWidgets
  final diagramWidgets = AllDiagrams(
    size: size,
    colorScheme: theme.colorScheme,
  ).getDiagramWidgets(diagrams: diagramEnums).toList();

  // 3. Layout the widgets safely
  if (diagramWidgets.length == 1) {
    // Single diagram: standard centered view
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(child: diagramWidgets.first),
    );
  } else {
    // Multiple diagrams: render them side-by-side in a Row
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: diagramWidgets.map((diagWidget) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // Scales the diagram perfectly into the available half-width
              child: FittedBox(
                fit: BoxFit.contain,
                child: diagWidget,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}