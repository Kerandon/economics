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
import '../../models/term.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Adjust these paths if your project structure is slightly different
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/models/diagram_widget.dart';
// Note: Make sure the import for PdfDiagramCanvas is correct for your project!
import '../../../diagrams/models/pdf_diagram_canvas.dart';

// ==========================================
// 1. MAIN EXPORT FUNCTION
// ==========================================
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/models/pdf_diagram_canvas.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/models/pdf_diagram_canvas.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/models/diagram_widget.dart';
import '../../../diagrams/models/pdf_diagram_canvas.dart';

Future<void> exportFullQuestionToPdf(
    PaperQuestion question,
    AllDiagrams allDiagramsService,
    ) async {
  final pdf = pw.Document();

  final pw.Font unicodeFont = await PdfGoogleFonts.robotoRegular();
  final answer = question.answer;

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      footer: (pw.Context context) => pw.Container(
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}  |  IBEconToolkit.com',
          style: pw.TextStyle(font: unicodeFont, fontSize: 9, color: PdfColors.grey500),
        ),
      ),
      build: (pw.Context pdfContext) {
        List<pw.Widget> pageElements = [];

        // --- HEADER ---
        pageElements.add(
          pw.Text(
            (question.tags?.contains(Tag.hl) ?? false ? '[HL] ' : '') + question.question,
            style: pw.TextStyle(font: unicodeFont, fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
        );
        pageElements.add(pw.SizedBox(height: 4));
        pageElements.add(
          pw.Text(
            question.subunit.name.toUpperCase(),
            style: pw.TextStyle(font: unicodeFont, fontSize: 10, color: PdfColors.grey700),
          ),
        );
        pageElements.add(pw.SizedBox(height: 6));
        pageElements.add(pw.Divider(thickness: 1, color: PdfColors.grey300));
        pageElements.add(pw.SizedBox(height: 12));

        // --- TL;DR ---
        if (answer.tldr != null && answer.tldr!.isNotEmpty) {
          pageElements.add(
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: PdfColors.amber50,
                border: pw.Border(left: pw.BorderSide(color: PdfColors.amber500, width: 4)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('TL;DR', style: pw.TextStyle(font: unicodeFont, fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.amber800)),
                  pw.SizedBox(height: 2),
                  pw.Text(answer.tldr!, style: pw.TextStyle(font: unicodeFont, fontSize: 11)),
                ],
              ),
            ),
          );
          pageElements.add(pw.SizedBox(height: 16));
        }

        // --- DEFINITIONS ---
        if (answer.terms != null && answer.terms!.isNotEmpty) {
          pageElements.add(_buildSectionHeader('DEFINITIONS', unicodeFont));

          // ✨ A palette of nice, readable colors for the terms
          final termColors = [
            PdfColors.blue700,
            PdfColors.green700,
            PdfColors.purple700,
            PdfColors.deepOrange700,
            PdfColors.teal700,
            PdfColors.pink700,
          ];

          for (int i = 0; i < answer.terms!.length; i++) {
            final term = answer.terms![i];
            final termColor = termColors[i % termColors.length]; // Cycles through the colors

            pageElements.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8), // Slight indent for bullet list feel
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(font: unicodeFont, fontSize: 11),
                    children: [
                      // ✨ Bullet point + Bold colored term
                      pw.TextSpan(
                        text: '•  ${term.termName}: ',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: termColor,
                        ),
                      ),
                      // Standard explanation text
                      pw.TextSpan(
                        text: stripHtmlIfNeeded(term.explanation),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
            pageElements.add(pw.SizedBox(height: 4)); // Tight spacing between points
          }
          pageElements.add(pw.SizedBox(height: 12));
        }

        // --- EXPLANATION ---
        if (answer.explanation != null && answer.explanation!.isNotEmpty) {
          pageElements.add(_buildSectionHeader('EXPLANATION', unicodeFont));

          for (var block in answer.explanation!) {
            // Text Content
            if (block.content != null && block.content!.text.isNotEmpty) {
              pageElements.add(
                pw.Text(stripHtmlIfNeeded(block.content!.text), style: pw.TextStyle(font: unicodeFont, fontSize: 11)),
              );
              pageElements.add(pw.SizedBox(height: 6));
            }

            // Alert Box
            if (block.alert != null && block.alert!.text.isNotEmpty) {
              pageElements.add(
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  margin: const pw.EdgeInsets.only(bottom: 8),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.red50,
                    border: pw.Border.all(color: PdfColors.red200),
                  ),
                  child: pw.Text(block.alert!.text, style: pw.TextStyle(font: unicodeFont, fontSize: 11, color: PdfColors.red900)),
                ),
              );
            }

            // Inline Diagrams
            if (block.diagramEnums != null && block.diagramEnums!.isNotEmpty) {
              final widgets = allDiagramsService.getDiagramWidgets(diagrams: block.diagramEnums!).toList();
              pageElements.add(_buildPdfDiagramRow(widgets, unicodeFont, pdfContext));
              pageElements.add(pw.SizedBox(height: 12));
            }
          }
          pageElements.add(pw.SizedBox(height: 12));
        }

        // --- MAIN DIAGRAMS ---
        if (answer.diagrams != null && answer.diagrams!.enums.isNotEmpty) {
          pageElements.add(_buildSectionHeader('DIAGRAMS', unicodeFont));

          final widgets = allDiagramsService.getDiagramWidgets(diagrams: answer.diagrams!.enums).toList();
          pageElements.add(_buildPdfDiagramRow(widgets, unicodeFont, pdfContext));

          if (answer.diagrams!.explanation != null) {
            pageElements.add(pw.SizedBox(height: 6));
            pageElements.add(pw.Text(stripHtmlIfNeeded(answer.diagrams!.explanation!), style: pw.TextStyle(font: unicodeFont, fontSize: 10, fontStyle: pw.FontStyle.italic)));
          }
          pageElements.add(pw.SizedBox(height: 16));
        }

        // --- REAL WORLD EXAMPLES ---
        if (answer.realWorldExamples != null && answer.realWorldExamples!.isNotEmpty) {
          pageElements.add(_buildSectionHeader('REAL WORLD EXAMPLES', unicodeFont));
          for (var example in answer.realWorldExamples!) {
            pageElements.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8),
                child: pw.Text('•  ${example.text}', style: pw.TextStyle(font: unicodeFont, fontSize: 11, fontStyle: pw.FontStyle.italic)),
              ),
            );
            pageElements.add(pw.SizedBox(height: 4));
          }
        }

        return pageElements;
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}

