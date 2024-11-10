import 'package:economics_app/app/utils/models/unit.dart';
import 'package:economics_app/sections/quizzes/methods/sort_units_by_index.dart';
import 'package:equatable/equatable.dart';

import '../mixins/course_mixin.dart';
import '../mixins/unit_mixin.dart';

class Course with CourseMixin, EquatableMixin {
  @override
  final String name;

  @override
  final List<UnitMixin> units;

  Course({required this.name, required this.units});

  // Factory constructor to parse Course from map
  factory Course.fromMap(Map<String, dynamic> map) {
    String courseName = map.entries.first.key;
    Map<String, dynamic> unitMap = map.entries.first.value;

    List<Unit> units = unitMap.entries
        .map((entry) => Unit.fromMap(entry.key, entry.value))
        .toList();

    /// Sort units so ascends by index
    sortUnitsByIndex(units);

    return Course(name: courseName, units: units);
  }

  // copyWith method
  Course copyWith({String? name, List<UnitMixin>? units}) {
    return Course(
      name: name ?? this.name,
      units: units ?? this.units,
    );
  }

  @override
  List<Object?> get props => [name];
}
