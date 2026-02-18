import 'package:pdf/pdf.dart';
import 'dart:math';
import 'package:economics_app/diagrams/models/pdf_diagram_canvas.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../models/diagram_painter_config.dart';
import '../models/diagram_widget.dart';

Future<void> exportDiagramsToPdf(
  List<DiagramWidget> diagrams,
  DiagramPainterConfig config,
  BuildContext context,
) async {
  final pdf = pw.Document();

  // 1. Load the Unicode-enabled font
  // Roboto is excellent for economic symbols like π and subscripts
  final pw.Font unicodeFont = await PdfGoogleFonts.robotoRegular();

  // 2. Loop through diagrams in groups of 6 (to fit on a page)
  for (var i = 0; i < diagrams.length; i += 6) {
    final group = diagrams.sublist(i, min(i + 6, diagrams.length));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.GridView(
            crossAxisCount: 2,
            childAspectRatio:
                0.75, // Made taller to accommodate titles/descriptions
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: group.map((dWidget) {
              // Prepare the list of PDF diagram widgets
              // We map each painter in the bundle to a PDF-compatible CustomPaint
              final pdfDiagrams = dWidget.painters.map((painter) {
                return pw.Expanded(
                  child: pw.FittedBox(
                    child: pw.CustomPaint(
                      size: const PdfPoint(400, 400),
                      painter: (PdfGraphics graphics, PdfPoint size) {
                        // Extract low-level font
                        final PdfFont resolvedFont = unicodeFont.getFont(
                          context,
                        );

                        // Bridge to your existing drawing logic
                        final bridge = PdfDiagramCanvas(
                          graphics,
                          context.document,
                          size.y,
                          pdfFont: resolvedFont,
                        );

                        painter.drawDiagram(bridge, const Size(400, 400));
                      },
                    ),
                  ),
                );
              }).toList();

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // --- Title ---
                  if (dWidget.title != null)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 2),
                      child: pw.Text(
                        dWidget.title!,
                        style: pw.TextStyle(
                          font: unicodeFont,
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),

                  // --- Description ---
                  if (dWidget.description != null)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Text(
                        dWidget.description!,
                        style: pw.TextStyle(
                          font: unicodeFont,
                          fontSize: 8,
                          color: PdfColors.grey700,
                        ),
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                      ),
                    ),

                  // --- Diagram Layout (Row or Column) ---
                  pw.Expanded(
                    child: dWidget.axis == Axis.horizontal
                        ? pw.Row(children: pdfDiagrams)
                        : pw.Column(children: pdfDiagrams),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}
