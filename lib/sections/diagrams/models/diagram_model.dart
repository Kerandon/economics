import 'package:economics_app/app/configs/constants.dart';

enum UnitType {
  micro,
  macro,
  global,
}

enum DiagramType {
  perfectCompetition,
  circularFlowOfIncome,
}

enum DiagramSubtype {
  closed,
  longRunEquilibrium,
}

class DiagramModel {
  final UnitType? unit;
  final DiagramType? type;
  final DiagramSubtype? subtype;

  DiagramModel({this.unit, this.type, this.subtype});

  // Serialization method
  Map<String, dynamic> toMap() {
    return {
      kUnit: unit
          ?.name, // Assuming unit has a 'name' field for string representation
      kType: type
          ?.name, // Assuming type has a 'name' field for string representation
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

  static List<DiagramModel> fromFirebaseList(List<dynamic>? diagramsList) {
    if (diagramsList == null) return [];
    return diagramsList
        .map(
          (e) => DiagramModel.fromFirebase(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }
}

List<DiagramModel> allDiagrams = [
  DiagramModel(
    unit: UnitType.micro,
    type: DiagramType.perfectCompetition,
    subtype: DiagramSubtype.longRunEquilibrium,
  ),
  DiagramModel(
    unit: UnitType.macro,
    type: DiagramType.circularFlowOfIncome,
    subtype: DiagramSubtype.closed,
  ),
];
