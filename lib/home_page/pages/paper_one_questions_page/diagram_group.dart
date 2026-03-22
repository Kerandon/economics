import '../../../diagrams/enums/diagram_enum.dart';

class DiagramGroup {
  final List<DiagramEnum> enums;
  final String? explanation;

  const DiagramGroup({
    required this.enums,
    this.explanation,
  });
}