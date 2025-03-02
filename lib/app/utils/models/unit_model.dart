import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../sections/quizzes/methods/sort_units_by_index.dart';
import '../../../sections/quizzes/quiz_enums/question_key.dart';
import '../../configs/constants.dart';

class UnitModel with EquatableMixin {
  final String? index;

  final String? name;

  final List<UnitModel> subunits;

  UnitModel({
    this.index,
    this.name,
    this.subunits = const [],
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> sub = {};
    for (var s in subunits) {
      sub.addAll({
        s.index.toString(): {QuestionKey.name.name: s.name}
      });
    }

    final Map<String, dynamic> map = {
      index ?? "No index number found": {
        kIndex: index,
        QuestionKey.name.name: name,
        QuestionKey.subunits.name: sub,
      }
    };

    map.removeWhere((key, value) => value == null);

    return map;
  }

  // Factory constructor to parse subunits from map
  factory UnitModel.fromMap(String index, Map<String, dynamic> map) {
    List<UnitModel> subunits = [];
    if (map.containsKey(QuestionKey.subunits.name)) {
      Map<String, dynamic> subunitMap = map[QuestionKey.subunits.name];
      subunits = subunitMap.entries
          .map((entry) =>
              UnitModel.fromMap('$index.${entry.key.toString()}', entry.value))
          .toList();

      /// Sorts subunits by index so it is in ascending order
      sortUnitsByIndex(subunits);
    }

    return UnitModel(
      index: (double.parse(index) + 1).toString(),
      name: map['name'] ?? 'Unknown',
      subunits: subunits,
    );
  }

  static UnitModel? fromFirebase(Map<String, dynamic>? map,
      {bool subunit = false}) {
    if (map == null) {
      return null;
    }

    final key = subunit ? QuestionKey.subunit.name : QuestionKey.unit.name;
    if (!map.containsKey(key) || map[key] is! Map<String, dynamic>) {
      return null;
    }

    final u = map[key] as Map<String, dynamic>;
    if (u.isEmpty) {
      return null;
    }

    try {
      final entry = u.entries.first;
      return UnitModel(name: entry.value as String, index: entry.key);
    } catch (e) {
      return null;
    }
  }

  static List<UnitModel> fromAddCourseMap(
      Map<int, Map<String, dynamic>> newMap) {
    List<UnitModel> units = [];

    for (var e in newMap.entries) {
      var unitName = e.value['controller'].text;
      Map<int, dynamic> subunits = e.value['subunits'];

      List<UnitModel> subs = [];
      for (var s in subunits.entries) {
        final c = s.value as TextEditingController;
        subs.add(UnitModel(name: c.text, index: s.key.toString()));
      }

      units.add(UnitModel(
        name: unitName,
        index: e.key.toString(),
        subunits: subs,
      ));
    }

    return units;
  }

  @override
  List<Object?> get props => [name];
}
