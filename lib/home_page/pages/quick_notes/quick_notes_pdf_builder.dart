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

// =============================================================================
// EXPORT QUICK NOTES BOOKLET
// =============================================================================
Future<Uint8List> exportQuickNotesToPdf(
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

  final Map<Subunit, List<Slide>> slidesBySubunit = {};
  for (var slide in allSlides) {
    slidesBySubunit.putIfAbsent(slide.subunit, () => []).add(slide);
  }

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
                  fontSize: 48,
                  color: PdfColors.indigo900,
                  letterSpacing: 4.0,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                'Quick Revision Notes',
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 28,
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
                    pw.Text('Name: __________________________', style: pw.TextStyle(font: unicodeFont, fontSize: 16)),
                    pw.SizedBox(height: 24),
                    pw.Text('Date:   __________________________', style: pw.TextStyle(font: unicodeFont, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // 🌟 ADDED: CLICKABLE TABLE OF CONTENTS
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) => _buildFooter(context, unicodeFont, 'Table of Contents'),
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

        for (var subunit in slidesBySubunit.keys) {
          final anchorId = 'subunit_${subunit.name}';
          tocElements.add(
            pw.Link(
              destination: anchorId,
              child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 6),
                child: pw.Text(
                  '${subunit.id} ${subunit.title}', // Subunit Number
                  style: pw.TextStyle(
                    font: boldUnicodeFont,
                    fontSize: 12,
                    color: PdfColors.indigo700,
                  ),
                ),
              ),
            ),
          );
        }
        return tocElements;
      },
    ),
  );

  // --- 3. MAIN CONTENT ---
  for (var entry in slidesBySubunit.entries) {
    final Subunit subunit = entry.key;
    final List<Slide> subunitSlides = entry.value;

    processed++;
    onProgress(processed / totalSubunits, 'Generating ${subunit.title}...');
    await Future.delayed(const Duration(milliseconds: 10));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        footer: (pw.Context context) => _buildFooter(context, unicodeFont, subunit.title),
        build: (pw.Context pdfContext) {
          List<pw.Widget> pageElements = [];

          // 🌟 ADDED: ANCHOR TAG for the TOC
          pageElements.add(
            pw.Anchor(
              name: 'subunit_${subunit.name}',
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      // 🌟 ADDED: Subunit Number
                      '${subunit.id} ${subunit.title}'.toUpperCase(),
                      style: pw.TextStyle(
                        font: boldUnicodeFont,
                        fontSize: 26,
                        color: PdfColors.indigo900,
                        letterSpacing: 1.5,
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
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(width: 8),
                      pw.Container(
                        width: 18,
                        height: 18,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          border: pw.Border.all(color: PdfColors.grey600, width: 1.5),
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          pageElements.add(pw.SizedBox(height: 8));
          pageElements.add(pw.Divider(thickness: 2, color: PdfColors.indigo300));
          pageElements.add(pw.SizedBox(height: 24));

          for (var slide in subunitSlides) {
            bool isHL = HlStyle.hasHL(slide.tags);
            final heading = slide.question ?? slide.title;

            if (heading.isNotEmpty) {
              pageElements.add(
                pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(
                      font: boldUnicodeFont,
                      fontSize: 16,
                      color: PdfColors.black,
                      height: 1.3,
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
              pageElements.add(pw.SizedBox(height: 12));
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

            pageElements.add(pw.SizedBox(height: 32));
          }

          return pageElements;
        },
      ),
    );
  }

  onProgress(1.0, 'Finalizing document...');
  await Future.delayed(const Duration(milliseconds: 100));
  return await pdf.save();
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
          margin: const pw.EdgeInsets.only(bottom: 6, top: 8),
          padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: pw.BoxDecoration(
            color: HlStyle.bgColor(isHL),
            border: pw.Border(left: pw.BorderSide(color: HlStyle.borderColor(isHL), width: 4)),
          ),
          child: pw.Row(
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  font: boldUnicodeFont,
                  fontSize: 11,
                  color: HlStyle.textColor(isHL),
                  letterSpacing: 1.1,
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
    // 1. TERMS - Header KEPT
    if (block.econTerms != null && block.econTerms!.isNotEmpty) {
      tryAddHeader('TERMS', isHL: slideIsHL);
      // ... [Table building logic remains same]
      final termRows = <pw.TableRow>[];
      for (int i = 0; i < block.econTerms!.length; i++) {
        final term = block.econTerms![i];
        final bool termIsHL = HlStyle.hasHL(term.tags);
        final bool isEven = i % 2 == 0;
        final PdfColor termColor = termIsHL ? PdfColors.purple900 : PdfColors.indigo900;
        final String termLabel = termIsHL ? '${term.termName} [HL]' : term.termName;

        termRows.add(
          pw.TableRow(
            decoration: pw.BoxDecoration(color: isEven ? PdfColors.white : PdfColors.grey100),
            children: [
              pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(termLabel, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: termColor))),
              pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(stripHtmlIfNeeded(term.explanation), style: pw.TextStyle(font: unicodeFont, fontSize: 10, color: PdfColors.grey900, lineSpacing: 1.2))),
            ],
          ),
        );
      }
      elements.add(pw.Table(border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5), columnWidths: {0: const pw.FlexColumnWidth(1.2), 1: const pw.FlexColumnWidth(2.8)}, children: termRows));
      elements.add(pw.SizedBox(height: 16));
    }

    // 2. MAIN TEXT CONTENT - Header REMOVED
    if (block.content != null && block.content!.text.isNotEmpty) {
      final bool blockIsHL = HlStyle.hasHL(block.content!.tags);
      pw.Widget htmlContent = pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: HtmlPdfBuilder.build(block.content!.text, regularFont: unicodeFont, boldFont: boldUnicodeFont),
      );
      if (blockIsHL && !slideIsHL) {
        elements.add(pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(color: HlStyle.bgColor(true), border: pw.Border(left: pw.BorderSide(color: HlStyle.borderColor(true), width: 3))),
          child: htmlContent,
        ));
      } else {
        elements.add(htmlContent);
      }
      elements.add(pw.SizedBox(height: 12));
    }

    // 3. REAL WORLD EXAMPLES - Header RESTORED per request
    if (block.realWorldExamples != null && block.realWorldExamples!.isNotEmpty) {
      tryAddHeader('REAL WORLD EXAMPLES', isHL: slideIsHL); // Stylized title added back

      final rweRows = <pw.TableRow>[];
      for (int i = 0; i < block.realWorldExamples!.length; i++) {
        final rwe = block.realWorldExamples![i];
        rweRows.add(pw.TableRow(
          decoration: pw.BoxDecoration(color: i % 2 == 0 ? PdfColors.white : PdfColors.grey100),
          children: [
            pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(rwe.example, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: PdfColors.indigo900))),
            pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(stripHtmlIfNeeded(rwe.explanation ?? ''), style: pw.TextStyle(font: unicodeFont, fontSize: 10))),
          ],
        ));
      }
      elements.add(pw.Table(border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5), columnWidths: {0: const pw.FlexColumnWidth(1), 1: const pw.FlexColumnWidth(2.5)}, children: rweRows));
      elements.add(pw.SizedBox(height: 12));
    }

    // 4. DIAGRAMS - Header REMOVED
    if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
      if (block.diagramDescription != null) {
        elements.addAll(HtmlPdfBuilder.build(block.diagramDescription!, regularFont: unicodeFont, boldFont: boldUnicodeFont));
      }
      final widgets = allDiagramsService.getDiagramWidgets(diagrams: block.diagramEnums!).toList();
      elements.add(buildPdfDiagramRow(widgets, unicodeFont, pdfContext));
      elements.add(pw.SizedBox(height: 12));
    }

    // 5. DATA TABLES - Header REMOVED
    if (block.tableData != null) {
      final table = block.tableData!;
      final bool tableIsHL = HlStyle.hasHL(table.tags);
      elements.add(pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: tableIsHL ? PdfColors.purple100 : PdfColors.indigo50),
            children: table.headers.map((h) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(h, style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10)))).toList(),
          ),
          ...table.data.map((row) => pw.TableRow(
            children: row.map((cell) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(cell, style: pw.TextStyle(font: unicodeFont, fontSize: 10)))).toList(),
          )),
        ],
      ));
      elements.add(pw.SizedBox(height: 16));
    }

    // 6. TIPS - Header REMOVED (Static "TIP:" text remains inside container)
    if (block.tip != null && block.tip!.text.isNotEmpty) {
      elements.add(pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(color: PdfColors.blue50, border: pw.Border.all(color: PdfColors.blue200)),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('TIP:', style: pw.TextStyle(font: boldUnicodeFont, fontSize: 10, color: PdfColors.blue900)),
            ...HtmlPdfBuilder.build(block.tip!.text, regularFont: unicodeFont, boldFont: boldUnicodeFont, textColor: PdfColors.blue900),
          ],
        ),
      ));
      elements.add(pw.SizedBox(height: 12));
    }
  }
  return elements;
}

