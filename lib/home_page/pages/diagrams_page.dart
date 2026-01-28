import 'dart:math';

import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:economics_app/diagrams/data/get_diagram_widget_list.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:printing/printing.dart';

import '../../diagrams/custom_paint/i_diagram_canvas.dart';
import '../../diagrams/custom_paint/painter_constants.dart';

import '../../diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import '../../diagrams/enums/unit_type.dart';
import '../../diagrams/models/diagram_painter_config.dart';
import '../../diagrams/models/diagram_widget.dart';

class DiagramsPage extends ConsumerWidget {
  const DiagramsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: theme.colorScheme,
    );

    // Fetch all diagram widgets
    final diagrams = getDiagramWidgetsListNEW(config);

    // Group diagrams by subunit
    final Map<Subunit, List<DiagramWidgetNEW>> diagramsBySubunit = {};
    for (var d in diagrams) {
      final subunit =
          d.basePainterDiagrams.first.subunit ?? Subunit.whatIsEconomics;
      diagramsBySubunit.putIfAbsent(subunit, () => []).add(d);
    }

    // Group subunits by unit type for ordering
    final Map<UnitType, List<Subunit>> units = {};
    for (var subunit in Subunit.values) {
      units.putIfAbsent(subunit.unit, () => []).add(subunit);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('IB Economics Diagrams')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            children: [
              // PDF Download Button (optional)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () =>
                      _exportDiagramsToPdf(diagrams, config, context),

                  icon: const Icon(
                    Icons.picture_as_pdf_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                  tooltip: 'Download Diagrams as PDF',
                ),
              ),

              // Loop through units
              for (var unit in UnitType.values)
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(unit.title, style: theme.textTheme.titleLarge),
                  children: [
                    for (var subunit in units[unit]!)
                      if ((diagramsBySubunit[subunit]?.isNotEmpty ?? false))
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text('${subunit.id} ${subunit.title}'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: diagramsBySubunit[subunit]!.map((
                                  diagram,
                                ) {
                                  // Check if we have a single diagram or a side-by-side pairing
                                  final isPair = diagram.widget.length > 1;

                                  return Column(
                                    children: [
                                      // Display title(s)
                                      Text(
                                        isPair
                                            ? "${diagram.basePainterDiagrams.first.diagram.toText} & ${diagram.basePainterDiagrams.last.diagram.toText}"
                                            : diagram
                                                  .basePainterDiagrams
                                                  .first
                                                  .diagram
                                                  .toText,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 8),

                                      // If it's a pair, put them in a Row; otherwise, show one
                                      if (isPair)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (var w in diagram.widget)
                                              SizedBox(
                                                width: 400,
                                                height: 400,
                                                child: w,
                                              ),
                                          ],
                                        )
                                      else
                                        diagram.widget.first,
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _exportDiagramsToPdf(
  List<DiagramWidgetNEW> diagrams,
  DiagramPainterConfig config,
  BuildContext context,
) async {
  final pdf = pw.Document();

  for (var i = 0; i < diagrams.length; i += 6) {
    final group = diagrams.sublist(i, min(i + 6, diagrams.length));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.GridView(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 5,
            mainAxisSpacing: 30,
            children: group.map((d) {
              final painter = d.basePainterDiagrams.first;

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 4),
                    child: pw.Text(
                      painter.diagram.toText,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.grey300,
                          width: 0.5,
                        ),
                      ),
                      // FittedBox automatically scales your 400x400 drawing
                      // to fit whatever size the GridView cell is.
                      child: pw.FittedBox(
                        fit: pw.BoxFit.contain,
                        child: pw.CustomPaint(
                          size: const PdfPoint(400, 400),
                          painter: (PdfGraphics graphics, PdfPoint size) {
                            // Since we are inside a 400x400 CustomPaint,
                            // 'size.y' here will be exactly 400.
                            final bridge = PdfDiagramCanvas(
                              graphics,
                              context.document,
                              size.y,
                            );

                            painter.drawDiagram(
                              null,
                              const Size(400, 400),
                              iCanvas: bridge,
                            );
                          },
                        ),
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

class PdfDiagramCanvas implements IDiagramCanvas {
  final PdfGraphics graphics;
  final PdfDocument document;
  final double pageHeight;

  PdfDiagramCanvas(this.graphics, this.document, this.pageHeight);

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width)
      ..moveTo(p1.dx, pageHeight - p1.dy)
      ..lineTo(p2.dx, pageHeight - p2.dy)
      ..strokePath();
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..saveContext()
      ..setLineDashPattern([
        2,
        2,
      ]) // 👈 Restored dash pattern for equilibrium lines
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width)
      ..moveTo(p1.dx, pageHeight - p1.dy)
      ..lineTo(p2.dx, pageHeight - p2.dy)
      ..strokePath()
      ..restoreContext();
  }

  @override
  void drawText(
    String text,
    Offset position,
    double fontSize,
    Color color, {
    TextAlign align = TextAlign.left,
  }) {
    final PdfFont font = PdfFont.helvetica(document);

    graphics
      ..saveContext()
      ..setFillColor(PdfColor.fromInt(color.value));

    double x = position.dx;
    // For vector-perfect alignment, we measure the text accurately
    final PdfFontMetrics metrics = font.stringMetrics(text);
    final double textWidth = metrics.advanceWidth * fontSize;

    if (align == TextAlign.right) {
      x -= textWidth;
    } else if (align == TextAlign.center) {
      x -= textWidth / 2;
    }

    graphics
      ..drawString(font, fontSize, text, x, pageHeight - position.dy)
      ..restoreContext();
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = true}) {
    if (points.isEmpty) return;

    graphics
      ..saveContext()
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(kCurveWidth)
      ..moveTo(points.first.dx, pageHeight - points.first.dy);

    for (var i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, pageHeight - points[i].dy);
    }

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
    graphics.restoreContext();
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      // Note: y-coord is bottom-left in PDF
      ..drawRect(rect.left, pageHeight - rect.bottom, rect.width, rect.height);

    fill ? graphics.fillPath() : graphics.strokePath();
  }

  @override
  void drawDot(
    Offset center,
    Color color, {
    double radius = kDotRadius,
    bool fill = true,
  }) {
    graphics
      ..saveContext()
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..drawEllipse(center.dx, pageHeight - center.dy, radius, radius);

    fill ? graphics.fillPath() : graphics.strokePath();
    graphics.restoreContext();
  }
}
