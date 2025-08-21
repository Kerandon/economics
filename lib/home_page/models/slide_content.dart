import 'package:economics_app/home_page/models/key_content.dart';
import 'package:economics_app/home_page/models/term.dart';
import 'package:economics_app/home_page/models/tip.dart';
import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/models/diagram_bundle.dart';
import 'alert.dart';
import 'content.dart';

class SlideContent {
  final Content? content;
  final KeyContent? keyContent;
  final Term? term;
  final Alert? alert;
  final Tip? tip;
  final List<DiagramBundleEnum>? diagramBundleEnums;
  final List<DiagramBundle>? diagramBundles;

  SlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.tip,
    this.diagramBundleEnums,
    this.diagramBundles,
  });

  SlideContent copyWith({
    Content? content,
    KeyContent? keyContent,
    Term? term,
    Alert? alert,
    Tip? tip,
    List<DiagramBundleEnum>? diagramBundleEnums,
    List<DiagramBundle>? diagramBundles,
  }) {
    return SlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      diagramBundleEnums: diagramBundleEnums ?? this.diagramBundleEnums,
      diagramBundles: diagramBundles ?? this.diagramBundles,
    );
  }

  // ========== SIMPLE CONTENT HELPERS ==========
  factory SlideContent.text(String content, {bool hl = false}) =>
      SlideContent(content: Content(content, hl: hl));

  factory SlideContent.key(String title, String content, {bool hl = false}) =>
      SlideContent(
        keyContent: KeyContent(title: title, content: content, hl: hl),
      );

  factory SlideContent.term(
    String term,
    String explanation, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
  );

  factory SlideContent.diagram(DiagramBundleEnum diagram) =>
      SlideContent(diagramBundleEnums: [diagram]);

  factory SlideContent.diagrams(List<DiagramBundleEnum> diagrams) =>
      SlideContent(diagramBundleEnums: diagrams);

  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  factory SlideContent.tip(String text) => SlideContent(tip: Tip(text));

  // ========== COMBINATION HELPERS ==========
  factory SlideContent.textWithDiagram(
    String content,
    DiagramBundleEnum diagram, {
    bool hl = false,
  }) => SlideContent(
    content: Content(content, hl: hl),
    diagramBundleEnums: [diagram],
  );

  factory SlideContent.keyWithDiagram(
    String title,
    String content,
    DiagramBundleEnum diagram, {
    bool hl = false,
  }) => SlideContent(
    keyContent: KeyContent(title: title, content: content, hl: hl),
    diagramBundleEnums: [diagram],
  );

  factory SlideContent.termWithDiagram(
    String term,
    String explanation,
    DiagramBundleEnum diagram, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    diagramBundleEnums: [diagram],
  );

  factory SlideContent.termWithContent(
    String term,
    String explanation,
    String content, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    content: Content(content, hl: hl),
  );

  factory SlideContent.termWithKey(
    String term,
    String explanation,
    String keyTitle,
    String keyContent, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    keyContent: KeyContent(title: keyTitle, content: keyContent, hl: hl),
  );

  /// 🔹 NEW: term + content + key content
  factory SlideContent.termWithContentAndKey(
    String term,
    String explanation,
    String content,
    String keyTitle,
    String keyContent, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    content: Content(content, hl: hl),
    keyContent: KeyContent(title: keyTitle, content: keyContent, hl: hl),
  );

  factory SlideContent.termWithContentAndDiagram(
    String term,
    String explanation,
    String content,
    DiagramBundleEnum diagram, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    content: Content(content, hl: hl),
    diagramBundleEnums: [diagram],
  );

  /// 🔹 NEW: term + content + key content + diagram
  factory SlideContent.termWithContentKeyAndDiagram(
    String term,
    String explanation,
    String content,
    String keyTitle,
    String keyContent,
    DiagramBundleEnum diagram, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    content: Content(content, hl: hl),
    keyContent: KeyContent(title: keyTitle, content: keyContent, hl: hl),
    diagramBundleEnums: [diagram],
  );

  // ========== ADVANCED COMBINATIONS ==========
  factory SlideContent.textWithDiagrams(
    String content,
    List<DiagramBundleEnum> diagrams, {
    bool hl = false,
  }) => SlideContent(
    content: Content(content, hl: hl),
    diagramBundleEnums: diagrams,
  );

  factory SlideContent.termWithDiagrams(
    String term,
    String explanation,
    List<DiagramBundleEnum> diagrams, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    diagramBundleEnums: diagrams,
  );

  factory SlideContent.textWithAlert(
    String content,
    String alertText, {
    bool hl = false,
  }) => SlideContent(
    content: Content(content, hl: hl),
    alert: Alert(alertText),
  );

  factory SlideContent.textWithTip(
    String content,
    String tipText, {
    bool hl = false,
  }) => SlideContent(
    content: Content(content, hl: hl),
    tip: Tip(tipText),
  );
  factory SlideContent.termWithContentKeyAndDiagrams(
    String term,
    String explanation,
    String content,
    String keyTitle,
    String keyContent,
    List<DiagramBundleEnum> diagrams, {
    bool hl = false,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, hl: hl),
    content: Content(content, hl: hl),
    keyContent: KeyContent(title: keyTitle, content: keyContent, hl: hl),
    diagramBundleEnums: diagrams,
  );
}
