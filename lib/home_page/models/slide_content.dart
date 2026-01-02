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
  final Example? examples;
  final List<DiagramEnum>? diagramEnums;
  final List<DiagramWidget>? diagramWidgets;
  final Widget? widget;

  SlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.examples,
    this.diagramEnums,
    this.diagramWidgets,
    this.widget,
  });

  SlideContent copyWith({
    Content? content,
    KeyContent? keyContent,
    Term? term,
    Alert? alert,
    Example? examples,
    List<DiagramEnum>? diagramEnums,
    List<DiagramWidget>? diagramWidgets,
    Widget? widget,
  }) {
    return SlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      examples: examples ?? this.examples,
      diagramWidgets: diagramWidgets ?? this.diagramWidgets,
      diagramEnums: diagramEnums ?? this.diagramEnums,
      widget: widget ?? this.widget,
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

  factory SlideContent.diagrams(List<DiagramEnum> diagrams) =>
      SlideContent(diagramEnums: diagrams);

  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  factory SlideContent.examples(String text) => SlideContent(examples: Example(text));

  factory SlideContent.customWidget(Widget widget) =>
      SlideContent(widget: widget);
}
