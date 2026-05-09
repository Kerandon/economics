import 'package:flutter/services.dart';
import 'package:flutter/material.dart' show Size, Axis;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/models/pdf_diagram_canvas.dart';
import '../../enums/tag.dart';
import '../../models/slide.dart';
import '../../models/term.dart';

// =============================================================================
// EXPORT SINGLE QUESTION
// =============================================================================
Future<void> exportFullQuestionToPdf(
  Slide slide,
  AllDiagrams allDiagramsService,
) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final pw.Font unicodeFont = pw.Font.ttf(fontData);

  final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
  final pw.Font boldUnicodeFont = pw.Font.ttf(boldFontData);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) => _buildFooter(context, unicodeFont),
      build: (pw.Context pdfContext) {
        return buildSlidePdfElements(
          slide: slide,
          unicodeFont: unicodeFont,
          boldUnicodeFont: boldUnicodeFont,
          allDiagramsService: allDiagramsService,
          pdfContext: pdfContext,
        );
      },
    ),
  );

  String cleanTitle = (slide.question ?? slide.title)
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp(r'_+'), '_');
  if (cleanTitle.endsWith('_')) {
    cleanTitle = cleanTitle.substring(0, cleanTitle.length - 1);
  }
  if (cleanTitle.length > 40) cleanTitle = cleanTitle.substring(0, 40);

  String tagsStr = slide.tags.map((t) => formatPdfTag(t)).join('_');
  final bool isHL = slide.tags.contains(Tag.hl);
  final String prefix = isHL ? "HL" : "SL";
  final String pdfFileName = '${prefix}_${cleanTitle}_$tagsStr.pdf'.replaceAll(
    '__',
    '_',
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: pdfFileName);
}

