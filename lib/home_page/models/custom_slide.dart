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

class CustomSlide2 {
  final dynamic section;
  final String? title;
  final List<CustomSlideContent>? contents;

  CustomSlide2({this.section, this.title, this.contents});

  CustomSlide2 copyWith({
    dynamic section,
    String? title,
    List<CustomSlideContent>? contents,
  }) {
    return CustomSlide2(
      section: section ?? this.section,
      title: title ?? this.title,
      contents: contents ?? this.contents,
    );
  }
}

class CustomSlideContent {
  final String? content;
  final String? term;
  final String? alert;
  final String? tip;
  final List<DiagramBundleEnum>? diagramBundleEnums;
  final List<DiagramBundle>? diagramBundles;

  CustomSlideContent({
    this.content,
    this.term,
    this.alert,
    this.tip,
    this.diagramBundleEnums,
    this.diagramBundles,
  });

  CustomSlideContent copyWith({
    String? content,
    String? term,
    String? alert,
    String? tip,
    List<DiagramBundleEnum>? diagramBundleEnums,
    List<DiagramBundle>? diagramBundles,
  }) {
    return CustomSlideContent(
      content: content ?? this.content,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      diagramBundleEnums: diagramBundleEnums ?? this.diagramBundleEnums,
      diagramBundles: diagramBundles ?? this.diagramBundles,
    );
  }
}
