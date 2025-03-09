import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:equatable/equatable.dart';
import '../../enums/syllabus_enum.dart';

class SyllabusModel with EquatableMixin {
  final Syllabus? syllabus;

  final List<UnitModel> units;

  SyllabusModel({required this.syllabus, required this.units});

  // copyWith method
  SyllabusModel copyWith({Syllabus? syllabus, List<UnitModel>? units}) {
    return SyllabusModel(
      syllabus: syllabus ?? this.syllabus,
      units: units ?? this.units,
    );
  }

  static SyllabusModel fromFirebase(Map<String, dynamic>? map){
    final s = SyllabusEnumExtension.fromFirebase(map);
    return allSyllabuses.firstWhere((e) => e.syllabus == s);
  }

  @override
  List<Object?> get props => [syllabus];
}