// =============================================================================
// EXPORT ENTIRE BOOKLET
// =============================================================================
Future<Uint8List> exportAllQuestionsToPdf(
  List<Slide> allSlides,
  AllDiagrams allDiagramsService,
  Function(double progress, String status) onProgress,
) async {
  final pdf = pw.Document();

  onProgress(0.0, 'Loading fonts...');
  await Future.delayed(Duration.zero);

  final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final pw.Font unicodeFont = pw.Font.ttf(fontData);

  final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
  final pw.Font boldUnicodeFont = pw.Font.ttf(boldFontData);

  final microSlides = allSlides
      .where((s) => s.subunit.unit == UnitType.micro)
      .toList();
  final macroSlides = allSlides
      .where((s) => s.subunit.unit == UnitType.macro)
      .toList();
  final globalSlides = allSlides
      .where((s) => s.subunit.unit == UnitType.global)
      .toList();

  final groups = [
    {'title': 'Microeconomics', 'slides': microSlides},
    {'title': 'Macroeconomics', 'slides': macroSlides},
    {'title': 'Global Economics', 'slides': globalSlides},
  ];

  int totalSlides = allSlides.length;
  int processed = 0;

  // --- 1. COVER PAGE ---
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'IB ECONOMICS',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 48,
                  color: PdfColors.indigo900,
                  letterSpacing: 4.0,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                'Paper 1 Past Paper',
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 28,
                  color: PdfColors.indigo700,
                  letterSpacing: 2.0,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Exam Revision',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 36,
                  color: PdfColors.indigo800,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 80),
              pw.Container(
                width: 320,
                padding: const pw.EdgeInsets.all(24),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  border: pw.Border.all(color: PdfColors.indigo200, width: 2),
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8),
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Name: __________________________',
                      style: pw.TextStyle(font: unicodeFont, fontSize: 16),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      'Class:  __________________________',
                      style: pw.TextStyle(font: unicodeFont, fontSize: 16),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      'Date:   __________________________',
                      style: pw.TextStyle(font: unicodeFont, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // --- 2. TABLE OF CONTENTS (WITH CHIPS & FIXED PADDING) ---
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) =>
          _buildFooter(context, unicodeFont, 'Table of Contents'),
      build: (pw.Context context) {
        List<pw.Widget> tocElements = [
          pw.Text(
            'TABLE OF CONTENTS',
            style: pw.TextStyle(
              font: boldUnicodeFont,
              fontSize: 24,
              color: PdfColors.indigo900,
              letterSpacing: 1.5,
            ),
          ),
          pw.SizedBox(height: 24),
        ];

        for (var group in groups) {
          String sectionTitle = group['title'] as String;
          List<Slide> sectionSlides = group['slides'] as List<Slide>;

          if (sectionSlides.isEmpty) continue;

          tocElements.add(
            pw.Container(
              margin: const pw.EdgeInsets.only(
                top: 20,
                bottom: 12,
              ), // Increased top margin
              padding: const pw.EdgeInsets.only(bottom: 4),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.indigo300, width: 1.5),
                ),
              ),
              child: pw.Text(
                sectionTitle.toUpperCase(),
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 14,
                  color: PdfColors.indigo700,
                ),
              ),
            ),
          );

          for (int i = 0; i < sectionSlides.length; i++) {
            final slide = sectionSlides[i];
            final isHL = slide.tags.contains(Tag.hl);
            final displayTags = slide.tags
                .where((t) => t != Tag.hl && t != Tag.sl)
                .toList();
            final anchorId = 'slide_${slide.hashCode}';

            List<pw.Widget> chipWidgets = [];

            chipWidgets.add(
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: pw.BoxDecoration(
                  color: isHL ? PdfColors.purple50 : PdfColors.teal50,
                  border: pw.Border.all(
                    color: isHL ? PdfColors.purple200 : PdfColors.teal200,
                    width: 0.5,
                  ),
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(4),
                  ),
                ),
                child: pw.Text(
                  isHL ? 'HL' : 'SL',
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 8,
                    color: isHL ? PdfColors.purple800 : PdfColors.teal800,
                  ),
                ),
              ),
            );

            for (var tag in displayTags) {
              chipWidgets.add(
                pw.SizedBox(width: 6),
              ); // Increased spacing between chips
              chipWidgets.add(
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.indigo50,
                    border: pw.Border.all(
                      color: PdfColors.indigo200,
                      width: 0.5,
                    ),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(4),
                    ),
                  ),
                  child: pw.Text(
                    formatPdfTag(tag),
                    style: pw.TextStyle(
                      font: boldUnicodeFont,
                      fontSize: 8,
                      color: PdfColors.indigo800,
                    ),
                  ),
                ),
              );
            }

            tocElements.add(
              pw.Link(
                destination: anchorId,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    bottom: 12,
                    left: 8,
                  ), // Added more bottom padding for breathing room
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${i + 1}. ',
                        style: pw.TextStyle(
                          font: boldUnicodeFont,
                          fontSize: 11,
                          color: PdfColors.black,
                        ),
                      ),

                      // 🌟 FIXED PADDING: Expanded wrapper with right padding forces the tags far away from the text
                      pw.Expanded(
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 32),
                          child: pw.Text(
                            slide.question ?? slide.title,
                            style: pw.TextStyle(
                              font: unicodeFont,
                              fontSize: 11,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ),

                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          ...chipWidgets,
                          pw.SizedBox(
                            width: 16,
                          ), // Increased spacing before the checkbox
                          pw.Container(
                            width: 12,
                            height: 12,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.grey600,
                                width: 1.2,
                              ),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return tocElements;
      },
    ),
  );

  // --- 3. MAIN CONTENT LOOP ---
  for (var group in groups) {
    String sectionTitle = group['title'] as String;
    List<Slide> sectionSlides = group['slides'] as List<Slide>;

    if (sectionSlides.isEmpty) continue;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  sectionTitle.toUpperCase(),
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 32,
                    color: PdfColors.indigo900,
                    letterSpacing: 2.0,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Divider(thickness: 2, color: PdfColors.indigo300),
                pw.SizedBox(height: 16),
                pw.Text(
                  '${sectionSlides.length} Questions',
                  style: pw.TextStyle(
                    font: unicodeFont,
                    fontSize: 16,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    for (var slide in sectionSlides) {
      processed++;
      onProgress(
        processed / totalSlides,
        'Generating $sectionTitle...\n${slide.title}',
      );
      await Future.delayed(const Duration(milliseconds: 10));

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          footer: (pw.Context context) =>
              _buildFooter(context, unicodeFont, sectionTitle),
          build: (pw.Context pdfContext) {
            return buildSlidePdfElements(
              slide: slide,
              unicodeFont: unicodeFont,
              boldUnicodeFont: boldUnicodeFont,
              allDiagramsService: allDiagramsService,
              pdfContext: pdfContext,
              anchorName: 'slide_${slide.hashCode}',
            );
          },
        ),
      );
    }
  }

  onProgress(1.0, 'Finalizing document...');
  await Future.delayed(const Duration(milliseconds: 100));
  return await pdf.save();
}

