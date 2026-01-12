import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' as material;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/slide_content.dart';

class HybridPdfService {
  static final PdfColor hlColor = PdfColor.fromHex('#FFA500');
  static final PdfColor supplementColor = PdfColor.fromHex('#FF0000');
  static final PdfColor defaultAppColor = PdfColor.fromHex('#008080');

  static Future<void> exportToPdf({
    required String fileName,
    required List<dynamic> slides,
  }) async {
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();
    final mathFont = await PdfGoogleFonts.notoSansMathRegular();
    final List<pw.Font> fallbacks = [mathFont, font];

    // 1. DIAGRAM PRE-PROCESSING
    Map<int, List<Uint8List>> slideImageMap = {};
    for (var slide in slides) {
      if (slide.contents != null) {
        for (var content in slide.contents) {
          if (content.diagramWidgets != null && content.diagramWidgets!.isNotEmpty) {
            List<Uint8List> images = [];
            for (var dw in content.diagramWidgets!) {
              final bytes = await DiagramCaptureService.painterToBytes(dw.basePainterDiagram);
              if (bytes.isNotEmpty) images.add(bytes);
            }
            slideImageMap[content.hashCode] = images;
          }
        }
      }
    }

    // 2. BUILD PDF
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: boldFont, fontFallback: fallbacks),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        // Increased maxPages to handle long glossaries
        maxPages: 100,
        build: (pw.Context context) {
          List<pw.Widget> allWidgets = [];

          for (var s in slides) {
            allWidgets.add(pw.Header(
              level: 1,
              text: (s.title ?? s.syllabusPoint?.toString().split('.').last ?? '').toUpperCase(),
              textStyle: pw.TextStyle(color: defaultAppColor, fontWeight: pw.FontWeight.bold, fontSize: 16, fontFallback: fallbacks),
            ));

            if (s.contents != null) {
              for (var c in s.contents) {
                final captured = slideImageMap[c.hashCode];
                // We add the list of items directly to prevent nested columns from causing layout loops
                allWidgets.addAll(_buildStyledContent(c, fallbacks, captured));
              }
            }
            allWidgets.add(pw.SizedBox(height: 20));
          }
          return allWidgets;
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }

