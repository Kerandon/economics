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
import '../../models/term.dart';
import '../real_world_examples/real_world_examples.dart';
import '../terms/terms.dart';

Future<Uint8List> exportQuickNotesToPdf(
    List<Slide> allSlides,
    AllDiagrams allDiagramsService,
    Function(double progress, String status) onProgress,
    String documentTitle,
    ) async {
  final pdf = pw.Document();

  onProgress(0.0, 'Loading fonts...');
  await Future.delayed(Duration.zero);

  // Load standard fonts
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

  final Set<String> activeSubunitNames = slidesBySubunit.keys.map((s) => s.name).toSet();
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
                padding: const pw.EdgeInsets.all(24),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  border: pw.Border.all(color: PdfColors.indigo200, width: 2),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Name: __________________________', style: pw.TextStyle(font: unicodeFont, fontSize: 14)),
                    pw.SizedBox(height: 24),
                    pw.Text('Date:   __________________________', style: pw.TextStyle(font: unicodeFont, fontSize: 14)),
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
      margin: const pw.EdgeInsets.all(48), // Premium wider margins
      footer: (pw.Context context) => _buildFooter(context, unicodeFont, 'Table of Contents'),
      build: (pw.Context context) {
        List<pw.Widget> tocElements = [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'TABLE OF CONTENTS',
                style: pw.TextStyle(font: boldUnicodeFont, fontSize: 20, color: PdfColors.indigo900, letterSpacing: 1.5),
              ),
              pw.Text('Revised', style: pw.TextStyle(font: boldUnicodeFont, fontSize: 12, color: PdfColors.indigo900)),
            ],
          ),
          pw.SizedBox(height: 16),
        ];

        for (var subunit in slidesBySubunit.keys) {
          tocElements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Link(
                    destination: 'subunit_${subunit.name}',
                    child: pw.Text('${subunit.id} ${subunit.title}', style: pw.TextStyle(font: boldUnicodeFont, fontSize: 11, color: PdfColors.indigo700)),
                  ),
                  pw.Container(
                    width: 14, height: 14,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      border: pw.Border.all(color: PdfColors.grey600, width: 1.0),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        tocElements.addAll([
          pw.SizedBox(height: 16),
          pw.Divider(thickness: 1, color: PdfColors.grey300),
          pw.SizedBox(height: 8),
          _buildTocAppendixLink('APPENDIX A: GLOSSARY OF TERMS', 'appendix_a', boldUnicodeFont),
          _buildTocAppendixLink('APPENDIX B: REAL WORLD EXAMPLES', 'appendix_b', boldUnicodeFont),
          _buildTocAppendixLink('APPENDIX C: ALL DIAGRAMS', 'appendix_c', boldUnicodeFont),
        ]);

        return tocElements;
      },
    ),
  );

  // --- 3. MAIN CONTENT ---
  for (var entry in slidesBySubunit.entries) {
    final Subunit subunit = entry.key;
    final List<Slide> subunitSlides = entry.value;

    processed++;
    onProgress((processed / totalSubunits) * 0.7, 'Generating ${subunit.title}...');
    await Future.delayed(const Duration(milliseconds: 10));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48), // Premium wider margins
        footer: (pw.Context context) => _buildFooter(context, unicodeFont, subunit.title),
        build: (pw.Context pdfContext) {
          List<pw.Widget> pageElements = [
            pw.Anchor(
              name: 'subunit_${subunit.name}',
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      '${subunit.id} ${subunit.title}'.toUpperCase(),
                      style: pw.TextStyle(font: boldUnicodeFont, fontSize: 20, color: PdfColors.indigo900, letterSpacing: 1.2),
                    ),
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('Unit Revised', style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: PdfColors.grey700)),
                      pw.SizedBox(width: 6),
                      pw.Container(
                        width: 14, height: 14,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          border: pw.Border.all(color: PdfColors.grey600, width: 1.0),
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
            pw.SizedBox(height: 16),
          ];

          for (var slide in subunitSlides) {
            bool isHL = HlStyle.hasHL(slide.tags);
            final heading = slide.question ?? slide.title;

            if (heading.isNotEmpty) {
              pageElements.add(
                pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(font: boldUnicodeFont, fontSize: 14, color: PdfColors.black, height: 1.2),
                    children: [
                      if (isHL) pw.TextSpan(text: '[HL] ', style: pw.TextStyle(color: PdfColors.purple800)),
                      pw.TextSpan(text: heading),
                    ],
                  ),
                ),
              );
              pageElements.add(pw.SizedBox(height: 10));
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

            pageElements.add(pw.SizedBox(height: 20));
          }

          return pageElements;
        },
      ),
    );
  }

  // --- 4. APPENDIX A: TERMS ---
  onProgress(0.75, 'Generating Appendix A...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, List<EconTerm>> termsBySubunit = {};
  for (var term in EconTerm.values) {
    if (term.subunit == null || !activeSubunitNames.contains(term.subunit!.name)) continue;
    termsBySubunit.putIfAbsent(term.subunit!, () => []).add(term);
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(48), // Premium wider margins
      footer: (pw.Context context) => _buildFooter(context, unicodeFont, 'Appendix A: Glossary'),
      build: (pw.Context context) {
        List<pw.Widget> elements = _buildAppendixHeader('APPENDIX A: GLOSSARY OF TERMS', 'appendix_a', boldUnicodeFont);

        for (var entry in termsBySubunit.entries) {
          elements.add(_buildAppendixSubhead('${entry.key.id} ${entry.key.title}', boldUnicodeFont));

          final termRows = <pw.TableRow>[];
          for (int i = 0; i < entry.value.length; i++) {
            final term = entry.value[i];
            final bool isHL = term.tags != null ? HlStyle.hasHL(term.tags!) : false;

            termRows.add(
              pw.TableRow(
                decoration: pw.BoxDecoration(color: i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
                children: [
                  _buildTableCell(isHL ? '[HL] ${term.termName}' : term.termName, boldUnicodeFont, isHL ? PdfColors.purple900 : PdfColors.indigo900),
                  _buildTableCell(stripHtmlIfNeeded(term.explanation), unicodeFont, PdfColors.grey900),
                ],
              ),
            );
          }
          elements.add(pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: const {0: pw.FlexColumnWidth(1.2), 1: pw.FlexColumnWidth(2.8)},
            children: termRows,
          ));
        }
        return elements;
      },
    ),
  );

  // --- 5. APPENDIX B: REAL WORLD EXAMPLES ---
  onProgress(0.85, 'Generating Appendix B...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, List<RealWorldExamples>> rweBySubunit = {};
  for (var rwe in RealWorldExamples.values) {
    if (rwe.subunit == null || !activeSubunitNames.contains(rwe.subunit!.name)) continue;
    rweBySubunit.putIfAbsent(rwe.subunit!, () => []).add(rwe);
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(48), // Premium wider margins
      footer: (pw.Context context) => _buildFooter(context, unicodeFont, 'Appendix B: Examples'),
      build: (pw.Context context) {
        List<pw.Widget> elements = _buildAppendixHeader('APPENDIX B: REAL WORLD EXAMPLES', 'appendix_b', boldUnicodeFont);

        for (var entry in rweBySubunit.entries) {
          elements.add(_buildAppendixSubhead('${entry.key.id} ${entry.key.title}', boldUnicodeFont));

          for (var rwe in entry.value) {

            // Wrap the topic title and table together to prevent page splitting
            final List<pw.Widget> rweGroup = [];

            rweGroup.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: pw.Text(rwe.topicName, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: PdfColors.black)),
              ),
            );

            final rweRows = <pw.TableRow>[];
            for (int i = 0; i < rwe.examples.length; i++) {
              final ex = rwe.examples[i];
              final bool isHL = ex.tags != null ? HlStyle.hasHL(ex.tags!) : false;

              rweRows.add(
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
                  children: [
                    _buildTableCell(isHL ? '[HL] ${ex.title}' : ex.title, boldUnicodeFont, isHL ? PdfColors.purple900 : PdfColors.indigo900),
                    _buildTableCell(stripHtmlIfNeeded(ex.explanation), unicodeFont, PdfColors.black),
                  ],
                ),
              );
            }

            rweGroup.add(pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              columnWidths: const {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(2.5)},
              children: rweRows,
            ));

            // pw.Wrap effectively keeps the entire column block on one page if possible
            elements.add(pw.Wrap(
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: rweGroup,
                  )
                ]
            ));

            elements.add(pw.SizedBox(height: 10));
          }
        }
        return elements;
      },
    ),
  );

  // --- 6. APPENDIX C: ALL DIAGRAMS GRID ---
  onProgress(0.95, 'Generating Appendix C...');
  await Future.delayed(const Duration(milliseconds: 10));

  final Map<Subunit, Map<DiagramEnum, bool>> diagramsBySubunit = {};
  for (var slide in allSlides) {
    if (slide.subunit == null || slide.contents == null) continue;
    final bool slideIsHL = HlStyle.hasHL(slide.tags);

    for (var block in slide.contents!) {
      if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
        final bool isHL = slideIsHL || (block.content?.tags != null ? HlStyle.hasHL(block.content!.tags) : false);
        diagramsBySubunit.putIfAbsent(slide.subunit!, () => {});
        for (var d in block.diagramEnums!) {
          diagramsBySubunit[slide.subunit!]![d] = isHL || (diagramsBySubunit[slide.subunit!]![d] ?? false);
        }
      }
    }
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(48), // Premium wider margins
      footer: (pw.Context context) => _buildFooter(context, unicodeFont, 'Appendix C: All Diagrams'),
      build: (pw.Context context) {
        List<pw.Widget> elements = _buildAppendixHeader('APPENDIX C: ALL DIAGRAMS', 'appendix_c', boldUnicodeFont);

        for (var entry in diagramsBySubunit.entries) {
          if (entry.value.isEmpty) continue;
          elements.add(_buildAppendixSubhead('${entry.key.id} ${entry.key.title}', boldUnicodeFont));

          elements.add(
            pw.Wrap(
              spacing: 16,
              runSpacing: 16,
              children: entry.value.entries.map((diagEntry) {
                final diagEnum = diagEntry.key;
                final bool isHL = diagEntry.value;
                final widgets = allDiagramsService.getDiagramWidgets(diagrams: [diagEnum]).toList();

                if (widgets.isEmpty || widgets.first.painters.isEmpty) return pw.Container();

                final painters = widgets.first.painters;
                const double renderSize = 145.0; // Adjusted optimally for 48px margins
                const double scale = renderSize / BASE_DIAGRAM_SIZE;
                final double boxWidth = 16 + (renderSize * painters.length) + (10 * (painters.length - 1));

                // A single container intrinsically stays together on a page
                return pw.Container(
                  width: boxWidth,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: isHL ? PdfColors.purple50 : PdfColors.grey50,
                    border: pw.Border.all(color: isHL ? PdfColors.purple300 : PdfColors.grey300, width: 1.0),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
                  ),
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Container(
                        height: 28,
                        alignment: pw.Alignment.topCenter,
                        child: pw.Text(
                          isHL ? '[HL] ${_formatEnumName(diagEnum.name)}' : _formatEnumName(diagEnum.name),
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(font: boldUnicodeFont, fontSize: 9, color: isHL ? PdfColors.purple900 : PdfColors.black),
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: painters.map((painter) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                            child: pw.SizedBox(
                              width: renderSize,
                              height: renderSize,
                              child: pw.CustomPaint(
                                size: const PdfPoint(renderSize, renderSize),
                                painter: (PdfGraphics graphics, PdfPoint size) {
                                  graphics.saveContext();
                                  final bridge = PdfDiagramCanvas(
                                    graphics,
                                    context.document,
                                    size.y,
                                    pdfFont: unicodeFont.getFont(context),
                                    scale: scale,
                                  );
                                  painter.drawDiagram(bridge, const Size(renderSize, renderSize));
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
  return await pdf.save();
}

// =============================================================================
// HELPER METHODS
// =============================================================================

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
          margin: const pw.EdgeInsets.only(bottom: 6, top: 8),
          padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: pw.BoxDecoration(
            color: HlStyle.bgColor(isHL),
            border: pw.Border(left: pw.BorderSide(color: HlStyle.borderColor(isHL), width: 3)),
          ),
          child: pw.Text(title, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: HlStyle.textColor(isHL))),
        ),
      );
      seenHeaders.add(title);
    }
  }

  if (slide.contents == null) return elements;

  for (var block in slide.contents!) {

    // 1. TERMS
    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      tryAddHeader('TERMS', isHL: slideIsHL);
      final List<EconTerm> sortedTerms = List<EconTerm>.from(block.econTerms!)
        ..sort((a, b) {
          final bool aHL = a.tags != null ? HlStyle.hasHL(a.tags!) : false;
          final bool bHL = b.tags != null ? HlStyle.hasHL(b.tags!) : false;
          if (aHL != bHL) return aHL ? 1 : -1;
          return a.termName.compareTo(b.termName);
        });

      final termRows = <pw.TableRow>[];
      for (int i = 0; i < sortedTerms.length; i++) {
        final term = sortedTerms[i];
        final bool isHL = term.tags != null ? HlStyle.hasHL(term.tags!) : false;

        termRows.add(
          pw.TableRow(
            decoration: pw.BoxDecoration(color: i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
            children: [
              _buildTableCell(isHL ? '[HL] ${term.termName}' : term.termName, boldUnicodeFont, isHL ? PdfColors.purple900 : PdfColors.indigo900),
              pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.RichText(
                  text: HtmlPdfBuilder._parseInline(html_parser.parse(term.explanation).body!, unicodeFont, boldUnicodeFont, null, fontSize: 9.5),
                ),
              ),
            ],
          ),
        );
      }
      elements.add(pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
        columnWidths: const {0: pw.FlexColumnWidth(1.2), 1: pw.FlexColumnWidth(2.8)},
        children: termRows,
      ));
      elements.add(pw.SizedBox(height: 10));
    }

    // 2. MAIN TEXT CONTENT
    if (block.content != null && block.content!.text.isNotEmpty) {
      final bool blockIsHL = block.content!.tags != null ? HlStyle.hasHL(block.content!.tags!) : false;
      final List<pw.Widget> htmlWidgets = HtmlPdfBuilder.build(block.content!.text, regularFont: unicodeFont, boldFont: boldUnicodeFont);

      if (blockIsHL && !slideIsHL) {
        elements.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: HlStyle.bgColor(true),
              border: pw.Border(left: pw.BorderSide(color: HlStyle.borderColor(true), width: 3)),
            ),
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: htmlWidgets),
          ),
        );
      } else {
        elements.addAll(htmlWidgets);
      }
      elements.add(pw.SizedBox(height: 10));
    }

    // 3. REAL WORLD EXAMPLES
    if (block.realWorldExamples != null && block.realWorldExamples!.isNotEmpty) {
      tryAddHeader('REAL WORLD EXAMPLES', isHL: slideIsHL);
      for (final topic in block.realWorldExamples!) {
        if (topic.examples.isEmpty) continue;

        // Group RWE Title and Table together to prevent splitting
        final List<pw.Widget> rweGroup = [];

        rweGroup.add(pw.Padding(
          padding: const pw.EdgeInsets.only(top: 6.0, bottom: 4.0),
          child: pw.Text(topic.topicName, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: PdfColors.black)),
        ));

        final rweRows = <pw.TableRow>[];
        for (int i = 0; i < topic.examples.length; i++) {
          final rwe = topic.examples[i];
          final bool isHL = rwe.tags != null ? HlStyle.hasHL(rwe.tags!) : false;

          rweRows.add(
            pw.TableRow(
              decoration: pw.BoxDecoration(color: i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
              children: [
                _buildTableCell(isHL ? '[HL] ${rwe.title}' : rwe.title, boldUnicodeFont, isHL ? PdfColors.purple900 : PdfColors.indigo900),
                _buildTableCell(stripHtmlIfNeeded(rwe.explanation), unicodeFont, PdfColors.black),
              ],
            ),
          );
        }
        rweGroup.add(pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: const {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(2.5)},
          children: rweRows,
        ));

        // pw.Wrap effectively keeps the entire column block on one page if possible
        elements.add(pw.Wrap(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: rweGroup,
              )
            ]
        ));

        elements.add(pw.SizedBox(height: 10));
      }
    }

    // 4. DIAGRAMS
    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {

      // Group Diagram Title/Description and Diagram Row together
      final List<pw.Widget> diagramGroup = [];

      if (block.diagramDescription != null) {
        diagramGroup.addAll(HtmlPdfBuilder.build(block.diagramDescription!, regularFont: unicodeFont, boldFont: boldUnicodeFont));
      }
      final widgets = allDiagramsService.getDiagramWidgets(diagrams: block.diagramEnums!).toList();
      diagramGroup.add(buildPdfDiagramRow(widgets, unicodeFont, pdfContext));

      // Use pw.Wrap to prevent the diagram block from splitting across pages
      elements.add(pw.Wrap(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: diagramGroup,
            )
          ]
      ));

      elements.add(pw.SizedBox(height: 10));
    }

    // 5. DATA TABLES
    if (block.tableData != null) {
      final table = block.tableData!;

      // Group Table Title, Table, and Caption together
      final List<pw.Widget> tableGroup = [];

      if (table.title != null && table.title!.isNotEmpty) {
        final bool isHL = table.tags != null ? HlStyle.hasHL(table.tags!) : false;
        tableGroup.add(pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4.0, bottom: 6.0),
          child: pw.Text(table.title!, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: isHL ? PdfColors.purple900 : PdfColors.black)),
        ));
      }

      final Map<int, pw.TableColumnWidth> columnWidths = {};
      for (int i = 0; i < table.headers.length; i++) {
        columnWidths[i] = pw.FlexColumnWidth((table.flexColumnWidths != null && i < table.flexColumnWidths!.length) ? table.flexColumnWidths![i] : 1.0);
      }

      tableGroup.add(
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: columnWidths,
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: table.headers.map((h) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: pw.RichText(text: HtmlPdfBuilder._parseInline(html_parser.parse(h).body!, boldUnicodeFont, boldUnicodeFont, null, fontSize: 9.5)),
              )).toList(),
            ),
            ...table.data.map((row) => pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.white),
              children: row.map((cell) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: pw.RichText(text: HtmlPdfBuilder._parseInline(html_parser.parse(cell).body!, unicodeFont, boldUnicodeFont, null, fontSize: 9.0)),
              )).toList(),
            )),
          ],
        ),
      );

      if (table.figCaption != null && table.figCaption!.isNotEmpty) {
        tableGroup.add(pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4.0),
          child: pw.Text(table.figCaption!, style: pw.TextStyle(font: unicodeFont, fontSize: 8, color: PdfColors.grey700, fontStyle: pw.FontStyle.italic)),
        ));
      }

      // Use pw.Wrap to prevent the table block from splitting across pages
      elements.add(pw.Wrap(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: tableGroup,
            )
          ]
      ));

      elements.add(pw.SizedBox(height: 10));
    }
  }
  return elements;
}