// =============================================================================
// THE RATIONALIZED CORE LAYOUT BUILDER
// =============================================================================
List<pw.Widget> buildSlidePdfElements({
  required Slide slide,
  required pw.Font unicodeFont,
  required pw.Font boldUnicodeFont,
  required AllDiagrams allDiagramsService,
  required pw.Context pdfContext,
  String? anchorName,
}) {
  List<pw.Widget> pageElements = [];
  final Set<String> seenHeaders = {};

  void tryAddHeader(String title) {
    if (!seenHeaders.contains(title)) {
      pageElements.add(buildSectionHeader(title, boldUnicodeFont));
      seenHeaders.add(title);
    }
  }

  // --- HEADER ---
  pw.Widget headerRow = pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        'IB Economics Paper 1 Revision',
        style: pw.TextStyle(
          font: boldUnicodeFont,
          fontSize: 10,
          color: PdfColors.indigo600,
        ),
      ),
      if (anchorName != null)
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Question Revised',
              style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Container(
              width: 14,
              height: 14,
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                border: pw.Border.all(color: PdfColors.grey600, width: 1.2),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
              ),
            ),
          ],
        ),
    ],
  );

  if (anchorName != null) {
    pageElements.add(pw.Anchor(name: anchorName, child: headerRow));
  } else {
    pageElements.add(headerRow);
  }

  pageElements.add(pw.SizedBox(height: 8));
  pageElements.add(
    pw.Text(
      slide.subunit.title.toUpperCase(),
      style: pw.TextStyle(
        font: unicodeFont,
        fontSize: 10,
        color: PdfColors.grey700,
      ),
    ),
  );
  pageElements.add(pw.SizedBox(height: 4));

  final isHL = slide.tags.contains(Tag.hl);
  pageElements.add(
    pw.Text(
      (isHL ? '[HL] ' : '') + (slide.question ?? slide.title),
      style: pw.TextStyle(
        font: unicodeFont,
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
  pageElements.add(pw.SizedBox(height: 4));

  final displayTags = slide.tags
      .where((t) => t != Tag.hl && t != Tag.sl)
      .toList();
  if (displayTags.isNotEmpty) {
    pageElements.add(pw.SizedBox(height: 4));
    pageElements.add(
      pw.Text(
        displayTags.map((t) => formatPdfTag(t)).join('  •  '),
        style: pw.TextStyle(
          font: unicodeFont,
          fontSize: 9,
          color: PdfColors.indigo600,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pageElements.add(pw.SizedBox(height: 6)); // COMPACTED
  pageElements.add(pw.Divider(thickness: 1, color: PdfColors.grey300));
  pageElements.add(pw.SizedBox(height: 8)); // COMPACTED

  // --- CONTENTS LOOP ---
  if (slide.contents != null) {
    for (var block in slide.contents!) {
      if (block.econTerms != null && block.econTerms!.isNotEmpty) {
        tryAddHeader('TERMS');
        for (int i = 0; i < block.econTerms!.length; i++) {
          final term = block.econTerms![i];
          pageElements.add(
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 4),
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
              ),
              child: pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                    font: unicodeFont,
                    fontSize: 10.5,
                    lineSpacing: 1.2,
                  ),
                  children: [
                    pw.TextSpan(
                      text: '${term.termName}: ',
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.TextSpan(
                      text: stripHtmlIfNeeded(term.explanation),
                      style: const pw.TextStyle(color: PdfColors.grey800),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        pageElements.add(pw.SizedBox(height: 6)); // COMPACTED
      }

      if (block.content != null && block.content!.text.isNotEmpty) {
        tryAddHeader('EXPLANATION');
        pageElements.addAll(
          HtmlPdfBuilder.build(
            block.content!.text,
            regularFont: unicodeFont,
            boldFont: boldUnicodeFont,
          ),
        );
        pageElements.add(pw.SizedBox(height: 6)); // COMPACTED
      }

      if (block.alert != null && block.alert!.text.isNotEmpty) {
        pageElements.add(
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            margin: const pw.EdgeInsets.only(bottom: 6), // COMPACTED
            decoration: pw.BoxDecoration(
              color: PdfColors.red50,
              border: pw.Border.all(color: PdfColors.red200),
            ),
            child: pw.Text(
              block.alert!.text,
              style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 10.5,
                color: PdfColors.red900,
              ),
            ),
          ),
        );
      }

      if (block.tip != null && block.tip!.text.isNotEmpty) {
        pageElements.add(
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            margin: const pw.EdgeInsets.only(bottom: 6), // COMPACTED
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              border: pw.Border.all(color: PdfColors.blue200),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'TIP: ',
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 10.5,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(
                    block.tip!.text,
                    style: pw.TextStyle(
                      font: unicodeFont,
                      fontSize: 10.5,
                      color: PdfColors.blue900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
        tryAddHeader('DIAGRAMS');
        final widgets = allDiagramsService
            .getDiagramWidgets(diagrams: block.diagramEnums!)
            .toList();
        pageElements.add(buildPdfDiagramRow(widgets, unicodeFont, pdfContext));
        pageElements.add(pw.SizedBox(height: 6)); // COMPACTED
      }

      if (block.realWorldExamples != null &&
          block.realWorldExamples!.isNotEmpty) {
        tryAddHeader('REAL WORLD EXAMPLES');

        // 1. Iterate over each topic
        for (final topic in block.realWorldExamples!) {
          if (topic.examples.isEmpty)
            continue; // Skip if a topic has no examples

          // 2. Add the Topic Name as a sub-header
          pageElements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 6.0, bottom: 4.0),
              child: pw.Text(
                topic.topicName,
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
            ),
          );

          // 3. Build the table rows for the specific topic's examples
          final tableRows = <pw.TableRow>[];
          for (int i = 0; i < topic.examples.length; i++) {
            final rwe = topic.examples[i];
            final isEven = i % 2 == 0;

            tableRows.add(
              pw.TableRow(
                decoration: pw.BoxDecoration(
                  color: isEven ? PdfColors.white : PdfColors.grey100,
                ),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 6.0,
                    ),
                    child: pw.Text(
                      rwe.title, // Updated from rwe.example
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 6.0,
                    ),
                    child: pw.Text(
                      stripHtmlIfNeeded(
                        rwe.explanation,
                      ), // Removed ?? '' since it's non-nullable now
                      style: pw.TextStyle(
                        font: unicodeFont,
                        fontSize: 9,
                        color: PdfColors.grey800,
                        lineSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // 4. Add the generated table to the PDF
          pageElements.add(
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
              ),
              child: pw.Table(
                columnWidths: const {
                  0: pw.FlexColumnWidth(1.2),
                  1: pw.FlexColumnWidth(2.8),
                },
                border: pw.TableBorder(
                  horizontalInside: pw.BorderSide(color: PdfColors.grey200),
                  verticalInside: pw.BorderSide(color: PdfColors.grey200),
                ),
                children: tableRows,
              ),
            ),
          );

          pageElements.add(
            pw.SizedBox(height: 6),
          ); // COMPACTED spacing between topics
        }
      }
      if (block.tableData != null) {
        final tableInfo = block.tableData!;
        final cleanHeaders = tableInfo.headers
            .map((h) => stripHtmlIfNeeded(h))
            .toList();
        final cleanData = tableInfo.data
            .map((row) => row.map((cell) => stripHtmlIfNeeded(cell)).toList())
            .toList();

        if (tableInfo.title != null) {
          pageElements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4), // COMPACTED
              child: pw.Center(
                child: pw.Text(
                  stripHtmlIfNeeded(tableInfo.title!),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 10.5,
                    color: PdfColors.indigo900,
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }

        pageElements.add(
          pw.TableHelper.fromTextArray(
            headers: cleanHeaders,
            data: cleanData,
            border: pw.TableBorder.all(color: PdfColors.grey600, width: 0.5),
            headerStyle: pw.TextStyle(
              font: boldUnicodeFont,
              fontSize: 9,
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.indigo600,
            ),
            cellStyle: pw.TextStyle(font: unicodeFont, fontSize: 9),
            cellPadding: const pw.EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 6,
            ),
            cellAlignment: pw.Alignment.center,
            columnWidths: {
              for (int i = 0; i < cleanHeaders.length; i++)
                i: const pw.FlexColumnWidth(),
            },
          ),
        );
        pageElements.add(pw.SizedBox(height: 6)); // COMPACTED
      }
    }
  }

  return pageElements;
}

// =============================================================================
// HELPER METHODS
// =============================================================================

pw.Widget _buildFooter(
  pw.Context context,
  pw.Font font, [
  String? sectionTitle,
]) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 12),
    padding: const pw.EdgeInsets.only(top: 8),
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        top: pw.BorderSide(color: PdfColors.grey300, width: 1.0),
      ),
    ),
    child: pw.Row(
      mainAxisAlignment: sectionTitle != null
          ? pw.MainAxisAlignment.spaceBetween
          : pw.MainAxisAlignment.end,
      children: [
        if (sectionTitle != null)
          pw.Text(
            sectionTitle,
            style: pw.TextStyle(
              font: font,
              fontSize: 9,
              color: PdfColors.grey500,
            ),
          ),
        pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: pw.TextStyle(
            font: font,
            fontSize: 9,
            color: PdfColors.grey500,
          ),
        ),
      ],
    ),
  );
}

String formatPdfTag(Tag tag) {
  switch (tag) {
    case Tag.p1a:
      return 'P1A [10]';
    case Tag.p1b:
      return 'P1B [15]';
    default:
      return tag.name.toUpperCase();
  }
}

pw.Widget buildSectionHeader(String title, pw.Font font) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 4, top: 6), // COMPACTED
    padding: const pw.EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 8,
    ), // COMPACTED
    decoration: pw.BoxDecoration(
      color: PdfColors.indigo50,
      border: const pw.Border(
        left: pw.BorderSide(color: PdfColors.indigo700, width: 4),
      ),
    ),
    child: pw.Row(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            font: font,
            fontSize: 11,
            color: PdfColors.indigo900,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ],
    ),
  );
}

