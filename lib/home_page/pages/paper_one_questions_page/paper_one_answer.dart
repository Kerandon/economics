import '../../../diagrams/enums/diagram_enum.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';
import '../../models/tip.dart';
import '../terms/terms.dart';
import 'diagram_group.dart';
class PaperOneAnswer {
  final String? tldr; // ✨ The 2026 attention-span saver!
  final List<EconTerm>? terms;
  final List<SlideContent>? explanation;
  final DiagramGroup? diagrams;
  final EvaluationData? evaluation;
  final List<Example>? realWorldExamples;

  const PaperOneAnswer({
    this.tldr,
    this.terms,
    this.explanation,
    this.diagrams,
    this.evaluation,
    this.realWorldExamples,
  });
}