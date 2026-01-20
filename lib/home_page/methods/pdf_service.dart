import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HybridPdfService {
  static final PdfColor hlColor = PdfColor.fromHex('#FFA500');
  static final PdfColor supplementColor = PdfColor.fromHex('#FF0000');
  static final PdfColor defaultAppColor = PdfColor.fromHex('#008080');

  static Future<void> exportToPdf({
    required String fileName,
    required List<dynamic> slides,
    required Map<int, List<Uint8List>> diagramImages,
  }) async {
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();
    final mathFont = await PdfGoogleFonts.notoSansMathRegular();
    final fallbacks = <pw.Font>[mathFont, font];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: boldFont,
          fontFallback: fallbacks,
        ),
        build: (_) {
          final widgets = <pw.Widget>[];

          for (final slide in slides) {
            widgets.add(
              pw.Header(
                level: 1,
                text: (slide.title ?? '').toUpperCase(),
                textStyle: pw.TextStyle(
                  color: defaultAppColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );

            if (slide.contents != null) {
              for (final content in slide.contents) {
                final images = diagramImages[content.hashCode];
                widgets.addAll(_buildContent(content, images, fallbacks));
              }
            }

            widgets.add(pw.SizedBox(height: 20));
          }

          return widgets;
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }

  static List<pw.Widget> _buildContent(
    dynamic c,
    List<Uint8List>? images,
    List<pw.Font> fallbacks,
  ) {
    final items = <pw.Widget>[];

    // ---- GLOSSARY ----
    if (c.glossaryItems != null) {
      final sorted = [...c.glossaryItems]
        ..sort(
          (a, b) =>
              _tagPriority(a.term?.tag).compareTo(_tagPriority(b.term?.tag)),
        );

      dynamic lastTag;
      for (final item in sorted) {
        if (item.term?.tag != lastTag) {
          final title = _sectionTitleForTag(item.term?.tag);
          if (title != null) {
            items.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 12, bottom: 6),
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: _getPdfTagColor(item.term?.tag),
                  ),
                ),
              ),
            );
          }
          lastTag = item.term?.tag;
        }
        items.add(_buildTermBox(item.term, fallbacks));
      }
    }

    // ---- EVALUATION ----
    if (c.evaluationData != null) {
      items.add(_buildEvaluation(c.evaluationData, fallbacks));
    }

    // ---- DIAGRAM IMAGES ----
    if (images != null && images.isNotEmpty) {
      items.add(
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          child: pw.Wrap(
            spacing: 10,
            runSpacing: 10,
            children: images
                .map(
                  (img) => pw.Container(
                    width: 200,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.grey300,
                        width: 0.5,
                      ),
                    ),
                    child: pw.Image(pw.MemoryImage(img)),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    // ---- TABLES ----
    if (c.tableData != null) {
      items.add(
        pw.Table.fromTextArray(
          headers: c.tableData!.headers,
          data: c.tableData!.data,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellStyle: pw.TextStyle(fontSize: 9, fontFallback: fallbacks),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
        ),
      );
    }

    // ---- HTML TEXT ----
    if (c.content?.text != null) {
      items.addAll(_htmlToPdf(c.content.text, fallbacks));
    }

    return items;
  }

  // ================= HELPERS =================

  static pw.Widget _buildEvaluation(dynamic data, List<pw.Font> fallbacks) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          data.title,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12,
            fontFallback: fallbacks,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _evalColumn(
              data.leftTitle,
              data.leftItems,
              PdfColors.green50,
              PdfColors.green900,
              fallbacks,
            ),
            pw.SizedBox(width: 10),
            _evalColumn(
              data.rightTitle,
              data.rightItems,
              PdfColors.red50,
              PdfColors.red900,
              fallbacks,
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _evalColumn(
    String title,
    List<dynamic> items,
    PdfColor bg,
    PdfColor header,
    List<pw.Font> fallbacks,
  ) {
    return pw.Expanded(
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: bg,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        ),
        child: pw.Column(
          children: [
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(
                color: header,
                borderRadius: const pw.BorderRadius.vertical(
                  top: pw.Radius.circular(8),
                ),
              ),
              child: pw.Text(
                title,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(color: PdfColors.white, fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: items
                    .map(
                      (i) => pw.Bullet(
                        text: _stripHtml(i.toString()),
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontFallback: fallbacks,
                        ),
                      ),
                    )
                    .toList(),
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
      margin: const pw.EdgeInsets.only(bottom: 6),
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        border: pw.Border(left: pw.BorderSide(color: color, width: 2)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            term?.term ?? '',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: color,
              fontSize: 10,
              fontFallback: fallbacks,
            ),
          ),
          pw.Text(
            _stripHtml(term?.explanation ?? ''),
            style: pw.TextStyle(fontSize: 9, fontFallback: fallbacks),
          ),
        ],
      ),
    );
  }

  static List<pw.Widget> _htmlToPdf(String html, List<pw.Font> fallbacks) {
    final widgets = <pw.Widget>[];
    final liRegex = RegExp(r'<li>([\s\S]*?)<\/li>');

    final matches = liRegex.allMatches(html);
    if (matches.isNotEmpty) {
      for (final m in matches) {
        widgets.add(
          pw.Bullet(
            text: _stripHtml(m.group(1)!),
            style: pw.TextStyle(fontSize: 10, fontFallback: fallbacks),
          ),
        );
      }
    } else {
      widgets.add(
        pw.Text(
          _stripHtml(html),
          style: pw.TextStyle(fontSize: 10, fontFallback: fallbacks),
        ),
      );
    }
    return widgets;
  }

  static int _tagPriority(dynamic tag) {
    final t = tag?.toString().toLowerCase() ?? '';
    if (t.contains('hl')) return 1;
    if (t.contains('supplement')) return 2;
    return 3;
  }

  static String? _sectionTitleForTag(dynamic tag) {
    final t = tag?.toString().toLowerCase() ?? '';
    if (t.contains('hl')) return 'Higher Level (HL)';
    if (t.contains('supplement')) return 'Supplement';
    return null;
  }

  static PdfColor _getPdfTagColor(dynamic tag) {
    final t = tag?.toString().toLowerCase() ?? '';
    if (t.contains('hl')) return hlColor;
    if (t.contains('supplement')) return supplementColor;
    return defaultAppColor;
  }

  static String _stripHtml(String s) =>
      s.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ').trim();
}