String stripHtmlIfNeeded(String text) {
  String parsed = text.replaceAll('\n', ' ');
  parsed = parsed.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  parsed = parsed.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n');
  parsed = parsed.replaceAll(RegExp(r'<li>', caseSensitive: false), '\n- ');
  parsed = parsed.replaceAll(RegExp(r'<[^>]*>', multiLine: true), '');
  parsed = parsed.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  return parsed.trim();
}

pw.Widget buildPdfDiagramRow(
  List<DiagramWidget> widgets,
  pw.Font unicodeFont,
  pw.Context pdfContext,
) {
  if (widgets.isEmpty) return pw.Container();
  return pw.Center(
    child: pw.Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: pw.WrapAlignment.center,
      children: widgets.map((dWidget) {
        int horizontalPainters = (dWidget.axis == Axis.horizontal)
            ? dWidget.painters.length
            : 1;
        double containerWidth = horizontalPainters > 1 ? 460.0 : 220.0;
        return pw.Container(
          width: containerWidth,
          child: _buildSingleDiagramColumn(dWidget, unicodeFont, pdfContext),
        );
      }).toList(),
    ),
  );
}

pw.Widget _buildDiagramImagesOnly(
  DiagramWidget dWidget,
  pw.Font unicodeFont,
  pw.Context pdfContext,
) {
  final pdfDiagrams = <pw.Widget>[];

  for (int i = 0; i < dWidget.painters.length; i++) {
    final painter = dWidget.painters[i];
    pdfDiagrams.add(
      pw.Expanded(
        child: pw.FittedBox(
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.CustomPaint(
              size: const PdfPoint(400, 400),
              painter: (PdfGraphics graphics, PdfPoint size) {
                graphics.saveContext();
                const double renderSize = 220.0;
                const double baseSize = 400.0;
                final double scale = renderSize / baseSize;
                final bridge = PdfDiagramCanvas(
                  graphics,
                  pdfContext.document,
                  size.y,
                  pdfFont: unicodeFont.getFont(pdfContext),
                  scale: scale,
                );
                painter.drawDiagram(bridge, const Size(400, 400));
                graphics.restoreContext();
              },
            ),
          ),
        ),
      ),
    );

    if (i < dWidget.painters.length - 1) {
      pdfDiagrams.add(pw.SizedBox(width: 8, height: 8));
    }
  }

  return pw.Container(
    child: dWidget.axis == Axis.horizontal
        ? pw.Row(children: pdfDiagrams)
        : pw.Column(children: pdfDiagrams),
  );
}