// ==========================================
// 2. HELPER METHODS
// ==========================================

// Smart Header
pw.Widget _buildSectionHeader(String title, pw.Font font) {
  return pw.Header(
    level: 1,
    decoration: const pw.BoxDecoration(),
    margin: const pw.EdgeInsets.only(bottom: 6),
    padding: pw.EdgeInsets.zero,
    child: pw.Text(
      title,
      style: pw.TextStyle(font: font, fontSize: 11, color: PdfColors.grey600, fontWeight: pw.FontWeight.bold),
    ),
  );
}

// Smarter HTML Stripper
String stripHtmlIfNeeded(String text) {
  String parsed = text.replaceAll('\n', ' ');

  parsed = parsed.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  parsed = parsed.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n');
  parsed = parsed.replaceAll(RegExp(r'<li>', caseSensitive: false), '\n• ');
  parsed = parsed.replaceAll(RegExp(r'<[^>]*>', multiLine: true), '');
  parsed = parsed.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return parsed.trim();
}

// Diagram Row Builder
pw.Widget _buildPdfDiagramRow(List<DiagramWidget> widgets, pw.Font unicodeFont, pw.Context pdfContext) {
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
      children: [
        pw.Expanded(child: _buildPdfDiagramCell(widgets[0], unicodeFont, pdfContext)),
        pw.SizedBox(width: 12),
        pw.Expanded(child: _buildPdfDiagramCell(widgets[1], unicodeFont, pdfContext)),
      ],
    );
  }
}

// Diagram Cell Builder
pw.Widget _buildPdfDiagramCell(
    DiagramWidget dWidget,
    pw.Font unicodeFont,
    pw.Context pdfContext,
    ) {
  final String effectiveTitle = dWidget.title ?? dWidget.painters.first.diagram.toText;
  final String effectiveDescription = dWidget.description ?? dWidget.painters.first.diagram.description;

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
                padding: const pw.EdgeInsets.all(6),
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
              bottom: 4,
              right: 4,
              child: pw.Text(
                'IBEconToolkit.com',
                style: pw.TextStyle(
                  font: unicodeFont,
                  fontSize: 7,
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
          effectiveTitle,
          style: pw.TextStyle(
            font: unicodeFont,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      if (effectiveDescription.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Text(
            effectiveDescription,
            style: pw.TextStyle(
              font: unicodeFont,
              fontSize: 8,
              color: PdfColors.grey700,
            ),
            maxLines: 2,
            overflow: pw.TextOverflow.clip,
          ),
        ),
      pw.Container(
        child: dWidget.axis == Axis.horizontal
            ? pw.Row(children: pdfDiagrams)
            : pw.Column(children: pdfDiagrams),
      ),
    ],
  );
}