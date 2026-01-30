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
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.GridView(
            crossAxisCount: 2,
            childAspectRatio: 2, // Slightly taller to prevent title overlap
            crossAxisSpacing: 5,
            mainAxisSpacing: 20,
            children: group.map((d) {
              final painter = d.basePainterDiagrams.first;

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Container(
                    height: 30, // Fixed height for title area
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      painter.diagram.toText,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Center(
                      child: pw.AspectRatio(
                        aspectRatio: 1,
                        child: pw.Container(
                          // Optional: decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5))
                          child: pw.FittedBox(
                            fit: pw.BoxFit.contain,
                            child: pw.CustomPaint(
                              size: const PdfPoint(400, 400),
                              painter: (PdfGraphics graphics, PdfPoint size) {
                                final bridge = PdfDiagramCanvas(
                                  graphics,
                                  context.document,
                                  size.y,
                                );
                                painter.drawDiagram(
                                  bridge,
                                  const Size(400, 400),
                                );
                              },
                            ),
                          ),
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

  static const double pdfScale = 1.5;

  PdfDiagramCanvas(this.graphics, this.document, this.pageHeight);

  double _transY(double y) => pageHeight - y;

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width * pdfScale)
      ..moveTo(p1.dx, _transY(p1.dy))
      ..lineTo(p2.dx, _transY(p2.dy))
      ..strokePath();
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..saveContext()
      ..setLineDashPattern([3, 3])
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width * pdfScale)
      ..moveTo(p1.dx, _transY(p1.dy))
      ..lineTo(p2.dx, _transY(p2.dy))
      ..strokePath()
      ..restoreContext();
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..drawRect(rect.left, _transY(rect.bottom), rect.width, rect.height);

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawDot(
    Offset center,
    Color color, {
    double radius = 4.0,
    bool fill = true,
  }) {
    final r = radius * pdfScale;
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..drawEllipse(center.dx, _transY(center.dy), r, r);

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    final font = PdfFont.helvetica(document);
    graphics
      ..saveContext()
      ..setFillColor(PdfColor.fromInt(color.value));

    // When translate/rotate is active, 'position' is often Offset(-alignmentX, -alignmentY)
    // We still flip the Y for the text baseline, but keep the X as is.
    double pdfY = _transY(position.dy) - fontSize;

    graphics.drawString(font, fontSize, text, position.dx, pdfY);

    graphics.restoreContext();
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = false}) {
    if (points.isEmpty) return;
    graphics
      ..saveContext()
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(2.0 * pdfScale) // Using a standard line weight for paths
      ..moveTo(points.first.dx, _transY(points.first.dy));

    for (var i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
    graphics.restoreContext();
  }

  @override
  void save() => graphics.saveContext();

  @override
  void restore() => graphics.restoreContext();

  @override
  void translate(double dx, double dy) {
    // PDF Y-axis is inverted, so we move 'dy' downwards (negative)
    // In PdfGraphics, setTransform effectively modifies the current transformation matrix
    graphics.setTransform(Matrix4.translationValues(dx, -dy, 0));
  }

  @override
  void rotate(double radians) {
    // PDF rotation direction is opposite to Flutter's coordinate flip
    graphics.setTransform(Matrix4.rotationZ(-radians));
  }

  @override
  void clipPath(List<Offset> points) {
    if (points.isEmpty) return;
    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (var i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }
    graphics.closePath();
    graphics.clipPath();
  }
}
