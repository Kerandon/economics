import 'package:pdf/widgets.dart' as pw;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

// ----------------------------------------------------------------------
// 💡 UPDATED HTML to PDF Parsing Helper Function
/// Converts an HTML string into a list of pw.InlineSpan widgets.
List<pw.InlineSpan> parseHtmlToPdfTextSpans(
  String htmlText,
  pw.TextStyle defaultStyle,
) {
  // 🚀 FIX: Pre-process the text to handle problematic symbols and quotes
  String cleanedHtmlText = htmlText
      // 1. Fix for Delta symbol (use text as replacement if font fails)
      .replaceAll('∆', 'Change In ')
      .replaceAll('&Delta;', 'Change in ')
      // 2. Fix for various single quote/apostrophe characters
      .replaceAll('’', "'")
      .replaceAll('‘', "'")
      .replaceAll('“', "'")
      .replaceAll('”', '"');

  final document = parse(cleanedHtmlText); // Use the cleaned text
  final spans = <pw.InlineSpan>[];

  // Helper function for recursive parsing
  void parseNode(dom.Node node, pw.TextStyle currentStyle) {
    if (node is dom.Text) {
      // Handle plain text
      final text = node.text.trim();
      if (text.isNotEmpty || node.text.contains(' ')) {
        // Keep spaces/newlines
        spans.add(pw.TextSpan(text: node.text, style: currentStyle));
      }
    } else if (node is dom.Element) {
      pw.TextStyle nextStyle = currentStyle;

      // Apply style based on the tag name
      switch (node.localName) {
        case 'strong':
        case 'b':
          nextStyle = currentStyle.copyWith(fontWeight: pw.FontWeight.bold);
          break;
        case 'em':
        case 'i':
          nextStyle = currentStyle.copyWith(fontStyle: pw.FontStyle.italic);
          break;
        case 'u':
          nextStyle = currentStyle.copyWith(
            decoration: pw.TextDecoration.underline,
          );
          break;
        case 'p':
          // Add a newline before the <p> content if it's not the very start
          if (spans.isNotEmpty) {
            spans.add(pw.TextSpan(text: '\n\n', style: nextStyle));
          }
          break;
        case 'br':
          spans.add(pw.TextSpan(text: '\n', style: nextStyle));
          break;
        // Add more tags as needed
      }

      // Recursively parse children with the new style
      for (var child in node.nodes) {
        parseNode(child, nextStyle);
      }

      // Add extra spacing for block elements like <p> after their content
      if (node.localName == 'p') {
        spans.add(pw.TextSpan(text: '\n', style: nextStyle));
      }
    }
  }

  // Start parsing from the body (or root element)
  if (document.body != null) {
    for (var node in document.body!.nodes) {
      parseNode(node, defaultStyle);
    }
  }

  return spans;
}
