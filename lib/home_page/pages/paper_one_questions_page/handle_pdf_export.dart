
import 'package:economics_app/home_page/pages/paper_one_questions_page/export_all_questions_to_pdf.dart';
import 'package:flutter/material.dart';
import '../../../diagrams/data/all_diagrams.dart';
import '../../models/slide.dart';

Future<void> handlePdfExport(BuildContext context, Slide slide) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Generating Full PDF...'),
      duration: Duration(seconds: 1),
    ),
  );

  final theme = Theme.of(context);

  // FIX: Force a fixed logical size for PDF diagram generation
  // so fonts and curves scale predictably inside the 400x400 PdfPoint canvas.
  const pdfDiagramSize = Size(400, 400);

  final allDiagramsService = AllDiagrams(
    size: pdfDiagramSize,
    colorScheme: theme.colorScheme, // Keep the theme colors
  );

  // 🌟 UPDATED: Call the single-question exporter!
  // It handles the printing/sharing sheet automatically.
  await exportFullQuestionToPdf(slide, allDiagramsService);
}
