import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/quizzes/methods/sort_units_by_index.dart';
import 'package:equatable/equatable.dart';
import '../../enums/course_enum.dart';

class CourseModel with EquatableMixin {
  final CourseEnum? course;

  final List<UnitModel> units;

  CourseModel({required this.course, required this.units});

  factory CourseModel.fromMap(Map<String, dynamic> map) {

      if (map.isEmpty) {
        throw Exception('The provided map is empty');
      }

      final courseKey = map.entries.first.key;
      final unitMap = map.entries.first.value;

      if (courseKey.isEmpty) {
        throw Exception('Course key is empty');
      }
      final course =
      CourseEnumExtension.fromText(courseKey);


      // Validate the unit map
      if (unitMap == null || unitMap is! Map<String, dynamic>) {
        throw Exception('Invalid unit map structure');
      }

      // Parse the units
      List<UnitModel> units = unitMap.entries.map((entry) {
        try {

          return UnitModel.fromMap(entry.key, entry.value);
        } catch (e) {
          throw Exception('Failed to parse unit: ${entry.key}, error: $e');
        }
      }).toList();

      // Sort units by index
      sortUnitsByIndex(units);

      return CourseModel(course: course, units: units);

  }

  // copyWith method
  CourseModel copyWith({CourseEnum? course, List<UnitModel>? units}) {
    return CourseModel(
      course: course ?? this.course,
      units: units ?? this.units,
    );
  }

  @override
  List<Object?> get props => [course];
}
