import 'dart:typed_data';
import 'package:economics_app/home_page/models/key_content.dart';
import 'package:economics_app/home_page/models/term.dart';
import 'package:economics_app/home_page/models/example.dart';
import 'package:economics_app/home_page/models/tip.dart';
import 'package:flutter/material.dart';
import '../../diagrams/enums/diagram_enum.dart';
import '../../diagrams/models/diagram_widget.dart';
import '../custom_widgets/definitions_grid.dart';
import '../custom_widgets/simple_table.dart';
import '../pages/real_world_examples/real_world_examples.dart';
import '../pages/terms/terms.dart';
import 'alert.dart';
import 'content.dart';

import '../custom_widgets/evaluation_widget.dart'; // Ensure this is imported

/// Helper class to hold raw table data for PDF export
class TableData {
  final List<String> headers;
  final List<List<String>> data;
  final String? title;
  final String? figCaption;

  TableData({
    required this.headers,
    required this.data,
    this.title,
    this.figCaption,
  });
}

/// 🆕 Helper class to hold evaluation data for PDF export
class EvaluationData {
  final String title;
  final String leftTitle;
  final String rightTitle;
  final List<String> leftItems;
  final List<String> rightItems;
  final String centerLabel;

  EvaluationData({
    required this.title,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftItems,
    required this.rightItems,
    this.centerLabel = 'VS',
  });
}

class SlideContent {
  // Basic Text Types
  final Content? content;
  final KeyContent? keyContent;
  final Term? term;
  final Alert? alert;
  final Tip? tip; // 🆕 Added Tip
  final String? tldr;
  final List<EconTerm>? econTerms;
  final List<RealWorldExamples>? realWorldExamples;

  // Visuals
  final List<DiagramEnum>? diagramEnums;
  final List<DiagramWidget>? diagramWidgets;

  // This field stores the "captured" screenshots for the PDF
  final List<Uint8List>? diagramImages;

  // Custom Widgets (For UI rendering)
  final Widget? widget;

  // Data fields specifically for PDF Export
  final List<SlideContent>? glossaryItems;
  final TableData? tableData;
  final EvaluationData? evaluationData;

  SlideContent({
    this.content,
    this.keyContent,
    this.term,
    this.alert,
    this.tip, // 🆕 Added
    this.tldr,
    this.econTerms,
    this.realWorldExamples,
    this.diagramEnums,
    this.diagramWidgets,
    this.diagramImages,
    this.widget,
    this.glossaryItems,
    this.tableData,
    this.evaluationData,
  });

  SlideContent copyWith({
    Content? content,
    KeyContent? keyContent,
    Term? term,
    Alert? alert,
    Tip? tip, // 🆕 Added
    String? tldr,
    List<EconTerm>? econTerms,
    List<RealWorldExamples>? realWorldExamples,
    List<DiagramEnum>? diagramEnums,
    List<DiagramWidget>? diagramWidgets,
    List<Uint8List>? diagramImages,
    Widget? widget,
    List<SlideContent>? glossaryItems,
    TableData? tableData,
    EvaluationData? evaluationData,
  }) {
    return SlideContent(
      content: content ?? this.content,
      keyContent: keyContent ?? this.keyContent,
      term: term ?? this.term,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip, // 🆕 Added
      tldr: tldr ?? this.tldr,
      econTerms: econTerms ?? this.econTerms,
      realWorldExamples: realWorldExamples ?? this.realWorldExamples,
      diagramWidgets: diagramWidgets ?? this.diagramWidgets,
      diagramEnums: diagramEnums ?? this.diagramEnums,
      diagramImages: diagramImages ?? this.diagramImages,
      widget: widget ?? this.widget,
      glossaryItems: glossaryItems ?? this.glossaryItems,
      tableData: tableData ?? this.tableData,
      evaluationData: evaluationData ?? this.evaluationData,
    );
  }

  // ========== FACTORIES ==========

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

  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  // 🆕 Added Tip Factory
  factory SlideContent.tip(String text, {List<Tag>? tags}) =>
      SlideContent(tip: Tip(text, tags: tags));

  factory SlideContent.tldr(String text) => SlideContent(tldr: text);

  factory SlideContent.econTerms(List<EconTerm> terms) =>
      SlideContent(econTerms: terms);

  factory SlideContent.realWorldExamples(List<RealWorldExamples> examples) =>
      SlideContent(realWorldExamples: examples);

  factory SlideContent.diagrams(List<DiagramEnum> diagrams) =>
      SlideContent(diagramEnums: diagrams);

  factory SlideContent.customWidget(Widget widget) =>
      SlideContent(widget: widget);

  // 8. GLOSSARY LIST (Fixed for App + PDF)
  factory SlideContent.glossary(List<SlideContent> items) {
    return SlideContent(
      glossaryItems: items,
      widget: DefinitionList(items: items),
    );
  }

  // 9. SIMPLE TABLE
  factory SlideContent.simpleTable({
    required List<String> headers,
    required List<List<String>> data,
    String? title,
    String? figCaption,
  }) {
    final table = TableData(
      headers: headers,
      data: data,
      title: title,
      figCaption: figCaption,
    );
    return SlideContent(
      tableData: table,
      widget: SimpleTable(
        headers: headers,
        data: data,
        title: title,
        figCaption: figCaption,
      ),
    );
  }

  // 10. EVALUATION FACTORY
  factory SlideContent.evaluation({
    required String title,
    required String leftTitle,
    required String rightTitle,
    required List<String> leftItems,
    required List<String> rightItems,
    String centerLabel = 'VS',
  }) {
    final eval = EvaluationData(
      title: title,
      leftTitle: leftTitle,
      rightTitle: rightTitle,
      leftItems: leftItems,
      rightItems: rightItems,
      centerLabel: centerLabel,
    );
    return SlideContent(
      evaluationData: eval,
      widget: EvaluationWidget(
        title: title,
        leftTitle: leftTitle,
        rightTitle: rightTitle,
        leftItems: leftItems,
        rightItems: rightItems,
        centerLabel: centerLabel,
      ),
    );
  }
}
