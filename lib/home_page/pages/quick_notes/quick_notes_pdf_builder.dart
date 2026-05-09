import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

import '../../../app/configs/constants.dart';
import '../../../app/configs/hl_style.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/models/pdf_diagram_canvas.dart';
import '../../enums/tag.dart';
import '../../models/slide.dart';

// Ensure your enums/models are imported correctly
import '../../models/term.dart';
import '../real_world_examples/real_world_examples.dart';
import '../terms/terms.dart';

Future<Uint8List> exportQuickNotesToPdf(
  List<Slide> allSlides,
  AllDiagrams allDiagramsService,
  Function(double progress, String status) onProgress,
  String documentTitle, // Passed dynamically from UI
) async {
  final pdf = pw.Document();

  onProgress(0.0, 'Loading fonts...');
  await Future.delayed(Duration.zero);

  final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final pw.Font unicodeFont = pw.Font.ttf(fontData);

  final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
  final pw.Font boldUnicodeFont = pw.Font.ttf(boldFontData);

  // Group slides by subunit
  final Map<Subunit, List<Slide>> slidesBySubunit = {};
  for (var slide in allSlides) {
    if (slide.subunit == null) continue;
    slidesBySubunit.putIfAbsent(slide.subunit!, () => []).add(slide);
  }

  // Track active subunits to filter global enums for Appendices A & B
  final Set<String> activeSubunitNames = slidesBySubunit.keys
      .map((s) => s.name)
      .toSet();

  int totalSubunits = slidesBySubunit.length;
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
                  fontSize: 42,
                  color: PdfColors.indigo900,
                  letterSpacing: 4.0,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                documentTitle.toUpperCase(),
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 20,
                  color: PdfColors.indigo700,
                  letterSpacing: 2.0,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 80),
              pw.Container(
                width: 320,
                padding: const pw.EdgeInsets.all(20),
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
                      style: pw.TextStyle(font: unicodeFont, fontSize: 14),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Text(
                      'Date:   __________________________',
                      style: pw.TextStyle(font: unicodeFont, fontSize: 14),
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

  // --- 2. CLICKABLE TABLE OF CONTENTS ---
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) =>
          _buildFooter(context, unicodeFont, 'Table of Contents'),
      build: (pw.Context context) {
        List<pw.Widget> tocElements = [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'TABLE OF CONTENTS',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 20,
                  color: PdfColors.indigo900,
                  letterSpacing: 1.5,
                ),
              ),
              pw.Text(
                'Revised',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 12,
                  color: PdfColors.indigo900,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 16),
        ];

        for (var subunit in slidesBySubunit.keys) {
          final anchorId = 'subunit_${subunit.name}';
          tocElements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Link(
                    destination: anchorId,
                    child: pw.Text(
                      '${subunit.id} ${subunit.title}',
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontSize: 11,
                        color: PdfColors.indigo700,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 14,
                    height: 14,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      border: pw.Border.all(
                        color: PdfColors.grey600,
                        width: 1.0,
                      ),
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Add Appendices to TOC
        tocElements.add(pw.SizedBox(height: 16));
        tocElements.add(pw.Divider(thickness: 1, color: PdfColors.grey300));
        tocElements.add(pw.SizedBox(height: 8));

        tocElements.add(
          pw.Link(
            destination: 'appendix_a',
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text(
                'APPENDIX A: GLOSSARY OF TERMS',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 11,
                  color: PdfColors.indigo900,
                ),
              ),
            ),
          ),
        );
        tocElements.add(
          pw.Link(
            destination: 'appendix_b',
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text(
                'APPENDIX B: REAL WORLD EXAMPLES',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 11,
                  color: PdfColors.indigo900,
                ),
              ),
            ),
          ),
        );
        tocElements.add(
          pw.Link(
            destination: 'appendix_c',
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text(
                'APPENDIX C: ALL DIAGRAMS',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 11,
                  color: PdfColors.indigo900,
                ),
              ),
            ),
          ),
        );

        return tocElements;
      },
    ),
  );

  // --- 3. MAIN CONTENT ---
  for (var entry in slidesBySubunit.entries) {
    final Subunit subunit = entry.key;
    final List<Slide> subunitSlides = entry.value;

    processed++;
    onProgress(
      (processed / totalSubunits) * 0.7,
      'Generating ${subunit.title}...',
    );
    await Future.delayed(const Duration(milliseconds: 10));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        footer: (pw.Context context) =>
            _buildFooter(context, unicodeFont, subunit.title),
        build: (pw.Context pdfContext) {
          List<pw.Widget> pageElements = [];

          pageElements.add(
            pw.Anchor(
              name: 'subunit_${subunit.name}',
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      '${subunit.id} ${subunit.title}'.toUpperCase(),
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontSize: 20,
                        color: PdfColors.indigo900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Unit Revised',
                        style: pw.TextStyle(
                          font: boldUnicodeFont,
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
                          border: pw.Border.all(
                            color: PdfColors.grey600,
                            width: 1.0,
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
          );

          pageElements.add(pw.SizedBox(height: 6));
          pageElements.add(
            pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
          );
          pageElements.add(pw.SizedBox(height: 16));

          for (var slide in subunitSlides) {
            bool isHL = HlStyle.hasHL(slide.tags);
            final heading = slide.question ?? slide.title;

            if (heading.isNotEmpty) {
              pageElements.add(
                pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(
                      font: boldUnicodeFont,
                      fontSize: 14,
                      color: PdfColors.black,
                      height: 1.2,
                    ),
                    children: [
                      if (isHL)
                        pw.TextSpan(
                          text: '[HL] ',
                          style: pw.TextStyle(color: PdfColors.purple800),
                        ),
                      pw.TextSpan(text: heading),
                    ],
                  ),
                ),
              );
              pageElements.add(pw.SizedBox(height: 8));
            }

            pageElements.addAll(
              _buildSlideContents(
                slide: slide,
                unicodeFont: unicodeFont,
                boldUnicodeFont: boldUnicodeFont,
                allDiagramsService: allDiagramsService,
                pdfContext: pdfContext,
              ),
            );

            pageElements.add(pw.SizedBox(height: 16));
          }

          return pageElements;
        },
      ),
    );
  }

  // --- 4. APPENDIX A: TERMS ---
  onProgress(0.75, 'Generating Appendix A (Glossary)...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, List<EconTerm>> termsBySubunit = {};
  for (var term in EconTerm.values) {
    if (term.subunit == null ||
        !activeSubunitNames.contains(term.subunit!.name))
      continue;
    termsBySubunit.putIfAbsent(term.subunit!, () => []).add(term);
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) =>
          _buildFooter(context, unicodeFont, 'Appendix A: Glossary'),
      build: (pw.Context context) {
        List<pw.Widget> elements = [
          pw.Anchor(
            name: 'appendix_a',
            child: pw.Text(
              'APPENDIX A: GLOSSARY OF TERMS',
              style: pw.TextStyle(
                font: boldUnicodeFont,
                fontSize: 20,
                color: PdfColors.indigo900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
          pw.SizedBox(height: 16),
        ];

        for (var entry in termsBySubunit.entries) {
          final subunit = entry.key;
          final terms = entry.value;

          elements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12, bottom: 8),
              child: pw.Text(
                '${subunit.id} ${subunit.title}',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 14,
                  color: PdfColors.indigo700,
                ),
              ),
            ),
          );

          final termRows = <pw.TableRow>[];
          for (int i = 0; i < terms.length; i++) {
            final term = terms[i];

            // Added dynamic HL checks for Appendix A
            final bool termIsHL = term.tags != null
                ? HlStyle.hasHL(term.tags!)
                : false;
            final String termLabel = termIsHL
                ? '[HL] ${term.termName}'
                : term.termName;
            final PdfColor termColor = termIsHL
                ? PdfColors.purple900
                : PdfColors.indigo900;

            final PdfColor rowColor = (i % 2 == 0
                ? PdfColors.white
                : PdfColors.grey100);

            termRows.add(
              pw.TableRow(
                decoration: pw.BoxDecoration(color: rowColor),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      termLabel,
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontSize: 9,
                        color: termColor,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      stripHtmlIfNeeded(term.explanation),
                      style: pw.TextStyle(
                        font: unicodeFont,
                        fontSize: 9,
                        color: PdfColors.grey900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          elements.add(
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              columnWidths: {
                0: const pw.FlexColumnWidth(1.2),
                1: const pw.FlexColumnWidth(2.8),
              },
              children: termRows,
            ),
          );
        }

        return elements;
      },
    ),
  );

  // --- 5. APPENDIX B: REAL WORLD EXAMPLES ---
  onProgress(0.85, 'Generating Appendix B (Examples)...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, List<RealWorldExamples>> rweBySubunit = {};
  for (var rwe in RealWorldExamples.values) {
    if (rwe.subunit == null || !activeSubunitNames.contains(rwe.subunit!.name))
      continue;
    rweBySubunit.putIfAbsent(rwe.subunit!, () => []).add(rwe);
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) =>
          _buildFooter(context, unicodeFont, 'Appendix B: Examples'),
      build: (pw.Context context) {
        List<pw.Widget> elements = [
          pw.Anchor(
            name: 'appendix_b',
            child: pw.Text(
              'APPENDIX B: REAL WORLD EXAMPLES',
              style: pw.TextStyle(
                font: boldUnicodeFont,
                fontSize: 20,
                color: PdfColors.indigo900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
          pw.SizedBox(height: 16),
        ];

        for (var entry in rweBySubunit.entries) {
          final subunit = entry.key;
          final rweList = entry.value;

          elements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12, bottom: 8),
              child: pw.Text(
                '${subunit.id} ${subunit.title}',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 14,
                  color: PdfColors.indigo700,
                ),
              ),
            ),
          );

          for (var rwe in rweList) {
            final String topicLabel = rwe.topicName;

            elements.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 6.0, bottom: 4.0),
                child: pw.Text(
                  topicLabel,
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
              ),
            );

            final rweRows = <pw.TableRow>[];
            for (int i = 0; i < rwe.examples.length; i++) {
              final ex = rwe.examples[i];

              // Added dynamic HL checks for Appendix B
              final bool exIsHL = ex.tags != null
                  ? HlStyle.hasHL(ex.tags!)
                  : false;
              final String exTitle = exIsHL ? '[HL] ${ex.title}' : ex.title;
              final PdfColor exColor = exIsHL
                  ? PdfColors.purple900
                  : PdfColors.indigo900;

              final PdfColor rowColor = i % 2 == 0
                  ? PdfColors.white
                  : PdfColors.grey100;

              rweRows.add(
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: rowColor),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        exTitle,
                        style: pw.TextStyle(
                          font: boldUnicodeFont,
                          fontSize: 9,
                          color: exColor,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        stripHtmlIfNeeded(ex.explanation),
                        style: pw.TextStyle(font: unicodeFont, fontSize: 9),
                      ),
                    ),
                  ],
                ),
              );
            }
            elements.add(
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColors.grey300,
                  width: 0.5,
                ),
                columnWidths: const {
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(2.5),
                },
                children: rweRows,
              ),
            );
            elements.add(pw.SizedBox(height: 8));
          }
        }

        return elements;
      },
    ),
  );

  // --- 6. APPENDIX C: ALL DIAGRAMS GRID ---
  onProgress(0.95, 'Generating Appendix C (Diagrams)...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, Map<DiagramEnum, bool>> diagramsBySubunit = {};

  for (var slide in allSlides) {
    if (slide.subunit == null) continue;

    final bool slideIsHL = HlStyle.hasHL(slide.tags);
    if (slide.contents != null) {
      for (var block in slide.contents!) {
        if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
          final bool isHL =
              slideIsHL ||
              (block.content?.tags != null
                  ? HlStyle.hasHL(block.content!.tags)
                  : false);

          diagramsBySubunit.putIfAbsent(slide.subunit!, () => {});
          for (var d in block.diagramEnums!) {
            diagramsBySubunit[slide.subunit!]![d] =
                isHL || (diagramsBySubunit[slide.subunit!]![d] ?? false);
          }
        }
      }
    }
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) =>
          _buildFooter(context, unicodeFont, 'Appendix C: All Diagrams'),
      build: (pw.Context context) {
        List<pw.Widget> elements = [
          pw.Anchor(
            name: 'appendix_c',
            child: pw.Text(
              'APPENDIX C: ALL DIAGRAMS',
              style: pw.TextStyle(
                font: boldUnicodeFont,
                fontSize: 20,
                color: PdfColors.indigo900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
          pw.SizedBox(height: 16),
        ];

        for (var entry in diagramsBySubunit.entries) {
          final subunit = entry.key;
          final diagramMap = entry.value;

          if (diagramMap.isEmpty) continue;

          elements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12, bottom: 12),
              child: pw.Text(
                '${subunit.id} ${subunit.title}',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 14,
                  color: PdfColors.indigo700,
                ),
              ),
            ),
          );

          elements.add(
            pw.Wrap(
              spacing: 16,
              runSpacing: 16,
              children: diagramMap.entries.map((diagEntry) {
                final diagEnum = diagEntry.key;
                final bool isHL = diagEntry.value;

                final String diagName = _formatEnumName(diagEnum.name);
                final String titleLabel = isHL ? '[HL] $diagName' : diagName;

                final widgets = allDiagramsService
                    .getDiagramWidgets(diagrams: [diagEnum])
                    .toList();

                if (widgets.isEmpty || widgets.first.painters.isEmpty) {
                  return pw.Container();
                }

                final painters = widgets.first.painters;
                final double renderSize = 140;
                final double scale = renderSize / BASE_DIAGRAM_SIZE;
                // Dynamically expand container width to fit all diagrams side by side
                final double boxWidth =
                    16 +
                    (renderSize * painters.length) +
                    (10 * (painters.length - 1));

                return pw.Container(
                  width: boxWidth,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: isHL ? PdfColors.purple50 : PdfColors.grey50,
                    border: pw.Border.all(
                      color: isHL ? PdfColors.purple300 : PdfColors.grey300,
                      width: 1.0,
                    ),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(6),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        height: 28,
                        alignment: pw.Alignment.topCenter,
                        child: pw.Text(
                          titleLabel,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: boldUnicodeFont,
                            fontSize: 9,
                            color: isHL ? PdfColors.purple900 : PdfColors.black,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: painters.map((painter) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: pw.Container(
                              width: renderSize,
                              height: renderSize,
                              child: pw.CustomPaint(
                                size: PdfPoint(renderSize, renderSize),
                                painter: (PdfGraphics graphics, PdfPoint size) {
                                  graphics.saveContext();
                                  final bridge = PdfDiagramCanvas(
                                    graphics,
                                    context.document,
                                    size.y,
                                    pdfFont: unicodeFont.getFont(context),
                                    scale:
                                        scale, // Keeping scaling proportional
                                  );
                                  painter.drawDiagram(
                                    bridge,
                                    Size(renderSize, renderSize),
                                  );
                                  graphics.restoreContext();
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
          elements.add(pw.SizedBox(height: 24));
        }

        return elements;
      },
    ),
  );

  onProgress(1.0, 'Finalizing document...');
  await Future.delayed(const Duration(milliseconds: 100));
  return await pdf.save();
}

String _formatEnumName(String name) {
  if (name.isEmpty) return name;
  String s = name.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), ' ');
  return s.substring(0, 1).toUpperCase() + s.substring(1);
}

List<pw.Widget> _buildSlideContents({
  required Slide slide,
  required pw.Font unicodeFont,
  required pw.Font boldUnicodeFont,
  required AllDiagrams allDiagramsService,
  required pw.Context pdfContext,
}) {
  List<pw.Widget> elements = [];
  final Set<String> seenHeaders = {};
  final bool slideIsHL = HlStyle.hasHL(slide.tags);

  void tryAddHeader(String baseTitle, {required bool isHL}) {
    final String title = HlStyle.label(baseTitle, isHL);
    if (!seenHeaders.contains(title)) {
      elements.add(
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 4, top: 6),
          padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: pw.BoxDecoration(
            color: HlStyle.bgColor(isHL),
            border: pw.Border(
              left: pw.BorderSide(color: HlStyle.borderColor(isHL), width: 3),
            ),
          ),
          child: pw.Row(
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 10,
                  color: HlStyle.textColor(isHL),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
      seenHeaders.add(title);
    }
  }

  if (slide.contents == null) return elements;

  for (var block in slide.contents!) {
    // 1. TERMS
    // 1. TERMS
    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      tryAddHeader('TERMS', isHL: slideIsHL);

      // 🌟 Step 1: Sort terms - Non-HL first (A-Z), then HL (A-Z)
      final List<EconTerm> sortedTerms = List<EconTerm>.from(block.econTerms!)
        ..sort((a, b) {
          final bool aIsHL = a.tags != null ? HlStyle.hasHL(a.tags!) : false;
          final bool bIsHL = b.tags != null ? HlStyle.hasHL(b.tags!) : false;

          if (aIsHL != bIsHL) {
            return aIsHL ? 1 : -1; // Pushes HL (true) to the end
          }
          // If both are same type, sort alphabetically by name
          return a.termName.compareTo(b.termName);
        });

      final termRows = <pw.TableRow>[];
      for (int i = 0; i < sortedTerms.length; i++) {
        final term = sortedTerms[i];

        final bool termIsHL = term.tags != null
            ? HlStyle.hasHL(term.tags!)
            : false;
        final PdfColor termColor = termIsHL
            ? PdfColors.purple900
            : PdfColors.indigo900;
        final String termLabel = termIsHL
            ? '[HL] ${term.termName}'
            : term.termName;

        final bool isEven = i % 2 == 0;

        termRows.add(
          pw.TableRow(
            decoration: pw.BoxDecoration(
              color: isEven ? PdfColors.white : PdfColors.grey100,
            ),
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(
                  termLabel,
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 9,
                    color: termColor,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.RichText(
                  // 🌟 Step 2: Use HtmlPdfBuilder to allow <b> tags inside the table
                  text: HtmlPdfBuilder._parseInline(
                    html_parser.parse(term.explanation).body!,
                    unicodeFont,
                    boldUnicodeFont,
                    null, // Italic font if you have it
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      elements.add(
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: const {
            0: pw.FlexColumnWidth(1.2),
            1: pw.FlexColumnWidth(2.8),
          },
          children: termRows,
        ),
      );
      elements.add(pw.SizedBox(height: 8));
    }

    // 2. MAIN TEXT CONTENT
    if (block.content != null && block.content!.text.isNotEmpty) {
      final bool blockIsHL = block.content!.tags != null
          ? HlStyle.hasHL(block.content!.tags!)
          : false;
      pw.Widget htmlContent = pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: HtmlPdfBuilder.build(
          block.content!.text,
          regularFont: unicodeFont,
          boldFont: boldUnicodeFont,
        ),
      );
      if (blockIsHL && !slideIsHL) {
        elements.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 6),
            padding: const pw.EdgeInsets.all(6),
            decoration: pw.BoxDecoration(
              color: HlStyle.bgColor(true),
              border: pw.Border(
                left: pw.BorderSide(color: HlStyle.borderColor(true), width: 3),
              ),
            ),
            child: htmlContent,
          ),
        );
      } else {
        elements.add(htmlContent);
      }
      elements.add(pw.SizedBox(height: 8));
    }

    // 3. REAL WORLD EXAMPLES
    if (block.realWorldExamples != null &&
        block.realWorldExamples!.isNotEmpty) {
      tryAddHeader('REAL WORLD EXAMPLES', isHL: slideIsHL);

      for (final topic in block.realWorldExamples!) {
        if (topic.examples.isEmpty) continue;

        elements.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 4.0, bottom: 2.0),
            child: pw.Text(
              topic.topicName,
              style: pw.TextStyle(
                font: boldUnicodeFont,
                fontSize: 10,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        );

        final rweRows = <pw.TableRow>[];
        for (int i = 0; i < topic.examples.length; i++) {
          final rwe = topic.examples[i];

          // Added dynamic HL checks for inline RWE
          final bool rweIsHL = rwe.tags != null
              ? HlStyle.hasHL(rwe.tags!)
              : false;
          final String rweTitle = rweIsHL ? '[HL] ${rwe.title}' : rwe.title;
          final PdfColor rweColor = rweIsHL
              ? PdfColors.purple900
              : PdfColors.indigo900;

          rweRows.add(
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: (i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
              ),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    rweTitle,
                    style: pw.TextStyle(
                      font: boldUnicodeFont,
                      fontSize: 9,
                      color: rweColor,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    stripHtmlIfNeeded(rwe.explanation),
                    style: pw.TextStyle(font: unicodeFont, fontSize: 9),
                  ),
                ),
              ],
            ),
          );
        }

        elements.add(
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: const {
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(2.5),
            },
            children: rweRows,
          ),
        );

        elements.add(pw.SizedBox(height: 8));
      }
    }

    // 4. DIAGRAMS
    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
      if (block.diagramDescription != null) {
        elements.addAll(
          HtmlPdfBuilder.build(
            block.diagramDescription!,
            regularFont: unicodeFont,
            boldFont: boldUnicodeFont,
          ),
        );
      }
      final widgets = allDiagramsService
          .getDiagramWidgets(diagrams: block.diagramEnums!)
          .toList();
      elements.add(buildPdfDiagramRow(widgets, unicodeFont, pdfContext));
      elements.add(pw.SizedBox(height: 8));
    }

    // 5. DATA TABLES
    if (block.tableData != null) {
      final table = block.tableData!;
      final bool tableIsHL = table.tags != null
          ? HlStyle.hasHL(table.tags!)
          : false;

      if (table.title != null && table.title!.isNotEmpty) {
        elements.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 2.0, bottom: 4.0),
            child: pw.Text(
              table.title!,
              style: pw.TextStyle(
                font: boldUnicodeFont,
                fontSize: 10,
                color: tableIsHL ? PdfColors.purple900 : PdfColors.black,
              ),
            ),
          ),
        );
      }

      // Dynamically build column widths
      final Map<int, pw.TableColumnWidth> dynamicColumnWidths = {};
      for (int i = 0; i < table.headers.length; i++) {
        if (table.flexColumnWidths != null &&
            i < table.flexColumnWidths!.length) {
          dynamicColumnWidths[i] = pw.FlexColumnWidth(
            table.flexColumnWidths![i],
          );
        } else {
          dynamicColumnWidths[i] = const pw.FlexColumnWidth(1.0);
        }
      }

      elements.add(
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: dynamicColumnWidths,
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            // HEADER ROW
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.white),
              children: table.headers.map((h) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 6,
                  ),
                  child: pw.RichText(
                    // 🌟 Support for HTML tags in Headers
                    text: HtmlPdfBuilder._parseInline(
                      html_parser.parse(h).body!,
                      boldUnicodeFont,
                      boldUnicodeFont,
                      null,
                      fontSize: 9.5,
                    ),
                  ),
                );
              }).toList(),
            ),
            // DATA ROWS
            ...table.data.map((row) {
              return pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.white),
                children: row.map((cell) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    child: pw.RichText(
                      // 🌟 Support for HTML tags in Cells (e.g. bolding in Payoff Matrix)
                      text: HtmlPdfBuilder._parseInline(
                        html_parser.parse(cell).body!,
                        unicodeFont,
                        boldUnicodeFont,
                        null,
                        fontSize: 9.0,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      );

      if (table.figCaption != null && table.figCaption!.isNotEmpty) {
        elements.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 2.0),
            child: pw.Text(
              table.figCaption!,
              style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 8,
                color: PdfColors.grey700,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ),
        );
      }

      elements.add(pw.SizedBox(height: 8));
    }
    // 6. TIPS
    if (block.tip != null && block.tip!.text.isNotEmpty) {
      elements.add(
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            border: pw.Border.all(color: PdfColors.blue200),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'TIP:',
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 9,
                  color: PdfColors.blue900,
                ),
              ),
              ...HtmlPdfBuilder.build(
                block.tip!.text,
                regularFont: unicodeFont,
                boldFont: boldUnicodeFont,
                textColor: PdfColors.blue900,
              ),
            ],
          ),
        ),
      );
      elements.add(pw.SizedBox(height: 8));
    }
  }
  return elements;
}

