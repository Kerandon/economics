import 'package:flutter/material.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
// NOTE: Make sure to add 'flutter_html: ^3.0.0' (or latest) to pubspec.yaml

import '../../models/slide_content.dart';
// NEW: Import the flutter_widget_from_html package
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SubunitNotesPage extends StatelessWidget {
  final Subunit subunit;
  final List<Slide> slides;

  const SubunitNotesPage({
    super.key,
    required this.subunit,
    required this.slides,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Group the slides by SyllabusPoint
    final Map<SyllabusPoint?, List<Slide>> groupedBySyllabusPoint = {};
    for (var slide in slides) {
      groupedBySyllabusPoint
          .putIfAbsent(slide.syllabusPoint, () => [])
          .add(slide);
    }

    final syllabusPoints = groupedBySyllabusPoint.keys.toList();

    return Scaffold(
      backgroundColor: Colors.white, // Standard news-style background
      appBar: AppBar(
        title: Text(subunit.title),
        centerTitle: true,
        elevation: 0, // Flat look is modern
      ),
      // 2. Wrap everything in a Center and ConstrainedBox for the "Strip" effect
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 750, // The maximum width of your reading strip
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
              horizontal: 24.0,
            ),
            itemCount: syllabusPoints.length,
            itemBuilder: (context, index) {
              final point = syllabusPoints[index];
              final pointSlides = groupedBySyllabusPoint[point]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SYLLABUS POINT HEADER ---
                  if (point != null) ...[
                    HtmlWidget(
                      point.title,
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (point.hlOnly)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'HL Only',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],

                  // --- SLIDES FOR THIS POINT ---
                  ...pointSlides.map((slide) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Optional: Slide Sub-heading
                          if (slide.title.isNotEmpty) ...[
                            HtmlWidget(slide.title),
                            const Divider(height: 24, thickness: 2),
                          ],

                          // 3. Dynamically build each content block
                          if (slide.contents != null)
                            ...slide.contents!.map(
                              (contentBlock) =>
                                  _buildContentBlock(contentBlock),
                            ),
                        ],
                      ),
                    );
                  }).toList(),

                  // A distinct separator between major syllabus topics
                  if (index < syllabusPoints.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Divider(thickness: 4, color: Colors.black12),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// The "Builder" that reads the SlideContent properties and outputs Widgets
  Widget _buildContentBlock(SlideContent block) {
    List<Widget> widgets = [];

    // --- A. HTML TEXT ---
    if (block.content != null && block.content!.text.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: HtmlWidget(
            block.content!.text.toString(),
            // Nice, readable defaults for articles
            textStyle: const TextStyle(
              fontSize: 18,
              height: 1.6,
              color: Colors.black87,
            ),
            onTapUrl: (url) {
              print('Tapped URL: $url');
              return true;
            },
          ),
        ),
      );
    }

    // --- B. DIAGRAMS ---
    if (block.diagramWidgets != null && block.diagramWidgets!.isNotEmpty) {
      for (var diagramWidget in block.diagramWidgets!) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: diagramWidget,
            ), // Centering diagrams looks great in articles
          ),
        );
      }
    }

    // --- C. CUSTOM WIDGETS (Tables, Evaluation, Glossary) ---
    if (block.widget != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: block.widget!,
        ),
      );
    }

    // --- D. ALERTS / CALLOUTS ---
    if (block.alert != null) {
      widgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50, // Changed to a softer blue for notes
            borderRadius: BorderRadius.circular(8),
            border: Border(
              left: BorderSide(color: Colors.blue.shade700, width: 4),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  block.alert!.text,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // --- E. TERMS & GLOSSARY ---


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
