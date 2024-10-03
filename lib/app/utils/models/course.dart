import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:economics_app/app/utils/models/unit.dart';

import '../mixins/course_mixin.dart';

class Course with CourseMixin {
  Course({required this.name, required this.units});

  @override
  final String name;

  @override
  final List<UnitMixin> units;

  factory Course.fromMap(Map<String, dynamic> map) {
    final courseName = map.entries.first.key;

    final data = map.entries.first.value as Map<String, dynamic>;
    List<UnitMixin> u = [];
    for (var d in data.entries) {
      u.add(Unit(id: d.key, name: d.value['name'], subunits: []));
    }

    return Course(name: courseName, units: u);
  }
}
