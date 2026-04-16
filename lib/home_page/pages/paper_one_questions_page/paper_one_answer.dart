import '../../../diagrams/enums/diagram_enum.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';
import '../../models/example.dart';
import '../real_world_examples/real_world_examples.dart';
import '../terms/terms.dart';
import 'diagram_group.dart';
class PaperOneAnswer {
  final String? tldr;
  final List<EconTerm>? terms;
  final List<SlideContent>? explanation;
  final List<DiagramGroup>? diagrams;
  // Updated to a List to support multiple evaluation points
  final List<EvaluationData>? evaluation;
  // Updated to use your new Enum class
  final List<RealWorldExamples>? realWorldExamples;

  const PaperOneAnswer({
    this.tldr,
    this.terms,
    this.explanation,
    this.diagrams,
    this.evaluation,
    this.realWorldExamples,
  });
}