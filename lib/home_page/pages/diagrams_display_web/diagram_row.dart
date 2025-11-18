import 'package:pdf/widgets.dart'
    as pw; // Use the standard alias for pdf widgets

class DiagramRow {
  final String title;
  final List<pw.MemoryImage>
  images; // This now correctly refers to pdf.widgets.MemoryImage

  DiagramRow({required this.title, required this.images});
}
