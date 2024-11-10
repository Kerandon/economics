import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../sections/quizzes/methods/sort_units_by_index.dart';
import '../../configs/constants.dart';
import '../mixins/unit_mixin.dart';

class Unit with UnitMixin, EquatableMixin {
  @override
  final String? index;

  @override
  final String? name;

  @override
  final List<Unit> subunits;

  Unit({
    this.index,
    this.name,
    this.subunits = const [],
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> sub = {};
    for (var s in subunits) {
      sub.addAll({
        s.index.toString(): {kName: s.name}
      });
    }

    final Map<String, dynamic> map = {
      index ?? "No index number found": {
        kIndex: index,
        kName: name,
        kSubunits: sub,
      }
    };

    map.removeWhere((key, value) => value == null);

    return map;
  }

  // Factory constructor to parse subunits from map
  factory Unit.fromMap(String index, Map<String, dynamic> map) {
    List<Unit> subunits = [];
    if (map.containsKey(kSubunits)) {
      Map<String, dynamic> subunitMap = map[kSubunits];
      subunits = subunitMap.entries
          .map((entry) => Unit.fromMap(entry.key, entry.value))
          .toList();

      /// Sorts subunits by index so it is in ascending order
      sortUnitsByIndex(subunits);
    }

    return Unit(
      index: (int.parse(index) + 1).toString(),
      name: map['name'] ?? 'Unknown',
      subunits: subunits,
    );
  }

  factory Unit.fromFirebase(Map<String, dynamic> map, {bool subunit = false}) {
    final u = map[subunit ? kSubunit : 'unit'] as Map<String, dynamic>;
    try {
      final unit =
          Unit(name: u.entries.first.value, index: u.entries.first.key);
      return unit;
    } catch (e) {
      throw Exception('Unable to parse data from firebase $e');
    }
  }

  static List<Unit> fromAddCourseMap(Map<int, Map<String, dynamic>> newMap) {
    List<Unit> units = [];

    for (var e in newMap.entries) {
      var unitName = e.value['controller'].text;
      Map<int, dynamic> subunits = e.value['subunits'];

      List<Unit> subs = [];
      for (var s in subunits.entries) {
        final c = s.value as TextEditingController;
        subs.add(Unit(name: c.text, index: s.key.toString()));
      }

      units.add(Unit(
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
