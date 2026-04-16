// --- HELPER FOR PDF EXPORT ---
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';
import 'package:flutter/material.dart';

import '../../../diagrams/data/all_diagrams.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/helper_methods/export_diagrams_to_pdf.dart';
import '../../../diagrams/models/diagram_painter_config.dart';
import '../../models/slide.dart';
import 'export_full_question_to_pdf.dart';
// Update this in QuestionDetailPage
// Update this in QuestionDetailPage (or wherever you keep it)
Future<void> handlePdfExport(BuildContext context, Slide slide) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Generating Full PDF...'), duration: Duration(seconds: 1)),
  );

  // Hydrate all diagrams for the whole page ahead of time
  final size = MediaQuery.of(context).size;
  final theme = Theme.of(context);
  final allDiagramsService = AllDiagrams(size: size, colorScheme: theme.colorScheme);

  await exportFullQuestionToPdf(slide, allDiagramsService);
}
