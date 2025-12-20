import 'package:economics_app/home_page/models/key_content.dart';
import 'package:economics_app/home_page/models/term.dart';
import 'package:economics_app/home_page/models/tip.dart';
import 'package:flutter/material.dart';
import '../../diagrams/enums/diagram_enum.dart';
import '../../diagrams/models/diagram_widget.dart';
import 'alert.dart';
import 'content.dart';

class SlideContent {
  final Content? content;
  final KeyContent? keyContent;
  final Term? term;
  final Alert? alert;
  final Tip? tip;
  final List<DiagramEnum>? diagramEnums;
  final List<DiagramWidget>? diagramWidgets;

  SlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.tip,
    this.diagramEnums,
    this.diagramWidgets, // 🔹 NEW: Add to the constructor.
  });

  SlideContent copyWith({
    Content? content,
    KeyContent? keyContent,
    Term? term,
    Alert? alert,
    Tip? tip,
    List<DiagramEnum>? diagramEnums,
    List<DiagramBundle>? diagramBundles,
    List<DiagramWidget>? diagramWidgets,
  }) {
    return SlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      diagramWidgets: diagramWidgets ?? this.diagramWidgets,
      diagramEnums: diagramEnums ?? this.diagramEnums,


    );
  }

  // ========== SIMPLE CONTENT HELPERS ==========
  factory SlideContent.text(String content, {Tag? tag}) =>
      SlideContent(content: Content(content, tag: tag));

  factory SlideContent.key(String title, String content, {Tag? tag}) =>
      SlideContent(
        keyContent: KeyContent(title: title, content: content, tag: tag),
      );

  factory SlideContent.term(String term, String explanation, {Tag? tag}) =>
      SlideContent(
        term: Term(term: term, explanation: explanation, tag: tag),
      );

  /// make redundant
  factory SlideContent.diagram(DiagramEnum diagram) =>
      SlideContent(diagramEnums: [diagram]);

  factory SlideContent.diagrams(List<DiagramEnum> diagrams) =>
      SlideContent(diagramEnums: diagrams);

  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  factory SlideContent.tip(String text) => SlideContent(tip: Tip(text));

  // 🔹 NEW: Factory constructor to create a slide with just a custom widget.
  factory SlideContent.customWidget(Widget widget) => SlideContent();

  factory SlideContent.textWithDiagram(
    String content,
    DiagramEnum diagram, {
    Tag? tag,
  }) => SlideContent(
    content: Content(content, tag: tag),
    diagramEnums: [diagram],
  );

  factory SlideContent.termWithContentAndDiagram(
    String term,
    String explanation,
    String content,
    DiagramEnum diagram, {
    Tag? tag,
  }) => SlideContent(
    term: Term(term: term, explanation: explanation, tag: tag),
    content: Content(content, tag: tag),
    diagramEnums: [diagram],
  );
}
