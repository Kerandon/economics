import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../models/slide.dart';
import 'quick_notes_pdf_builder.dart';
import 'slides/global_slides.dart';
import 'slides/macro_slides.dart';
import 'slides/micro_slides.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/export_all_questions_to_pdf.dart';
import 'package:flutter/material.dart';

Future<void> handlePdfExport(BuildContext context, Slide slide) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Generating Full PDF...'),
      duration: Duration(seconds: 1),
    ),
  );

  final theme = Theme.of(context);

  // 🌟 THE FIX: Use the actual screen size so the diagram calculates
  // the correct, high-res proportional font sizes!
  final diagramSize = MediaQuery.of(context).size;

  final allDiagramsService = AllDiagrams(
    size: diagramSize,
    colorScheme: theme.colorScheme,
  );

  await exportFullQuestionToPdf(slide, allDiagramsService);
}
