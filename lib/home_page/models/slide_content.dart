import 'dart:typed_data';
import 'package:economics_app/home_page/models/example.dart';
import 'package:economics_app/home_page/models/tip.dart';
import 'package:flutter/material.dart';
import '../../diagrams/enums/diagram_enum.dart';
import '../../diagrams/models/diagram_widget.dart';
import '../custom_widgets/definitions_grid.dart';
import '../custom_widgets/simple_table.dart';
import '../enums/tag.dart';
import '../pages/real_world_examples/real_world_examples.dart';
import '../pages/terms/terms.dart';
import 'alert.dart';

import '../custom_widgets/evaluation_widget.dart';
import 'body.dart';
import 'key_body.dart';

/// Helper class to hold raw table data for PDF export
class TableData {
  final List<String> headers;
  final List<List<String>> data;
  final String? title;
  final String? figCaption;
  final List<Tag>? tags;
  final List<double>? flexColumnWidths; // 🌟 NEW: Custom column sizing

  TableData({
    required this.headers,
    required this.data,
    this.title,
    this.figCaption,
    this.tags,
    this.flexColumnWidths, // 🌟 NEW
  });
}

class SlideContent {
  // Basic Text Types
  final Body? content;

  final Alert? alert;
  final Tip? tip;
  final List<EconTerm>? econTerms;
  final List<RealWorldExamples>? realWorldExamples;

  // Visuals
  final List<DiagramEnum>? diagramEnums;
  final List<DiagramWidget>? diagramWidgets;
  final String? diagramDescription;
  final List<Tag>? diagramTags; // 🌟 NEW: Added to hold tags for diagrams

  // Custom Widgets (For UI rendering)
  final Widget? widget;
  final TableData? tableData;

  SlideContent({
    this.content,
    this.alert,
    this.tip,
    this.econTerms,
    this.realWorldExamples,
    this.diagramEnums,
    this.diagramWidgets,
    this.diagramDescription,
    this.diagramTags, // 🌟 NEW
    this.widget,
    this.tableData,
  });

  SlideContent copyWith({
    Body? content,
    Alert? alert,
    Tip? tip,
    List<EconTerm>? econTerms,
    List<RealWorldExamples>? realWorldExamples,
    List<DiagramEnum>? diagramEnums,
    List<DiagramWidget>? diagramWidgets,
    String? diagramDescription,
    List<Tag>? diagramTags, // 🌟 NEW
    Widget? widget,
    TableData? tableData,
  }) {
    return SlideContent(
      content: content ?? this.content,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      econTerms: econTerms ?? this.econTerms,
      realWorldExamples: realWorldExamples ?? this.realWorldExamples,
      diagramWidgets: diagramWidgets ?? this.diagramWidgets,
      diagramEnums: diagramEnums ?? this.diagramEnums,
      diagramDescription: diagramDescription ?? this.diagramDescription,
      diagramTags: diagramTags ?? this.diagramTags, // 🌟 NEW
      widget: widget ?? this.widget,
      tableData: tableData ?? this.tableData,
    );
  }

  // ========== FACTORIES ==========

  factory SlideContent.text(String content, {List<Tag>? tags}) =>
      SlideContent(content: Body(content, tags: tags));

  factory SlideContent.alert(String text) => SlideContent(alert: Alert(text));

  factory SlideContent.tip(String text, {List<Tag>? tags}) =>
      SlideContent(tip: Tip(text, tags: tags));

  factory SlideContent.econTerms(List<EconTerm> terms) =>
      SlideContent(econTerms: terms);

  factory SlideContent.realWorldExamples(List<RealWorldExamples> examples) =>
      SlideContent(realWorldExamples: examples);

  // 🌟 NEW: Updated to accept an optional list of tags
  factory SlideContent.diagrams(
    List<DiagramEnum> diagrams, {
    String? description,
    List<Tag>? tags,
  }) => SlideContent(
    diagramEnums: diagrams,
    diagramDescription: description,
    diagramTags: tags,
  );

  factory SlideContent.customWidget(Widget widget) =>
      SlideContent(widget: widget);

  // 9. SIMPLE TABLE
  factory SlideContent.simpleTable({
    required List<String> headers,
    required List<List<String>> data,
    String? title,
    String? figCaption,
    List<Tag>? tags,
    List<double>? flexColumnWidths, // 🌟 NEW
  }) {
    final table = TableData(
      headers: headers,
      data: data,
      title: title,
      figCaption: figCaption,
      tags: tags,
      flexColumnWidths: flexColumnWidths, // 🌟 NEW
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
}
