import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/quizzes/methods/sort_units_by_index.dart';
import 'package:equatable/equatable.dart';
import '../../enums/course_enum.dart';

class CourseModel with EquatableMixin {
  final CourseEnum? course;

  final List<UnitModel> units;

  CourseModel({required this.course, required this.units});

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    try {
      // Check if the map is empty
      if (map.isEmpty) {
        throw Exception('The provided map is empty');
      }

      // Extract the course key and value
      final courseKey = map.entries.first.key;
      final unitMap = map.entries.first.value;

      // Validate the course key
      if (courseKey.isEmpty) {
        throw Exception('Course key is empty');
      }

      // Parse the course
      final course = CourseEnumExtension.fromFirebase(courseKey);

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
    } catch (e) {
      // Rethrow the exception with additional context
      throw Exception('Failed to create CourseModel from map: $e');
    }
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
