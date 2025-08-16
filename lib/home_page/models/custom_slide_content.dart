import 'package:economics_app/home_page/models/key_content.dart';
import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/models/diagram_bundle.dart';
import 'custom_term.dart';

class CustomSlideContent {
  final String? content;
  final KeyContent? keyContent;
  final CustomTerm? term; // key: term, value: definition
  final String? alert;
  final String? tip;
  final List<DiagramBundleEnum>? diagramBundleEnums;
  final List<DiagramBundle>? diagramBundles;

  CustomSlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.tip,
    this.diagramBundleEnums,
    this.diagramBundles,
  });

  CustomSlideContent copyWith({
    String? content,
    KeyContent? keyContent,
    CustomTerm? term,
    String? alert,
    String? tip,
    List<DiagramBundleEnum>? diagramBundleEnums,
    List<DiagramBundle>? diagramBundles,
  }) {
    return CustomSlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      diagramBundleEnums: diagramBundleEnums ?? this.diagramBundleEnums,
      diagramBundles: diagramBundles ?? this.diagramBundles,
    );
  }
}