// ... [The rest of the helper methods and HtmlPdfBuilder remain identical] ...

// =============================================================================
// HELPER METHODS
// =============================================================================

pw.Widget _buildFooter(pw.Context context, pw.Font font, String sectionTitle) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 12),
    padding: const pw.EdgeInsets.only(top: 8),
    decoration: const pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300, width: 1.0))),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(sectionTitle, style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.grey500)),
        pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.grey500)),
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

  // Create a flat list of ALL individual diagram painters across all widgets
  final List<pw.Widget> allPainters = [];

  for (var dWidget in widgets) {
    // 🌟 THE FIX: Loop through the painters list inside the DiagramWidget
    for (int i = 0; i < dWidget.painters.length; i++) {
      final painter = dWidget.painters[i];
      final renderSize = 220.0;
      final scale = renderSize / BASE_DIAGRAM_SIZE;

      allPainters.add(
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Container(
            width: 220,
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
                // Draw the specific painter
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
  static List<pw.Widget> build(String html, {required pw.Font regularFont, pw.Font? boldFont, pw.Font? italicFont, PdfColor? textColor}) {
    final document = html_parser.parse(html);
    return _parseBlocks(document.body?.nodes ?? [], regularFont, boldFont, italicFont, textColor: textColor);
  }

  static List<pw.Widget> _parseBlocks(List<dom.Node> nodes, pw.Font font, pw.Font? boldFont, pw.Font? italicFont, {int indentLevel = 0, PdfColor? textColor}) {
    List<pw.Widget> widgets = [];
    for (var node in nodes) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'p':
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(bottom: 4), child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont, textColor: textColor))));
            break;
          case 'ul':
          case 'ol':
          // 🌟 FIXED: Recursive nested list parsing with safe Node type checking
            bool isOrdered = node.localName == 'ol';
            int index = 1;
            for (var li in node.children.where((e) => e.localName == 'li')) {

              // Safely filter inline vs block nodes by checking type first
              final inlineNodes = li.nodes.where((n) {
                if (n is dom.Element) {
                  return n.localName != 'ul' && n.localName != 'ol';
                }
                return true; // Text nodes are always inline
              }).toList();

              final blockNodes = li.nodes.where((n) {
                if (n is dom.Element) {
                  return n.localName == 'ul' || n.localName == 'ol';
                }
                return false; // Text nodes are never blocks
              }).toList();

              widgets.add(
                pw.Padding(
                  // Add base padding of 8 for root lists, plus 12 for each nested level
                  padding: pw.EdgeInsets.only(left: (indentLevel == 0 ? 8.0 : 0.0) + (12.0 * indentLevel), bottom: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        isOrdered ? '$index. ' : '•  ',
                        style: pw.TextStyle(
                          font: isOrdered ? (boldFont ?? font) : font,
                          fontSize: 10.5,
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
                                      dom.Element.tag('span')..nodes.addAll(inlineNodes),
                                      font, boldFont, italicFont, textColor: textColor,
                                    ),
                                  ),
                                if (blockNodes.isNotEmpty)
                                // Recurse deeper for lists inside this list
                                  ..._parseBlocks(
                                      blockNodes, font, boldFont, italicFont,
                                      indentLevel: indentLevel + 1, textColor: textColor
                                  ),
                              ]
                          )
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

  static pw.TextSpan _parseInline(dom.Node node, pw.Font font, pw.Font? boldFont, pw.Font? italicFont, {bool isBold = false, bool isItalic = false, double fontSize = 11, PdfColor? textColor}) {
    if (node is dom.Text) {
      String text = node.text.replaceAll(RegExp(r'\s+'), ' ');
      return pw.TextSpan(
          text: text,
          style: pw.TextStyle(
              font: isBold ? (boldFont ?? font) : (isItalic ? (italicFont ?? font) : font),
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontStyle: isItalic ? pw.FontStyle.italic : pw.FontStyle.normal,
              fontSize: fontSize,
              color: textColor ?? PdfColors.black,
              lineSpacing: 1.3
          )
      );
    } else if (node is dom.Element) {
      if (node.localName == 'br') return const pw.TextSpan(text: '\n');
      bool bold = isBold || node.localName == 'b' || node.localName == 'strong';
      bool italic = isItalic || node.localName == 'i' || node.localName == 'em';
      return pw.TextSpan(children: node.nodes.map((n) => _parseInline(n, font, boldFont, italicFont, isBold: bold, isItalic: italic, fontSize: fontSize, textColor: textColor)).toList());
    }
    return const pw.TextSpan();
  }
}