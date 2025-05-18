import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../quizzes/quiz_enums/diagram_enum.dart';
import '../data/all_diagrams.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import '../utils/mixins.dart';

class DiagramModel extends Equatable {
  final UnitType? unit;
  final DiagramType? type;
  final DiagramSubtype? subtype;
  final CustomPainter? painter;
  final String? description;

  const DiagramModel({
    this.unit,
    this.type,
    this.subtype,
    this.painter,
    this.description,
  });

  // Serialization method
  Map<String, dynamic> toMap() {
    return {
      DiagramKey.unit.name: unit?.name,
      DiagramKey.type.name: type?.name,
      DiagramKey.subtype.name: subtype?.name,
      'description': description, // <-- Include it here
    };
  }

  // Deserialization method from Firebase
  factory DiagramModel.fromFirebase(Map<String, dynamic> map) {


    return DiagramModel(
      unit: map[DiagramKey.unit.name] != null
          ? UnitType.values
          .firstWhere((e) => e.name == map[DiagramKey.unit.name])
          : null,
      type: map[DiagramKey.type.name] != null
          ? DiagramType.values
          .firstWhere((e) => e.name == map[DiagramKey.type.name])
          : null,
      subtype: map[DiagramKey.subtype.name] != null
          ? DiagramSubtype.values
          .firstWhere((e) => e.name == map[DiagramKey.subtype.name])
          : null,
      description: map['description'], // <-- Deserialize it
    );
  }

  static List<DiagramModel>? fromFirebaseList(List<dynamic>? data) {
    if (data != null) {
      final diagramsList = data;
      if (diagramsList.isEmpty) {
        return null;
      } else {

        return diagramsList
            .map(
              (e) => DiagramModel.fromFirebase(
            Map<String, dynamic>.from(e),
          ),
        )
            .toList();
      }
    }
    return null;
  }

  // CopyWith method
  DiagramModel copyWith({
    UnitType? unit,
    DiagramType? type,
    DiagramSubtype? subtype,
    CustomPainter? painter,
    String? description, // <-- Add to copyWith
  }) {
    return DiagramModel(
      unit: unit ?? this.unit,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      painter: painter ?? this.painter,
      description: description ?? this.description,
    );
  }

  static List<DiagramModel> getSelectedDiagrams(Size size, BuildContext context,
      {required List<DiagramModel> selectedDiagrams}) {
    final allDiagrams = AllDiagrams(
      size: size,
      colorScheme: Theme.of(context).colorScheme,
    ).getAllPainterDiagrams();

    List<DiagramModel> all = [];
    for (var e in allDiagrams) {
      final i = e as DiagramIdentifierMixin;

      all.add(i.model.copyWith(painter: e));
    }

    if (selectedDiagrams.isNotEmpty) {
      List<DiagramModel> selected = [];
      for (var s in selectedDiagrams) {
        for (var a in all) {
          if (s.type == a.type && s.subtype == s.subtype) {
            selected.add(a);
          }
        }
      }
      return selected.toList();
    } else {
      return [];
    }
  }

  static List<DiagramModel> getAllDiagrams(Size size, BuildContext context) {
    final allDiagrams = AllDiagrams(
      size: size,
      colorScheme: Theme.of(context).colorScheme,
    ).getAllPainterDiagrams();

    List<DiagramModel> all = [];
    for (var e in allDiagrams) {
      final i = e as DiagramIdentifierMixin;

      all.add(i.model.copyWith(painter: e));
    }
    return all;
  }
  static List<DiagramModel> getUniqueByUnitAndType(Size size, BuildContext context) {
    final List<DiagramModel> allDiagrams = getAllDiagrams(size, context);

    final Set<String> seenKeys = {};
    final List<DiagramModel> uniqueDiagrams = [];

    for (final diagram in allDiagrams) {
      final key = '${diagram.unit}_${diagram.type}';
      if (seenKeys.add(key)) {
        uniqueDiagrams.add(diagram);
      }
    }

    return uniqueDiagrams;
  }



  @override
  List<Object?> get props => [type, subtype, description]; // <-- Add here
}
