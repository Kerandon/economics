import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// Adjust these paths if your project structure is slightly different
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/models/diagram_widget.dart';
// Note: Make sure the import for PdfDiagramCanvas is correct for your project!
import '../../../diagrams/models/pdf_diagram_canvas.dart';
import '../../models/slide.dart';
import '../../models/term.dart';


// Adjust these paths if your project structure is slightly different
// Note: Make sure the import for PdfDiagramCanvas is correct for your project!

// ==========================================
// 1. MAIN EXPORT FUNCTION
// ==========================================




import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

// NOTE: Ensure your domain-specific imports (Slide, Tag, AllDiagrams, DiagramWidget, etc.) are present here.

Future<void> exportFullQuestionToPdf(
    Slide slide,
    AllDiagrams allDiagramsService,
    ) async {
  final pdf = pw.Document();

  // Load the fonts completely offline from your app assets
  final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final pw.Font unicodeFont = pw.Font.ttf(fontData);

  // 🔧 NEW: Load the Bold font so HTML tags like <b> and <h1> render correctly
  final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
  final pw.Font boldUnicodeFont = pw.Font.ttf(boldFontData);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) => pw.Container(
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}  |  IBEconToolkit.com',
          style: pw.TextStyle(
              font: unicodeFont, fontSize: 9, color: PdfColors.grey500),
        ),
      ),
      build: (pw.Context pdfContext) {
        List<pw.Widget> pageElements = [];

        // --- HEADER ---
        pageElements.add(
          pw.Text(
            'PAPER ONE QUESTION',
            style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 11,
                color: PdfColors.red800,
                fontWeight: pw.FontWeight.bold),
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
                fontWeight: pw.FontWeight.bold),
          ),
        );
        pageElements.add(pw.SizedBox(height: 4));
        pageElements.add(
          pw.Text(
            slide.subunit.name.toUpperCase(),
            style: pw.TextStyle(
                font: unicodeFont, fontSize: 10, color: PdfColors.grey700),
          ),
        );

        if (slide.tags.isNotEmpty) {
          pageElements.add(pw.SizedBox(height: 4));
          pageElements.add(
            pw.Text(
              slide.tags.map((t) => t.name.toUpperCase()).join('  •  '),
              style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 9,
                color: PdfColors.blueGrey600,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          );
        }

        pageElements.add(pw.SizedBox(height: 8));
        pageElements.add(pw.Divider(thickness: 1, color: PdfColors.grey300));
        pageElements.add(pw.SizedBox(height: 12));

        // --- CONTENTS LOOP ---
        if (slide.contents != null) {
          for (var block in slide.contents!) {
            // 0. TL;DR
            if (block.tldr != null && block.tldr!.isNotEmpty) {
              pageElements.add(
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.amber50,
                    border: pw.Border(
                        left: pw.BorderSide(
                            color: PdfColors.amber500, width: 4)),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('TL;DR',
                          style: pw.TextStyle(
                              font: boldUnicodeFont, // Used bold font here
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.amber800)),
                      pw.SizedBox(height: 4),
                      pw.Text(stripHtmlIfNeeded(block.tldr!),
                          style: pw.TextStyle(
                              font: unicodeFont, fontSize: 11, lineSpacing: 2)),
                    ],
                  ),
                ),
              );
              pageElements.add(pw.SizedBox(height: 12));
            }

            // 1. TERMS (EconTerms)
            if (block.econTerms != null && block.econTerms!.isNotEmpty) {
              pageElements.add(_buildSectionHeader('TERMS', boldUnicodeFont));

              for (int i = 0; i < block.econTerms!.length; i++) {
                final term = block.econTerms![i];

                pageElements.add(
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 8, bottom: 6),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        style: pw.TextStyle(
                            font: unicodeFont, fontSize: 11, lineSpacing: 2),
                        children: [
                          pw.TextSpan(
                            text: '-  ${term.termName}: ',
                            style: pw.TextStyle(
                                font: boldUnicodeFont,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black),
                          ),
                          pw.TextSpan(
                            text: stripHtmlIfNeeded(term.explanation),
                            style: const pw.TextStyle(color: PdfColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              pageElements.add(pw.SizedBox(height: 12));
            }

            // 2. EXPLANATION TEXT (HTML PARSED)
            if (block.content != null && block.content!.text.isNotEmpty) {
              pageElements.add(_buildSectionHeader('EXPLANATION', boldUnicodeFont));

              // 🔧 NEW: Replaced single pw.Text with the HTML builder
              pageElements.addAll(
                HtmlPdfBuilder.build(
                  block.content!.text,
                  regularFont: unicodeFont,
                  boldFont: boldUnicodeFont,
                ),
              );
              pageElements.add(pw.SizedBox(height: 12));
            }

            // 3. ALERTS
            if (block.alert != null && block.alert!.text.isNotEmpty) {
              pageElements.add(
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  margin: const pw.EdgeInsets.only(bottom: 12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.red50,
                    border: pw.Border.all(color: PdfColors.red200),
                  ),
                  child: pw.Text(block.alert!.text,
                      style: pw.TextStyle(
                          font: unicodeFont,
                          fontSize: 11,
                          color: PdfColors.red900)),
                ),
              );
            }

            // 4. TIPS
            if (block.tip != null && block.tip!.text.isNotEmpty) {
              pageElements.add(
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  margin: const pw.EdgeInsets.only(bottom: 12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    border: pw.Border.all(color: PdfColors.blue200),
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('TIP: ',
                          style: pw.TextStyle(
                              font: boldUnicodeFont,
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900)),
                      pw.Expanded(
                        child: pw.Text(block.tip!.text,
                            style: pw.TextStyle(
                                font: unicodeFont,
                                fontSize: 11,
                                color: PdfColors.blue900)),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 5. DIAGRAMS
            if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
              pageElements.add(_buildSectionHeader('DIAGRAMS', boldUnicodeFont));

              final widgets = allDiagramsService
                  .getDiagramWidgets(diagrams: block.diagramEnums!)
                  .toList();
              pageElements.add(
                  _buildPdfDiagramRow(widgets, unicodeFont, pdfContext));
              pageElements.add(pw.SizedBox(height: 12));
            }

            // 6. REAL WORLD EXAMPLES
            if (block.realWorldExamples != null &&
                block.realWorldExamples!.isNotEmpty) {
              pageElements.add(
                  _buildSectionHeader('REAL WORLD EXAMPLES', boldUnicodeFont));
              for (var example in block.realWorldExamples!) {
                pageElements.add(
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 8, bottom: 6),
                    child: pw.Text(
                        '-  ${example.example}, ${example.explanation}',
                        style: pw.TextStyle(
                            font: unicodeFont,
                            fontSize: 11,
                            fontStyle: pw.FontStyle.italic)),
                  ),
                );
              }
              pageElements.add(pw.SizedBox(height: 12));
            }

            // 7. TABLES
            if (block.tableData != null) {
              final tableInfo = block.tableData!;

              final cleanHeaders = tableInfo.headers
                  .map((h) => stripHtmlIfNeeded(h))
                  .toList();
              final cleanData = tableInfo.data
                  .map((row) =>
                  row.map((cell) => stripHtmlIfNeeded(cell)).toList())
                  .toList();

              if (tableInfo.title != null) {
                pageElements.add(
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Center(
                      child: pw.Text(
                        stripHtmlIfNeeded(tableInfo.title!),
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            font: boldUnicodeFont,
                            fontSize: 11,
                            fontStyle: pw.FontStyle.italic,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }

              pageElements.add(
                pw.TableHelper.fromTextArray(
                  headers: cleanHeaders,
                  data: cleanData,
                  border: pw.TableBorder.all(
                      color: PdfColors.grey600, width: 0.5),
                  headerStyle: pw.TextStyle(
                      font: boldUnicodeFont,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold),
                  headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey200),
                  cellStyle: pw.TextStyle(font: unicodeFont, fontSize: 10),
                  cellPadding: const pw.EdgeInsets.symmetric(
                      vertical: 6, horizontal: 8),
                  cellAlignment: pw.Alignment.center,
                  columnWidths: {
                    for (int i = 0; i < cleanHeaders.length; i++)
                      i: const pw.FlexColumnWidth()
                  },
                ),
              );

              if (tableInfo.figCaption != null) {
                pageElements.add(
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 4, left: 4),
                    child: pw.Text(
                      stripHtmlIfNeeded(tableInfo.figCaption!),
                      style: pw.TextStyle(
                          font: unicodeFont,
                          fontSize: 9,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColors.grey700),
                    ),
                  ),
                );
              }

              pageElements.add(pw.SizedBox(height: 12));
            }
          }
        }

        return pageElements;
      },
    ),
  );

  // GENERATE DYNAMIC FILE NAME
  String rawTitle = slide.question ?? slide.title;
  String cleanTitle = rawTitle.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').replaceAll(RegExp(r'_+'), '_');
  if (cleanTitle.endsWith('_')) cleanTitle = cleanTitle.substring(0, cleanTitle.length - 1);
  if (cleanTitle.length > 40) cleanTitle = cleanTitle.substring(0, 40);

  String tagsStr = slide.tags.map((t) => t.name.toUpperCase()).join('_');
  final bool isHL = slide.tags.contains(Tag.hl);
  final String prefix = isHL ? "HL" : "SL";
  final String pdfFileName = '${prefix}_${cleanTitle}_$tagsStr.pdf'.replaceAll('__', '_');

  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: pdfFileName,
  );
}