  static List<pw.Widget> _buildStyledContent(dynamic c, List<pw.Font> fallbacks, List<Uint8List>? images) {
    List<pw.Widget> items = [];

    // 1. Glossary Logic - Flattened to individual widgets
    if (c.glossaryItems != null) {
      final sorted = [...c.glossaryItems]..sort((a, b) =>
          _tagPriority(a.term?.tag).compareTo(_tagPriority(b.term?.tag)));

      dynamic lastTag;
      for (var item in sorted) {
        if (item.term?.tag != lastTag) {
          final title = _sectionTitleForTag(item.term?.tag);
          if (title != null) {
            items.add(pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10, bottom: 5),
              child: pw.Text(title, style: pw.TextStyle(color: _getPdfTagColor(item.term?.tag), fontWeight: pw.FontWeight.bold, fontSize: 14)),
            ));
          }
          lastTag = item.term?.tag;
        }
        items.add(_buildTermBox(item.term, fallbacks));
      }
    }

    // 2. Evaluation Logic - Crash Proofed
    if (c.evaluationData != null) {
      items.add(_buildPdfEvaluation(c.evaluationData, fallbacks));
    }

    // 3. Diagrams Logic
    if (images != null && images.isNotEmpty) {
      items.add(pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: images.map((b) => pw.Container(
            width: 200,
            decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300, width: 0.5)),
            child: pw.Image(pw.MemoryImage(b)),
          )).toList(),
        ),
      ));
    }

    // 4. Tables - Ensuring Simple Tables don't force a single block
    if (c.tableData != null) {
      items.add(pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Table.fromTextArray(
          headers: c.tableData!.headers,
          data: c.tableData!.data,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellStyle: pw.TextStyle(fontSize: 9, fontFallback: fallbacks),
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
        ),
      ));
    }

    if (c.content?.text != null) {
      items.addAll(_processHtmlToPdf(c.content!.text, fallbacks));
    }

    return items;
  }

  static pw.Widget _buildPdfEvaluation(dynamic data, List<pw.Font> fallbacks) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Text(data.title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12, fontFallback: fallbacks)),
        ),
        // We use a Row with CrossAxisAlignment.start to prevent height stretching
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _evalColumn(data.leftTitle, data.leftItems, PdfColors.green50, PdfColors.green900, fallbacks),
            pw.SizedBox(width: 10),
            _evalColumn(data.rightTitle, data.rightItems, PdfColors.red50, PdfColors.red900, fallbacks),
          ],
        ),
      ],
    );
  }

  static pw.Widget _evalColumn(String title, List<dynamic> items, PdfColor bg, PdfColor textCol, List<pw.Font> fallbacks) {
    return pw.Expanded(
      child: pw.Container(
        decoration: pw.BoxDecoration(color: bg, borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8))),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(color: textCol, borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(8))),
              child: pw.Text(title, textAlign: pw.TextAlign.center, style: const pw.TextStyle(color: PdfColors.white, fontSize: 9)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: items.map((i) => pw.Bullet(
                  text: _cleanHtml(i.toString()),
                  style: pw.TextStyle(fontSize: 8, fontFallback: fallbacks),
                  bulletSize: 2,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildTermBox(dynamic term, List<pw.Font> fallbacks) {
    final color = _getPdfTagColor(term?.tag);
    return pw.Container(
      // Allow the term box to break if it's exceptionally long
      // by not wrapping it in a constrained height container
      margin: const pw.EdgeInsets.only(bottom: 6),
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: color, width: 2)),
        color: PdfColors.grey50,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(term?.term ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: color, fontSize: 10, fontFallback: fallbacks)),
          pw.Text(_cleanHtml(term?.explanation ?? ''), style: pw.TextStyle(fontSize: 9, fontFallback: fallbacks)),
        ],
      ),
    );
  }

  // Helpers
  static int _tagPriority(dynamic tag) {
    if (tag == null) return 0;
    String t = tag.toString().toLowerCase();
    if (t.contains('hl')) return 1;
    if (t.contains('supplement')) return 2;
    return 3;
  }

  static String? _sectionTitleForTag(dynamic tag) {
    if (tag == null) return null;
    String t = tag.toString().toLowerCase();
    if (t.contains('hl')) return 'Higher Level (HL)';
    if (t.contains('supplement')) return 'Supplement';
    return null;
  }

  static PdfColor _getPdfTagColor(dynamic tag) {
    if (tag == null) return defaultAppColor;
    String t = tag.toString().toLowerCase();
    if (t.contains('hl')) return hlColor;
    if (t.contains('supplement')) return supplementColor;
    return defaultAppColor;
  }

  static List<pw.Widget> _processHtmlToPdf(String html, List<pw.Font> fallbacks) {
    final List<pw.Widget> widgets = [];
    final style = pw.TextStyle(fontSize: 10, fontFallback: fallbacks);
    final liRegex = RegExp(r"<li>([\s\S]*?)<\/li>", multiLine: true);
    final matches = liRegex.allMatches(html);

    if (matches.isNotEmpty) {
      for (var m in matches) {
        widgets.add(pw.Bullet(
          text: _cleanHtml(m.group(1)!),
          style: style,
          padding: const pw.EdgeInsets.only(bottom: 4),
        ));
      }
    } else {
      widgets.add(pw.Text(_cleanHtml(html), style: style));
    }
    return widgets;
  }

  static String _cleanHtml(String s) => s.replaceAll(RegExp(r"<[^>]*>"), "").replaceAll("&nbsp;", " ").trim();
}
class DiagramCaptureService {
  static Future<Uint8List> painterToBytes(dynamic painter, {ui.Size size = const ui.Size(500, 400)}) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    painter.paint(canvas, size);
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}