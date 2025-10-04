import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/data/get_slides_by_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/configs/constants.dart';
import '../models/term.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:google_fonts/google_fonts.dart'; //


// ----------------------------------------------------------------------
// 💡 UPDATED HTML to PDF Parsing Helper Function
/// Converts an HTML string into a list of pw.InlineSpan widgets.
List<pw.InlineSpan> parseHtmlToPdfTextSpans(
    String htmlText, pw.TextStyle defaultStyle) {

  // 🚀 FIX: Pre-process the text to handle problematic symbols and quotes
  String cleanedHtmlText = htmlText
  // 1. Fix for Delta symbol (use text as replacement if font fails)
      .replaceAll('∆', 'Change In ')
      .replaceAll('&Delta;', 'Change in ')
  // 2. Fix for various single quote/apostrophe characters
      .replaceAll('’', "'")
      .replaceAll('‘', "'")

      .replaceAll('“', "'")
      .replaceAll('”', '"');

  final document = parse(cleanedHtmlText); // Use the cleaned text
  final spans = <pw.InlineSpan>[];

  // Helper function for recursive parsing
  void parseNode(dom.Node node, pw.TextStyle currentStyle) {
    if (node is dom.Text) {
      // Handle plain text
      final text = node.text.trim();
      if (text.isNotEmpty || node.text.contains(' ')) { // Keep spaces/newlines
        spans.add(pw.TextSpan(text: node.text, style: currentStyle));
      }
    } else if (node is dom.Element) {
      pw.TextStyle nextStyle = currentStyle;

      // Apply style based on the tag name
      switch (node.localName) {
        case 'strong':
        case 'b':
          nextStyle = currentStyle.copyWith(fontWeight: pw.FontWeight.bold);
          break;
        case 'em':
        case 'i':
          nextStyle = currentStyle.copyWith(fontStyle: pw.FontStyle.italic);
          break;
        case 'u':
          nextStyle = currentStyle.copyWith(decoration: pw.TextDecoration.underline);
          break;
        case 'p':
        // Add a newline before the <p> content if it's not the very start
          if (spans.isNotEmpty) {
            spans.add(pw.TextSpan(text: '\n\n', style: nextStyle));
          }
          break;
        case 'br':
          spans.add(pw.TextSpan(text: '\n', style: nextStyle));
          break;
      // Add more tags as needed
      }

      // Recursively parse children with the new style
      for (var child in node.nodes) {
        parseNode(child, nextStyle);
      }

      // Add extra spacing for block elements like <p> after their content
      if (node.localName == 'p') {
        spans.add(pw.TextSpan(text: '\n', style: nextStyle));
      }
    }
  }

  // Start parsing from the body (or root element)
  if (document.body != null) {
    for (var node in document.body!.nodes) {
      parseNode(node, defaultStyle);
    }
  }

  return spans;
}
// ----------------------------------------------------------------------


class TermsPage extends ConsumerWidget {
  const TermsPage({super.key});

  // Function to convert data structure into PDF widgets
  Future<void> _generatePdfAndSave(
      BuildContext context,
      Map<UnitType, List<Subunit>> units,
      Map<Subunit, List<Term>> termsBySubunit,
      ) async {


    final pdf = pw.Document();
    final theme = Theme.of(context);

    // Define text styles for PDF
    final pw.TextStyle titleStyle = pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle subtitleStyle = pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle termStyle = pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.white);
    final pw.TextStyle explanationStyle = pw.TextStyle(fontSize: 12);
    final pw.TextStyle hlTagStyle = pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.red);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final List<pw.Widget> content = [];

          content.add(pw.Center(child: pw.Text('Key Terms', style: titleStyle)));
          content.add(pw.SizedBox(height: 20));

          for (var unit in UnitType.values) {
            content.add(pw.Text(unit.title, style: titleStyle.copyWith(color: PdfColors.blue900)));
            content.add(pw.Divider());

            for (var subunit in units[unit]!) {
              if (termsBySubunit[subunit]?.isNotEmpty ?? false) {
                content.add(pw.SizedBox(height: 10));
                content.add(pw.Text(subunit.title, style: subtitleStyle.copyWith(color: PdfColors.blue700)));
                content.add(pw.SizedBox(height: 5));

                for (var term in termsBySubunit[subunit]!) {
                  // Term title with HL tag
                  final List<pw.InlineSpan> termSpans = [
                    pw.TextSpan(text: '${term.term} ', style: termStyle),
                  ];
                  if (term.tag == Tag.hl) {
                    termSpans.add(pw.TextSpan(text: '(HL)', style: hlTagStyle));
                  }

                  content.add(
                    pw.Container(
                      color: term.tag == Tag.hl ? PdfColors.amber800 : PdfColors.blueGrey800,
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.RichText(text: pw.TextSpan(children: termSpans)),
                    ),
                  );

                  // 💡 Explanation: Using the HTML parsing function
                  final List<pw.InlineSpan> explanationSpans =
                  parseHtmlToPdfTextSpans(term.explanation, explanationStyle);


                  content.add(
                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300)),
                      // Change pw.Text to pw.RichText to render the parsed spans
                      child: explanationSpans.isNotEmpty
                          ? pw.RichText(text: pw.TextSpan(children: explanationSpans))
                          : pw.Text('No explanation provided.', style: explanationStyle),
                    ),
                  );
                  content.add(pw.SizedBox(height: 10));
                }
              }
            }
          }

          return content;
        },
      ),
    );

    // Save the PDF file
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'key_terms.pdf',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final slides = getSlides(size: size, theme: theme);

    // Collect terms by subunit (existing logic)
    final Map<Subunit, List<Term>> termsBySubunit = {};
    for (var s in slides) {
      if (s.contents?.isNotEmpty ?? false) {
        for (var c in s.contents!.toList()) {
          if (c.term != null && s.section is Subunit) {
            final subunit = s.section as Subunit;
            termsBySubunit.putIfAbsent(subunit, () => []).add(c.term!);
          }
        }
      }
    }

    // Group subunits by unit (existing logic)
    final Map<UnitType, List<Subunit>> units = {};
    for (var subunit in Subunit.values) {
      units.putIfAbsent(subunit.unit, () => []).add(subunit);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Key Terms')),
      body: ListView(
        children: [
          // 🚀 PDF Download Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                // Call the function to generate and save the PDF
                await _generatePdfAndSave(context, units, termsBySubunit);
              },
              icon: const Icon(Icons.picture_as_pdf_outlined, size: 30, color: Colors.red),
              tooltip: 'Download Terms as PDF',
            ),
          ),
          // ------------------------------------------------------------------
          // Existing content display (ExpansionTiles)
          for (var unit in UnitType.values)
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(unit.title, style: theme.textTheme.titleLarge),
              children: [
                for (var subunit in units[unit]!)
                  if (termsBySubunit[subunit]?.isNotEmpty ?? false)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(subunit.title),
                      children: [
                        for (var term in termsBySubunit[subunit]!)
                          Container(
                            color: term.tag == Tag.hl
                                ? theme.primaryColorDark
                                : theme.primaryColor,
                            child: ExpansionTile(
                              minTileHeight: 0,
                              initiallyExpanded: true,
                              textColor: Colors.white,
                              title: HtmlWidget(
                                '${term.term} ${term.tag == Tag.hl ? '<strong>(HL)</strong>' : ''}',
                              ),
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    size.width * kPageIndentHorizontal,
                                    vertical:
                                    size.height * kPageIndentVertical / 4,
                                  ),
                                  child: HtmlWidget(term.explanation),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
              ],
            ),
        ],
      ),
    );
  }
}