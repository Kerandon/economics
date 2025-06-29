import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../quizzes/quiz_enums/diagram_enum.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';

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
    DiagramType? type2,
    DiagramSubtype? subtype2,
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

  @override
  List<Object?> get props => [type, subtype, description]; // <-- Add here
}
