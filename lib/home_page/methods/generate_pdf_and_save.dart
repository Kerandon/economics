import 'package:flutter/material.dart';

import '../../diagrams/enums/unit_type.dart';
import '../methods/parse_html_to_pdf.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/term.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart'; // Import for BuildContext

// Assuming these classes/enums are defined elsewhere in your project
// class UnitType { final String id; final String title; const UnitType(this.id, this.title); static List<UnitType> get values => [const UnitType('2', 'Microeconomics')]; }
// class Subunit { final String id; final String title; const Subunit(this.id, this.title); }
// enum Tag { hl, supplement }
// class Term { final String term; final String explanation; final Tag tag; const Term(this.term, this.explanation, this.tag); }
// List<pw.InlineSpan> parseHtmlToPdfTextSpans(String html, pw.TextStyle style) => [];

Future<void> generatePdfAndSave(
  BuildContext context,
  Map<UnitType, List<Subunit>> units,
  Map<Subunit, List<Term>> termsBySubunit,
) async {
  final pdf = pw.Document();

  // --- 🎨 Consolidated and Fixed Styles ---
  final pw.TextStyle headerStyle = pw.TextStyle(
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
  );
  final pw.TextStyle unitStyle = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
  );
  final pw.TextStyle subunitStyle = pw.TextStyle(
    fontSize: 11,
    fontWeight: pw.FontWeight.bold,
  );
  final pw.TextStyle termStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );
  final pw.TextStyle explanationStyle = pw.TextStyle(
    fontSize: 10,
    color: PdfColors.black,
  );

  // FIXED COLORS: Distinct colors for better differentiation
  final pw.TextStyle hlTagStyle = pw.TextStyle(
    fontSize: 9,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.red700,
  );
  final pw.TextStyle supplementTagStyle = pw.TextStyle(
    fontSize: 9,
    fontStyle: pw.FontStyle.italic,
    color: PdfColors.blue700,
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      // More compact header padding
      header: (context) => pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Text(
          'VSPH IB Economics Key Terms Externalities, Public Goods, Asymmetric Information',
          style: headerStyle,
        ),
      ),
      build: (context) {
        final List<pw.Widget> content = [];

        for (var unit in UnitType.values) {
          final subunitsWithTerms = units[unit]!
              .where(
                (subunit) => (termsBySubunit[subunit]?.isNotEmpty ?? false),
              )
              .toList();
          if (subunitsWithTerms.isEmpty) continue;

          // Reduced vertical spacing
          content.add(pw.SizedBox(height: 1));
          content.add(pw.Text('${unit.id} ${unit.title}', style: unitStyle));
          content.add(
            pw.Divider(height: 1, thickness: 1.5),
          ); // Slightly thicker divider for units

          for (var subunit in subunitsWithTerms) {
            // Reduced vertical spacing
            content.add(pw.SizedBox(height: 1));
            content.add(
              pw.Text('${subunit.id} ${subunit.title}', style: subunitStyle),
            );
            content.add(
              pw.SizedBox(height: 0.5),
            ); // Minimal spacing before table

            final List<pw.TableRow> rows = [];

            for (var term in termsBySubunit[subunit]!) {
              final List<pw.InlineSpan> termSpans = [
                pw.TextSpan(text: term.term, style: termStyle),
                // Compact tag style: less space, smaller font
                if (term.tag == Tag.hl)
                  pw.TextSpan(text: ' (HL)', style: hlTagStyle)
                else if (term.tag == Tag.supplement)
                  pw.TextSpan(text: ' (SUPP)', style: supplementTagStyle),
              ];

              final List<pw.InlineSpan> explanationSpans =
                  parseHtmlToPdfTextSpans(term.explanation, explanationStyle);

              // --- 📝 Compact TableRow Structure ---
              rows.add(
                pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.top,
                  children: [
                    // Term Column: Minimal internal padding
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 3,
                      ),
                      child: pw.RichText(
                        text: pw.TextSpan(children: termSpans),
                      ),
                    ),
                    // Explanation Column: Minimal internal padding and border applied to the cell directly
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 3,
                      ),
                      decoration:
                          const pw.BoxDecoration(), // Remove redundant border here
                      child: explanationSpans.isNotEmpty
                          ? pw.RichText(
                              text: pw.TextSpan(children: explanationSpans),
                            )
                          : pw.Text(
                              'No explanation provided.',
                              style: explanationStyle,
                            ),
                    ),
                  ],
                ),
              );
            }

            // Table setup: Slightly reduced border width for a cleaner look
            content.add(
              pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(
                    1.2,
                  ), // Increased term column width slightly
                  1: const pw.FlexColumnWidth(3.8),
                },
                border: pw.TableBorder.all(color: PdfColors.black, width: 0.1),
                children: rows,
              ),
            );

            // Reduced vertical spacing after table
            content.add(pw.SizedBox(height: 2));
          }
        }

        return content;
      },
    ),
  );

  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: 'key_ib_terms.pdf',
  );
}