// =============================================================================
// HELPER METHODS
// =============================================================================

pw.Widget _buildFooter(pw.Context context, pw.Font font, String sectionTitle) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 10),
    padding: const pw.EdgeInsets.only(top: 6),
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        top: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
      ),
    ),
    child: pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              sectionTitle,
              style: pw.TextStyle(
                font: font,
                fontSize: 8,
                color: PdfColors.grey500,
              ),
            ),
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: pw.TextStyle(
                font: font,
                fontSize: 8,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        // 🌟 Professional Attribution Line
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(
            kCopyRight,
            style: pw.TextStyle(
              font: font,
              fontSize: 7,
              color: PdfColors.grey400,
            ),
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

  int totalDiagrams = 0;
  for (var dWidget in widgets) {
    totalDiagrams += dWidget.painters.length;
  }

  if (totalDiagrams == 0) return pw.Container();

  double renderSize;
  if (totalDiagrams <= 2) {
    renderSize = 220.0;
  } else if (totalDiagrams == 3) {
    renderSize = 145.0;
  } else {
    renderSize = 105.0;
  }

  final double scale = renderSize / BASE_DIAGRAM_SIZE;

  final List<pw.Widget> allPainters = [];

  for (var dWidget in widgets) {
    for (int i = 0; i < dWidget.painters.length; i++) {
      final painter = dWidget.painters[i];

      allPainters.add(
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Container(
            width: renderSize,
            height: renderSize,
            child: pw.CustomPaint(
              size: PdfPoint(renderSize, renderSize),
              painter: (PdfGraphics graphics, PdfPoint size) {
                graphics.saveContext();
                final bridge = PdfDiagramCanvas(
                  graphics,
                  pdfContext.document,
                  size.y,
                  pdfFont: unicodeFont.getFont(pdfContext),
                  scale: scale,
                );
                painter.drawDiagram(bridge, Size(renderSize, renderSize));
                graphics.restoreContext();
              },
            ),
          ),
        ),
      );
    }
  }

  return pw.Center(
    child: pw.Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: pw.WrapAlignment.center,
      children: allPainters,
    ),
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
    PdfColor? textColor,
  }) {
    final document = html_parser.parse(html);
    return _parseBlocks(
      document.body?.nodes ?? [],
      regularFont,
      boldFont,
      italicFont,
      textColor: textColor,
    );
  }

  static List<pw.Widget> _parseBlocks(
    List<dom.Node> nodes,
    pw.Font font,
    pw.Font? boldFont,
    pw.Font? italicFont, {
    int indentLevel = 0,
    PdfColor? textColor,
  }) {
    List<pw.Widget> widgets = [];
    for (var node in nodes) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'h1':
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.RichText(
                  text: _parseInline(
                    node,
                    font,
                    boldFont,
                    italicFont,
                    isBold: true,
                    fontSize: 14,
                    textColor: textColor,
                  ),
                ),
              ),
            );
            break;
          case 'h2':
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 8, bottom: 2),
                child: pw.RichText(
                  text: _parseInline(
                    node,
                    font,
                    boldFont,
                    italicFont,
                    isBold: true,
                    fontSize: 12,
                    textColor: textColor,
                  ),
                ),
              ),
            );
            break;
          case 'h3':
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
                    fontSize: 11,
                    textColor: textColor,
                  ),
                ),
              ),
            );
            break;
          case 'p':
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 2),
                child: pw.RichText(
                  text: _parseInline(
                    node,
                    font,
                    boldFont,
                    italicFont,
                    textColor: textColor,
                  ),
                ),
              ),
            );
            break;
          case 'ul':
          case 'ol':
            bool isOrdered = node.localName == 'ol';
            int index = 1;
            for (var li in node.children.where((e) => e.localName == 'li')) {
              final inlineNodes = li.nodes.where((n) {
                if (n is dom.Element) {
                  return n.localName != 'ul' && n.localName != 'ol';
                }
                return true;
              }).toList();

              final blockNodes = li.nodes.where((n) {
                if (n is dom.Element) {
                  return n.localName == 'ul' || n.localName == 'ol';
                }
                return false;
              }).toList();

              widgets.add(
                pw.Padding(
                  padding: pw.EdgeInsets.only(
                    left: (indentLevel == 0 ? 8.0 : 0.0) + (10.0 * indentLevel),
                    bottom: 1,
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        isOrdered ? '$index. ' : '•  ',
                        style: pw.TextStyle(
                          font: isOrdered ? (boldFont ?? font) : font,
                          fontSize: 9.5,
                          color: textColor ?? PdfColors.black,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            if (inlineNodes.isNotEmpty)
                              pw.RichText(
                                text: _parseInline(
                                  dom.Element.tag('span')
                                    ..nodes.addAll(inlineNodes),
                                  font,
                                  boldFont,
                                  italicFont,
                                  textColor: textColor,
                                ),
                              ),
                            if (blockNodes.isNotEmpty)
                              ..._parseBlocks(
                                blockNodes,
                                font,
                                boldFont,
                                italicFont,
                                indentLevel: indentLevel + 1,
                                textColor: textColor,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              index++;
            }
            if (indentLevel == 0) widgets.add(pw.SizedBox(height: 2));
            break;
          default:
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 2),
                child: pw.RichText(
                  text: _parseInline(
                    node,
                    font,
                    boldFont,
                    italicFont,
                    textColor: textColor,
                  ),
                ),
              ),
            );
        }
      } else if (node is dom.Text && node.text.trim().isNotEmpty) {
        widgets.add(
          pw.RichText(
            text: _parseInline(
              node,
              font,
              boldFont,
              italicFont,
              textColor: textColor,
            ),
          ),
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
    double fontSize = 9.5,
    PdfColor? textColor,
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
          color: textColor ?? PdfColors.black,
          lineSpacing: 1.1,
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
                textColor: textColor,
              ),
            )
            .toList(),
      );
    }
    return const pw.TextSpan();
  }
}