// Reusable UI Builders for Appendix
pw.Widget _buildTocAppendixLink(String title, String destination, pw.Font font) {
  return pw.Link(
    destination: destination,
    child: pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Text(title, style: pw.TextStyle(font: font, fontSize: 11, color: PdfColors.indigo900)),
    ),
  );
}

List<pw.Widget> _buildAppendixHeader(String title, String anchorName, pw.Font font) {
  return [
    pw.Anchor(
      name: anchorName,
      child: pw.Text(title, style: pw.TextStyle(font: font, fontSize: 20, color: PdfColors.indigo900, letterSpacing: 1.2)),
    ),
    pw.SizedBox(height: 6),
    pw.Divider(thickness: 1.5, color: PdfColors.indigo300),
    pw.SizedBox(height: 16),
  ];
}

pw.Widget _buildAppendixSubhead(String title, pw.Font font) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 12, bottom: 8),
    child: pw.Text(title, style: pw.TextStyle(font: font, fontSize: 14, color: PdfColors.indigo700)),
  );
}

pw.Widget _buildTableCell(String text, pw.Font font, PdfColor color) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(6),
    child: pw.Text(text, style: pw.TextStyle(font: font, fontSize: 9.5, color: color)),
  );
}

pw.Widget _buildFooter(pw.Context context, pw.Font font, String sectionTitle) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 12),
    padding: const pw.EdgeInsets.only(top: 8),
    decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey400, width: 1.2))
    ),
    child: pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(sectionTitle, style: pw.TextStyle(font: font, fontSize: 8, color: PdfColors.grey600)),
            pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: pw.TextStyle(font: font, fontSize: 8, color: PdfColors.grey600)),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(kCopyRight, style: pw.TextStyle(font: font, fontSize: 7, color: PdfColors.grey500)),
        ),
      ],
    ),
  );
}