// -----------------------------------------------------------------------------
// HELPER METHODS
// -----------------------------------------------------------------------------

pw.Widget _buildSectionHeader(String title, pw.Font font) {
  return pw.Header(
    level: 1,
    decoration: const pw.BoxDecoration(),
    margin: const pw.EdgeInsets.only(bottom: 8),
    padding: pw.EdgeInsets.zero,
    child: pw.Text(
      title,
      style: pw.TextStyle(
          font: font,
          fontSize: 12,
          color: PdfColors.grey600,
          fontWeight: pw.FontWeight.bold),
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

pw.Widget _buildPdfDiagramRow(
    List<DiagramWidget> widgets, pw.Font unicodeFont, pw.Context pdfContext) {
  if (widgets.isEmpty) return pw.Container();

  if (widgets.length == 1) {
    return pw.Center(
      child: pw.Container(
        width: 250,
        child: _buildPdfDiagramCell(widgets.first, unicodeFont, pdfContext),
      ),
    );
  } else {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets.asMap().entries.map((entry) {
        int index = entry.key;
        DiagramWidget dWidget = entry.value;

        return pw.Expanded(
          child: pw.Padding(
            padding: pw.EdgeInsets.only(left: index == 0 ? 0 : 8.0),
            child: _buildPdfDiagramCell(dWidget, unicodeFont, pdfContext),
          ),
        );
      }).toList(),
    );
  }
}

pw.Widget _buildPdfDiagramCell(
    DiagramWidget dWidget,
    pw.Font unicodeFont,
    pw.Context pdfContext,
    ) {
  final String effectiveTitle =
      dWidget.title ?? dWidget.painters.first.diagram.toText;
  final String effectiveDescription = stripHtmlIfNeeded(
      dWidget.description ?? dWidget.painters.first.diagram.description);

  final pdfDiagrams = <pw.Widget>[];

  for (int i = 0; i < dWidget.painters.length; i++) {
    final painter = dWidget.painters[i];
    pdfDiagrams.add(
      pw.Expanded(
        child: pw.Stack(
          alignment: pw.Alignment.center,
          children: [
            pw.FittedBox(
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.CustomPaint(
                  size: const PdfPoint(400, 400),
                  painter: (PdfGraphics graphics, PdfPoint size) {
                    final bridge = PdfDiagramCanvas(
                      graphics,
                      pdfContext.document,
                      size.y,
                      pdfFont: unicodeFont.getFont(pdfContext),
                    );
                    painter.drawDiagram(bridge, const Size(400, 400));
                  },
                ),
              ),
            ),
            pw.Positioned(
              bottom: 5,
              right: 5,
              child: pw.Text(
                'IBEconToolkit.com',
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 8,
                  color: PdfColors.grey300,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (i < dWidget.painters.length - 1) {
      pdfDiagrams.add(pw.SizedBox(width: 4, height: 4));
    }
  }

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
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      if (effectiveDescription.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Container(
            width: double.infinity,
            child: pw.Text(
              effectiveDescription,
              softWrap: true,
              style: pw.TextStyle(
                font: unicodeFont,
                fontSize: 9,
                color: PdfColors.grey700,
              ),
            ),
          ),
        ),
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey200, width: 0.5),
        ),
        child: dWidget.axis == Axis.horizontal
            ? pw.Row(children: pdfDiagrams)
            : pw.Column(children: pdfDiagrams),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// HTML PDF BUILDER
// -----------------------------------------------------------------------------

class HtmlPdfBuilder {
  /// Converts an HTML string into a list of pw.Widget blocks.
  static List<pw.Widget> build(
      String html, {
        required pw.Font regularFont,
        pw.Font? boldFont,
        pw.Font? italicFont,
      }) {
    final document = html_parser.parse(html);
    return _parseBlocks(document.body?.nodes ?? [], regularFont, boldFont, italicFont);
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
            final double size = node.localName == 'h1' ? 16 : (node.localName == 'h2' ? 14 : 12);
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 8, bottom: 4),
                child: pw.RichText(
                  text: _parseInline(node, font, boldFont, italicFont, isBold: true, fontSize: size),
                ),
              ),
            );
            break;
          case 'p':
            widgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
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
                  padding: const pw.EdgeInsets.only(left: 8, bottom: 4),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        isOrdered ? '$index. ' : '•  ',
                        style: pw.TextStyle(font: font, fontSize: 11),
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
            widgets.add(pw.SizedBox(height: 6));
            break;
          default:
          // Fallback for unknown blocks (e.g., div, blockquote)
            widgets.add(
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.RichText(text: _parseInline(node, font, boldFont, italicFont)),
                )
            );
        }
      } else if (node is dom.Text && node.text.trim().isNotEmpty) {
        // Stray text outside of a block tag
        widgets.add(pw.RichText(text: _parseInline(node, font, boldFont, italicFont)));
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
        double fontSize = 11,
      }) {
    if (node is dom.Text) {
      // HTML strings often have extra whitespace/newlines. Compress them.
      String text = node.text.replaceAll(RegExp(r'\s+'), ' ');
      return pw.TextSpan(
        text: text,
        style: pw.TextStyle(
          font: isBold ? (boldFont ?? font) : (isItalic ? (italicFont ?? font) : font),
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontStyle: isItalic ? pw.FontStyle.italic : pw.FontStyle.normal,
          fontSize: fontSize,
          lineSpacing: 1.5,
        ),
      );
    } else if (node is dom.Element) {
      if (node.localName == 'br') {
        return const pw.TextSpan(text: '\n');
      }

      bool bold = isBold || node.localName == 'b' || node.localName == 'strong';
      bool italic = isItalic || node.localName == 'i' || node.localName == 'em';

      return pw.TextSpan(
        children: node.nodes
            .map((n) => _parseInline(n, font, boldFont, italicFont,
            isBold: bold, isItalic: italic, fontSize: fontSize))
            .toList(),
      );
    }
    return const pw.TextSpan();
  }
}