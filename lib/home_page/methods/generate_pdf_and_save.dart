import 'package:flutter/material.dart';

import '../../diagrams/enums/unit_type.dart';
import '../methods/parse_html_to_pdf.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/term.dart';

Future<void> generatePdfAndSave(
  BuildContext context,
  Map<UnitType, List<Subunit>> units,
  Map<Subunit, List<Term>> termsBySubunit,
) async {
  final pdf = pw.Document();

  // Define text styles for PDF
  final pw.TextStyle titleStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
  );
  final pw.TextStyle subtitleStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
  );
  final pw.TextStyle termStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.white,
  );
  final pw.TextStyle explanationStyle = pw.TextStyle(fontSize: 10);

  // All tags white
  final pw.TextStyle tagStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.normal,
    color: PdfColors.white,
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        final List<pw.Widget> content = [];

        content.add(
          pw.Center(
            child: pw.Text('IB Economics Key Terms', style: titleStyle),
          ),
        );
        content.add(pw.SizedBox(height: 2));

        for (var unit in UnitType.values) {
          content.add(
            pw.Text(
              unit.title,
              style: titleStyle.copyWith(color: PdfColors.blue900),
            ),
          );
          content.add(pw.Divider());

          for (var subunit in units[unit]!) {
            if (termsBySubunit[subunit]?.isNotEmpty ?? false) {
              content.add(pw.SizedBox(height: 2));
              content.add(
                pw.Text(
                  subunit.title,
                  style: subtitleStyle.copyWith(color: PdfColors.blue700),
                ),
              );
              content.add(pw.SizedBox(height: 5));

              for (var term in termsBySubunit[subunit]!) {
                // Term + tag
                final List<pw.InlineSpan> termSpans = [
                  pw.TextSpan(text: '${term.term} ', style: termStyle),
                ];

                if (term.tag == Tag.hl) {
                  termSpans.add(pw.TextSpan(text: '(HL)', style: tagStyle));
                } else if (term.tag == Tag.supplement) {
                  termSpans.add(
                    pw.TextSpan(text: '(Supplement)', style: tagStyle),
                  );
                }

                // Background color based on tag
                final bgColor = term.tag == Tag.hl
                    ? PdfColors.amber800
                    : term.tag == Tag.supplement
                    ? PdfColors.deepOrange400
                    : PdfColors.blueGrey800;

                content.add(
                  pw.Container(
                    color: bgColor,
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.RichText(text: pw.TextSpan(children: termSpans)),
                  ),
                );

                // Explanation
                final List<pw.InlineSpan> explanationSpans =
                    parseHtmlToPdfTextSpans(term.explanation, explanationStyle);

                content.add(
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(2),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey300),
                    ),
                    child: explanationSpans.isNotEmpty
                        ? pw.RichText(
                            text: pw.TextSpan(children: explanationSpans),
                          )
                        : pw.Text(
                            'No explanation provided.',
                            style: explanationStyle,
                          ),
                  ),
                );

                content.add(pw.SizedBox(height: 4));
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
    filename: 'key_ib_terms.pdf',
  );
}
