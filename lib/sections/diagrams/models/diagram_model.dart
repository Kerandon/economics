import 'package:economics_app/app/configs/constants.dart';

import 'package:flutter/material.dart';

import '../data/all_diagrams.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import '../utils/mixins.dart';

class DiagramModel {
  final UnitType? unit;
  final DiagramType? type;
  final DiagramSubtype? subtype;
  final CustomPainter? painter;

  DiagramModel({this.unit, this.type, this.subtype, this.painter});

  // Serialization method
  Map<String, dynamic> toMap() {
    return {
      kUnit: unit?.name,
      kType: type?.name,
      kSubtype: subtype?.name,
    };
  }

  // Deserialization method from Firebase
  factory DiagramModel.fromFirebase(Map<String, dynamic> map) {
    return DiagramModel(
      unit: map[kUnit] != null
          ? UnitType.values.firstWhere((e) => e.name == map[kUnit])
          : null,
      type: map[kType] != null
          ? DiagramType.values.firstWhere((e) => e.name == map[kType])
          : null,
      subtype: map[kSubtype] != null
          ? DiagramSubtype.values.firstWhere((e) => e.name == map[kSubtype])
          : null,
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
  }) {
    return DiagramModel(
      unit: unit ?? this.unit,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      painter: painter ?? this.painter,
    );
  }

  /// If [selectDiagrams] is null, all diagrams will be retrieved
  static List<DiagramModel> getDiagrams(Size size, BuildContext context,
      {List<DiagramModel>? selectedDiagrams}) {
    final allDiagrams = AllDiagrams(
      size: size,
      colorScheme: Theme.of(context).colorScheme,
    ).getAllPainterDiagrams();

    List<DiagramModel> all = [];
    for (var e in allDiagrams) {
      final i = e as DiagramIdentifierMixin;

      all.add(i.model.copyWith(painter: e));
    }

    if (selectedDiagrams != null && selectedDiagrams.isNotEmpty) {
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
      return all.toList();
    }
  }
}