pw.Widget _buildSingleDiagramColumn(
  DiagramWidget dWidget,
  pw.Font unicodeFont,
  pw.Context pdfContext,
) {
  final String effectiveTitle =
      dWidget.title ?? dWidget.painters.first.diagram.toText;
  final String effectiveDescription = stripHtmlIfNeeded(
    dWidget.description ?? dWidget.painters.first.diagram.description,
  );

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Text(
          stripHtmlIfNeeded(effectiveTitle),
          softWrap: true,
          style: pw.TextStyle(
            font: unicodeFont,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      if (effectiveDescription.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Text(
            effectiveDescription,
            softWrap: true,
            style: pw.TextStyle(
              font: unicodeFont,
              fontSize: 8.5,
              color: PdfColors.grey700,
            ),
          ),
        ),
      _buildDiagramImagesOnly(dWidget, unicodeFont, pdfContext),
    ],
  );
}

// =============================================================================
// HTML PDF BUILDER
// =============================================================================

class HtmlPdfBuilder {
  static List<pw.Widget> build(
    String html, {
    required pw.Font regularFont,
    pw.Font? boldFont,
    pw.Font? italicFont,
  }) {
    final document = html_parser.parse(html);
    return _parseBlocks(
      document.body?.nodes ?? [],
      regularFont,
      boldFont,
      italicFont,
    );
  }

