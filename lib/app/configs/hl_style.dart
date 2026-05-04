import 'package:pdf/pdf.dart';

import '../../home_page/enums/tag.dart';
import '../../home_page/models/slide.dart';

import 'package:pdf/pdf.dart';
import '../../home_page/enums/tag.dart';

class HlStyle {
  // 🌟 UPDATED: Now accepts any list of tags
  static bool hasHL(List<Tag>? tags) => tags?.contains(Tag.hl) ?? false;

  static String label(String text, bool isHL) {
    return isHL ? '$text [HL]' : text;
  }

  static PdfColor textColor(bool isHL) {
    return isHL ? PdfColors.deepOrange900 : PdfColors.indigo900;
  }

  static PdfColor bgColor(bool isHL) {
    return isHL ? PdfColors.orange50 : PdfColors.indigo50;
  }

  static PdfColor borderColor(bool isHL) {
    return isHL ? PdfColors.deepOrange700 : PdfColors.indigo700;
  }
}