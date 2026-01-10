import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

import '../custom_widgets/definitions_grid.dart';
import '../custom_widgets/diagram_gallery.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

class HybridPdfService {
  static final ScreenshotController _screenshotController =
      ScreenshotController();

  static Future<void> exportToPdf({
    required String fileName,
    required List<dynamic> slides,
    required ThemeData theme,
  }) async {
    final pdf = pw.Document();

    // Load fonts
    final font = await PdfGoogleFonts.openSansRegular();
    final fontBold = await PdfGoogleFonts.openSansBold();

    // 1. PRE-PROCESS: Capture all Diagrams across all slides first
    // We use a Map to ensure diagrams stay linked to their specific slide index
    Map<int, List<Uint8List>> allCapturedDiagrams = {};

    for (int i = 0; i < slides.length; i++) {
      final s = slides[i];
      List<Uint8List> slideDiagrams = [];

      if (s.contents != null) {
        for (var c in s.contents!) {
          bool hasDiagrams = false;
          try {
            hasDiagrams =
                c.diagramWidgets != null && c.diagramWidgets!.isNotEmpty;
          } catch (_) {}

          if (hasDiagrams) {
            final bytes = await _screenshotController.captureFromWidget(
              MediaQuery(
                data: const MediaQueryData(size: Size(800, 800)),
                child: Material(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: DiagramGallery(diagrams: c.diagramWidgets!),
                  ),
                ),
              ),
              pixelRatio: 2.0,
            );
            slideDiagrams.add(bytes);
          }
        }
      }
      allCapturedDiagrams[i] = slideDiagrams;
    }

    // 2. GENERATE PDF: Use one MultiPage for the entire document
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        // This Footer will appear on every page automatically
        footer: (pw.Context context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 10),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(color: PdfColors.grey, fontSize: 8),
          ),
        ),
        build: (pw.Context context) {
          List<pw.Widget> allWidgets = [];

          for (int i = 0; i < slides.length; i++) {
            final s = slides[i];
            final slideDiagrams = allCapturedDiagrams[i] ?? [];

            // Slide Section Header
            allWidgets.add(
              pw.Container(
                width: double.infinity,
                // Add margin-top only if it's not the very first slide to save space
                margin: pw.EdgeInsets.only(top: i == 0 ? 0 : 12),
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: pw.BoxDecoration(
                  color: s.hl == true
                      ? PdfColors.blueGrey900
                      : PdfColors.blueGrey700,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(4),
                  ),
                ),
                child: pw.Text(
                  _cleanText(s.title ?? ''),
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            );

            if (s.contents != null) {
              for (var c in s.contents!) {
                // CASE A: Glossary Items
                dynamic groupedItems;
                try {
                  groupedItems = c.groupedItems;
                } catch (_) {}

                if (groupedItems != null) {
                  allWidgets.addAll(_buildNativeGlossary(groupedItems));
                  continue;
                }

                // CASE B: Standard Text Content
                if (c.term != null ||
                    c.content != null ||
                    c.alert != null ||
                    c.keyContent != null ||
                    c.examples != null) {
                  allWidgets.add(
                    _buildNativePdfTextBox(
                      title:
                          c.term?.term ??
                          c.keyContent?.title ??
                          (c.alert != null ? "ALERT" : ""),
                      body:
                          c.term?.explanation ??
                          c.content?.text ??
                          c.alert?.text ??
                          c.keyContent?.content ??
                          c.examples?.text ??
                          "",
                      color: _getAccentColor(c),
                    ),
                  );
                }

                // CASE C: Diagrams
                bool hasDiagrams = false;
                try {
                  hasDiagrams = c.diagramWidgets != null;
                } catch (_) {}

                if (hasDiagrams && slideDiagrams.isNotEmpty) {
                  final imgBytes = slideDiagrams.removeAt(0);
                  allWidgets.add(
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 8),
                      child: pw.Center(
                        child: pw.ConstrainedBox(
                          constraints: const pw.BoxConstraints(maxHeight: 300),
                          child: pw.Image(
                            pw.MemoryImage(imgBytes),
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
            }
          }
          return allWidgets;
        },
      ),
    );

    // Save and Layout
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: fileName,
    );
  }

  static List<pw.Widget> _buildNativeGlossary(
    Map<String, List<dynamic>> groupedItems,
  ) {
    List<pw.Widget> widgets = [];
    groupedItems.forEach((category, items) {
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
          child: pw.Row(
            children: [
              pw.Text(
                category.toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(width: 8),
              pw.Expanded(
                child: pw.Divider(color: PdfColors.grey300, thickness: 0.5),
              ),
            ],
          ),
        ),
      );

      for (var item in items) {
        widgets.add(
          _buildNativePdfTextBox(
            title: item.term?.term ?? "",
            body: item.term?.explanation ?? "",
            color: item.term?.tag == "hl"
                ? PdfColors.amber700
                : PdfColors.indigo700,
          ),
        );
      }
    });
    return widgets;
  }

  static pw.Widget _buildNativePdfTextBox({
    required String title,
    required String body,
    required PdfColor color,
  }) {
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(top: 4),
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        border: pw.Border(left: pw.BorderSide(color: color, width: 2)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            pw.Text(
              _cleanText(title).toUpperCase(),
              style: pw.TextStyle(
                fontSize: 7,
                color: color,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          pw.Text(
            _cleanText(body),
            style: const pw.TextStyle(fontSize: 9, lineSpacing: 1.1),
          ),
        ],
      ),
    );
  }

  static String _cleanText(String text) {
    return text
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&ndash;', '—')
        .replaceAll('&mdash;', '—')
        .replaceAll('&ne;', '≠')
        .replaceAll('&pi;', 'π')
        .replaceAll('&minus;', '−')
        .replaceAll('&deg;', '°')
        .trim();
  }

  static PdfColor _getAccentColor(dynamic c) {
    if (c.alert != null) return PdfColors.redAccent700;
    if (c.term != null) return PdfColors.indigo700;
    if (c.examples != null) return PdfColors.teal700;
    return PdfColors.blueGrey400;
  }
}
