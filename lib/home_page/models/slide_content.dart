import 'package:economics_app/home_page/models/key_content.dart';
import 'package:economics_app/home_page/models/term.dart';
import 'package:economics_app/home_page/models/tip.dart';
import 'package:flutter/material.dart';
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
  final Widget? widget; // 🔹 NEW: Property to hold a custom widget.

  SlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.tip,
    this.diagramBundleEnums,
    this.diagramBundles,
    this.widget, // 🔹 NEW: Add to the constructor.
  });

  SlideContent copyWith({
    Content? content,
    KeyContent? keyContent,
    Term? term,
    Alert? alert,
    Tip? tip,
    List<DiagramBundleEnum>? diagramBundleEnums,
    List<DiagramBundle>? diagramBundles,
    Widget? widget,
  }) {
    return SlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      diagramBundleEnums: diagramBundleEnums ?? this.diagramBundleEnums,
      diagramBundles: diagramBundles ?? this.diagramBundles,
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

  factory SlideContent.term(
    String term,
    String explanation, {Tag? tag}) => SlideContent(
    term: Term(term: term, explanation: explanation, tag: tag),
  );

  factory SlideContent.diagram(DiagramBundleEnum diagram) =>
      SlideContent(diagramBundleEnums: [diagram]);


  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  factory SlideContent.tip(String text) => SlideContent(tip: Tip(text));

  // 🔹 NEW: Factory constructor to create a slide with just a custom widget.
  factory SlideContent.customWidget(Widget widget) =>
      SlideContent(widget: widget);

  factory SlideContent.textWithDiagram(
    String content,
    DiagramBundleEnum diagram,{Tag? tag}) => SlideContent(
    content: Content(content, tag: tag),
    diagramBundleEnums: [diagram],
  );

  factory SlideContent.termWithContentAndDiagram(
    String term,
    String explanation,
    String content,
    DiagramBundleEnum diagram,{Tag? tag}) => SlideContent(
    term: Term(term: term, explanation: explanation, tag: tag),
    content: Content(content, tag: tag),
    diagramBundleEnums: [diagram],
  );

}
