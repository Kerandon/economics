
import 'package:flutter/material.dart';

import '../mixins/unit_mixin.dart';

class Unit with UnitMixin {
  @override
  final String? id;

  @override
  final String name;

  @override
  final int? numberOfQuestions;

  @override
  final List<Unit> subunits;

  Unit({
    this.id,
    required this.name,
    this.numberOfQuestions,
    this.subunits = const [],
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> sub = {};
    for (var s in subunits) {
      sub.addAll({
        s.id.toString(): {'name': s.name}
      });
    }

    final Map<String, dynamic> map = {
      id ?? "No id found": {
        'name': name,
        'subunits': sub,
      }
    };

    // Remove null key-value pairs
    map.removeWhere((key, value) => value == null);

    return map;
  }

  // Factory constructor to parse subunits from map
  factory Unit.fromMap(String id, Map<String, dynamic> map) {
    List<Unit> subunits = [];
    if (map.containsKey('subunits')) {
      Map<String, dynamic> subunitMap = map['subunits'];
      subunits = subunitMap.entries
          .map((entry) => Unit.fromMap(entry.key, entry.value))
          .toList();
    }


    return Unit(
      id: id,
      name: map['name'] ?? 'Unknown',
      subunits: subunits,
    );
  }

  static List<Unit> fromAddCourseMap(Map<int, Map<String, dynamic>> newMap) {
    List<Unit> units = [];

    for (var e in newMap.entries) {
      var unitName = e.value['controller'].text;
      Map<int, dynamic> subunits = e.value['subunits'];

      List<Unit> subs = [];
      for (var s in subunits.entries) {
        final c = s.value as TextEditingController;
        subs.add(Unit(name: c.text, id: s.key.toString()));
      }

      units.add(Unit(
        name: unitName,
        id: e.key.toString(),
        subunits: subs,
      ));
    }

    return units;
  }

}