String _formatEnumName(String name) {
  if (name.isEmpty) return name;
  String s = name.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), ' ');
  return s.substring(0, 1).toUpperCase() + s.substring(1);
}

String stripHtmlIfNeeded(String text) {
  String parsed = text.replaceAll('\n', ' ');
  parsed = parsed.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  parsed = parsed.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n');
  parsed = parsed.replaceAll(RegExp(r'<li>', caseSensitive: false), '\n- ');
  parsed = parsed.replaceAll(RegExp(r'<[^>]*>', multiLine: true), '');
  // Silent text replacement for common missing glyphs
  parsed = parsed.replaceAll('↑', '(increases)').replaceAll('↓', '(decreases)');
  parsed = parsed.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  return parsed.trim();
}

pw.Widget buildPdfDiagramRow(List<DiagramWidget> widgets, pw.Font unicodeFont, pw.Context pdfContext) {
  if (widgets.isEmpty) return pw.Container();
  int totalDiagrams = widgets.fold(0, (sum, w) => sum + w.painters.length);
  if (totalDiagrams == 0) return pw.Container();

  // Optimized sizes for 48px margins
  double renderSize = totalDiagrams <= 2 ? 220.0 : (totalDiagrams == 3 ? 145.0 : 120.0);
  final double scale = renderSize / BASE_DIAGRAM_SIZE;

  final List<pw.Widget> allPainters = [];
  for (var dWidget in widgets) {
    for (var painter in dWidget.painters) {
      allPainters.add(
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.SizedBox(
            width: renderSize, height: renderSize,
            child: pw.CustomPaint(
              size: PdfPoint(renderSize, renderSize),
              painter: (PdfGraphics graphics, PdfPoint size) {
                graphics.saveContext();
                final bridge = PdfDiagramCanvas(graphics, pdfContext.document, size.y, pdfFont: unicodeFont.getFont(pdfContext), scale: scale);
                painter.drawDiagram(bridge, Size(renderSize, renderSize));
                graphics.restoreContext();
              },
            ),
          ),
        ),
      );
    }
  }
  return pw.Center(child: pw.Wrap(spacing: 12, runSpacing: 12, alignment: pw.WrapAlignment.center, children: allPainters));
}

