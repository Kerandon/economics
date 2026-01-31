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
  List<DiagramWidgetNEW> diagrams,
  DiagramPainterConfig config,
  BuildContext context,
) async {
  final pdf = pw.Document();

  // 1. Load the Unicode-enabled font
  // Roboto is excellent for economic symbols like π and subscripts
  final pw.Font unicodeFont = await PdfGoogleFonts.robotoRegular();

  for (var i = 0; i < diagrams.length; i += 6) {
    final group = diagrams.sublist(i, min(i + 6, diagrams.length));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.GridView(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            children: group.map((d) {
              final painter = d.basePainterDiagrams.first;

              return pw.Column(
                children: [
                  pw.Text(
                    painter.diagram.toText,
                    style: pw.TextStyle(font: unicodeFont, fontSize: 9),
                  ),
                  pw.Expanded(
                    child: pw.FittedBox(
                      child: pw.CustomPaint(
                        size: const PdfPoint(400, 400),
                        painter: (PdfGraphics graphics, PdfPoint size) {
                          // 2. Extract the low-level PdfFont from the high-level pw.Font
                          final PdfFont resolvedFont = unicodeFont.getFont(
                            context,
                          );

                          final bridge = PdfDiagramCanvas(
                            graphics,
                            context.document,
                            size.y,
                            pdfFont: resolvedFont, // 👈 Passing the fix
                          );
                          painter.drawDiagram(bridge, const Size(400, 400));
                        },
                      ),
                    ),
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
