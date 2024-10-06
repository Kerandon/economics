// import '../mixins/unit_mixin.dart';
//
// class Unit with UnitMixin {
//   @override
//   final String? id;
//
//   @override
//   final String name;
//
//   @override
//   final int? numberOfQuestions;
//
//   @override
//   final List<Unit> subunits;
//
//   Unit({
//     this.id,
//     required this.name,
//     this.numberOfQuestions,
//     this.subunits = const [],
//   });
//
//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> sub = {};
//     for (var s in subunits) {
//       sub.addAll({
//         s.id.toString(): {'name': s.name}
//       });
//     }
//
//     final Map<String, dynamic> map = {
//       id ?? "No id": {
//         'name': name,
//         'subunits': sub,
//       }
//     };
//
//     // Remove null key-value pairs
//     map.removeWhere((key, value) => value == null);
//
//     return map;
//   }
//
//   factory Unit.fromMap(Map<String, dynamic> json) {
//     return Unit(name: 'name');
//   }
// }

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
}