// =============================================================================
// HTML PDF BUILDER
// =============================================================================

class HtmlPdfBuilder {
  static List<pw.Widget> build(String html, {required pw.Font regularFont, pw.Font? boldFont, pw.Font? italicFont, PdfColor? textColor}) {
    final document = html_parser.parse(html);
    return _parseBlocks(document.body?.nodes ?? [], regularFont, boldFont, italicFont, textColor: textColor);
  }

  static List<pw.Widget> _parseBlocks(List<dom.Node> nodes, pw.Font font, pw.Font? boldFont, pw.Font? italicFont, {int indentLevel = 0, PdfColor? textColor}) {
    List<pw.Widget> widgets = [];
    for (var node in nodes) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'h1':
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(top: 10, bottom: 4), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, isBold: true, fontSize: 14, textColor: textColor))));
            break;
          case 'h2':
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(top: 8, bottom: 4), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, isBold: true, fontSize: 12, textColor: textColor))));
            break;
          case 'h3':
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(top: 6, bottom: 2), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, isBold: true, fontSize: 11, textColor: textColor))));
            break;
          case 'p':
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(bottom: 4), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, textColor: textColor))));
            break;
          case 'ul':
          case 'ol':
            bool isOrdered = node.localName == 'ol';
            int index = 1;
            for (var li in node.children.where((e) => e.localName == 'li')) {
              final inlineNodes = li.nodes.where((n) => n is! dom.Element || (n.localName != 'ul' && n.localName != 'ol')).toList();
              final blockNodes = li.nodes.where((n) => n is dom.Element && (n.localName == 'ul' || n.localName == 'ol')).toList();

              widgets.add(
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: (indentLevel == 0 ? 8.0 : 0.0) + (10.0 * indentLevel), bottom: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(isOrdered ? '$index. ' : '•  ', style: pw.TextStyle(font: isOrdered ? (boldFont ?? font) : font, fontSize: 9.5, color: textColor ?? PdfColors.black)),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            if (inlineNodes.isNotEmpty) pw.RichText(text: _parseInline(dom.Element.tag('span')..nodes.addAll(inlineNodes), font, boldFont, italicFont, textColor: textColor)),
                            if (blockNodes.isNotEmpty) ..._parseBlocks(blockNodes, font, boldFont, italicFont, indentLevel: indentLevel + 1, textColor: textColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              index++;
            }
            if (indentLevel == 0) widgets.add(pw.SizedBox(height: 4));
            break;
          default:
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(bottom: 4), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, textColor: textColor))));
        }
      } else if (node is dom.Text && node.text.trim().isNotEmpty) {
        widgets.add(pw.RichText(text: _parseInline(node, font, boldFont, italicFont, textColor: textColor)));
      }
    }
    return widgets;
  }

  static pw.TextSpan _parseInline(dom.Node node, pw.Font font, pw.Font? boldFont, pw.Font? italicFont, {bool isBold = false, bool isItalic = false, double fontSize = 9.5, PdfColor? textColor}) {
    if (node is dom.Text) {
      String text = node.text.replaceAll(RegExp(r'\s+'), ' ').replaceAll('↑', '(increases)').replaceAll('↓', '(decreases)');
      return pw.TextSpan(
        text: text,
        style: pw.TextStyle(
          font: isBold ? (boldFont ?? font) : (isItalic ? (italicFont ?? font) : font),
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontStyle: isItalic ? pw.FontStyle.italic : pw.FontStyle.normal,
          fontSize: fontSize,
          color: textColor ?? PdfColors.black,
          lineSpacing: 1.2,
        ),
      );
    } else if (node is dom.Element) {
      if (node.localName == 'br') return const pw.TextSpan(text: '\n');
      bool bold = isBold || node.localName == 'b' || node.localName == 'strong';
      bool italic = isItalic || node.localName == 'i' || node.localName == 'em';
      return pw.TextSpan(
        children: node.nodes.map((n) => _parseInline(n, font, boldFont, italicFont, isBold: bold, isItalic: italic, fontSize: fontSize, textColor: textColor)).toList(),
      );
    }
    return const pw.TextSpan();
  }
}