  static List<pw.Widget> _parseBlocks(
    List<dom.Node> nodes,
    pw.Font font,
    pw.Font? boldFont,
    pw.Font? italicFont,
  ) {
    List<pw.Widget> widgets = [];
    for (var node in nodes) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'h1':
          case 'h2':
          case 'h3':
          case 'h4':
            final double size = node.localName == 'h1'
                ? 15
                : (node.localName == 'h2' ? 13 : 11);
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 6, bottom: 2),
                child: pw.RichText(
                  text: _parseInline(
                    node,
                    font,
                    boldFont,
                    italicFont,
                    isBold: true,
                    fontSize: size,
                  ),
                ),
              ),
            );
            break;
          case 'p':
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.RichText(
                  text: _parseInline(node, font, boldFont, italicFont),
                ),
              ),
            );
            break;
          case 'ul':
          case 'ol':
            bool isOrdered = node.localName == 'ol';
            int index = 1;
            for (var li in node.children.where((e) => e.localName == 'li')) {
              widgets.add(
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 8, bottom: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        isOrdered ? '$index. ' : '•  ',
                        style: pw.TextStyle(font: font, fontSize: 10.5),
                      ),
                      pw.Expanded(
                        child: pw.RichText(
                          text: _parseInline(li, font, boldFont, italicFont),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              index++;
            }
            widgets.add(pw.SizedBox(height: 4));
            break;
          default:
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.RichText(
                  text: _parseInline(node, font, boldFont, italicFont),
                ),
              ),
            );
        }
      } else if (node is dom.Text && node.text.trim().isNotEmpty) {
        widgets.add(
          pw.RichText(text: _parseInline(node, font, boldFont, italicFont)),
        );
      }
    }
    return widgets;
  }

  static pw.TextSpan _parseInline(
    dom.Node node,
    pw.Font font,
    pw.Font? boldFont,
    pw.Font? italicFont, {
    bool isBold = false,
    bool isItalic = false,
    double fontSize = 10.5,
  }) {
    if (node is dom.Text) {
      String text = node.text.replaceAll(RegExp(r'\s+'), ' ');
      return pw.TextSpan(
        text: text,
        style: pw.TextStyle(
          font: isBold
              ? (boldFont ?? font)
              : (isItalic ? (italicFont ?? font) : font),
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontStyle: isItalic ? pw.FontStyle.italic : pw.FontStyle.normal,
          fontSize: fontSize,
          lineSpacing: 1.3,
        ),
      );
    } else if (node is dom.Element) {
      if (node.localName == 'br') return const pw.TextSpan(text: '\n');
      bool bold = isBold || node.localName == 'b' || node.localName == 'strong';
      bool italic = isItalic || node.localName == 'i' || node.localName == 'em';
      return pw.TextSpan(
        children: node.nodes
            .map(
              (n) => _parseInline(
                n,
                font,
                boldFont,
                italicFont,
                isBold: bold,
                isItalic: italic,
                fontSize: fontSize,
              ),
            )
            .toList(),
      );
    }
    return const pw.TextSpan();
  }
}
