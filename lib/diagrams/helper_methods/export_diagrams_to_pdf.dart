import 'dart:math';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/diagram_painter_config.dart';
import '../models/diagram_widget.dart';
import '../models/pdf_diagram_canvas.dart';

// Ensure your models/enums are imported properly here:
// import '../../../diagrams/enums/unit_type.dart';
// import '../../../diagrams/models/diagram_widget.dart';
// import '../custom_paint/pdf_diagram_canvas.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Ensure your models/enums are imported properly here:
// import '../../../diagrams/enums/unit_type.dart';
// import '../../../diagrams/models/diagram_widget.dart';
// import '../custom_paint/pdf_diagram_canvas.dart';

Future<void> exportDiagramsToPdf(
  List<DiagramWidget> diagrams,
  DiagramPainterConfig config,
  BuildContext
  flutterContext, // Flutter context (keep for potential future use)
) async {
  final pdf = pw.Document();
  final pw.Font unicodeFont = await PdfGoogleFonts.robotoRegular();

  // Group diagrams by Subunit
  final Map<dynamic, List<DiagramWidget>> diagramsBySubunit = {};
  for (var d in diagrams) {
    final subunit = d.painters.first.subunit;
    if (subunit != null) {
      diagramsBySubunit.putIfAbsent(subunit, () => []).add(d);
    }
  }

  // MultiPage automatically flows top-to-bottom and handles breaks naturally
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 12),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}  |  IBEconToolkit.com',
            style: pw.TextStyle(
              font: unicodeFont,
              fontSize: 10,
              color: PdfColors.grey500,
            ),
          ),
        );
      },
      // MOVE THE LOOP HERE: Now we have the correct pw.Context (pdfContext)
      build: (pw.Context pdfContext) {
        List<pw.Widget> pageElements = [];

        for (var entry in diagramsBySubunit.entries) {
          final subunit = entry.key;
          final subDiagrams = entry.value;

          // Header for Subunit added directly to flow (No forced page break!)
          pageElements.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 24, bottom: 16),
              child: pw.Text(
                '${subunit.unit.title.toUpperCase()} - ${subunit.id} ${subunit.title}',
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blueGrey800,
                ),
              ),
            ),
          );

          // Process diagrams in pairs (for 2 columns)
          for (var i = 0; i < subDiagrams.length; i += 2) {
            final d1 = subDiagrams[i];
            final d2 = i + 1 < subDiagrams.length ? subDiagrams[i + 1] : null;

            pageElements.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 20),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: _buildPdfDiagramCell(d1, unicodeFont, pdfContext),
                    ),
                    pw.SizedBox(width: 16), // Gap between columns
                    pw.Expanded(
                      child: d2 != null
                          ? _buildPdfDiagramCell(d2, unicodeFont, pdfContext)
                          : pw.Container(),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return pageElements;
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}

// Helper to build an individual diagram cell
// FIX: The context parameter is now explicitly pw.Context instead of BuildContext
pw.Widget _buildPdfDiagramCell(
  DiagramWidget dWidget,
  pw.Font unicodeFont,
  pw.Context pdfContext,
) {
  final String effectiveTitle =
      dWidget.title ?? dWidget.painters.first.diagram.toText;
  final String effectiveDescription =
      dWidget.description ?? dWidget.painters.first.diagram.description;

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
                // Reduced padding to 10 to make diagram larger
                padding: const pw.EdgeInsets.all(10),
                child: pw.CustomPaint(
                  size: const PdfPoint(400, 400),
                  painter: (PdfGraphics graphics, PdfPoint size) {
                    // ALL CLEAR: We are using the correct pdfContext here!
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
            // Faint grey watermark on EVERY diagram
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

    // Add a very small gap between side-by-side diagrams in a bundle
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
          effectiveTitle,
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
          child: pw.Text(
            effectiveDescription,
            style: pw.TextStyle(
              font: unicodeFont,
              fontSize: 9,
              color: PdfColors.grey700,
            ),
            maxLines: 2,
            overflow: pw.TextOverflow.clip,
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
