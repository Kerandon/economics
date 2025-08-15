import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/models/diagram_bundle.dart';

class CustomSlide {
  final dynamic section;
  final String? title;
  final String? content;
  final List<DiagramBundleEnum>? diagramBundleEnums;
  final List<DiagramBundle>? diagramBundles;

  CustomSlide({
    required this.section,
    this.title,
    this.content,
    this.diagramBundleEnums,
    this.diagramBundles,
  });

  CustomSlide copyWith({
    dynamic section,
    String? title,
    String? content,
    List<DiagramBundleEnum>? diagramBundleEnums,
    List<DiagramBundle>? diagramBundles,
  }) {
    return CustomSlide(
      section: section ?? this.section,
      title: title ?? this.title,
      content: content ?? this.content,
      diagramBundleEnums: diagramBundleEnums ?? this.diagramBundleEnums,
      diagramBundles: diagramBundles ?? this.diagramBundles,
    );
  }
}
