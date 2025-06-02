import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';
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

  static List<SyllabusModel>? fromFirebase(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    final key = QuestionKey.syllabus.name;
    if (!map.containsKey(key)) {
      return null;
    } else {
      final data = map[key];
      final s = SyllabusEnumExtension.fromText(data);
      return [if (s != null) SyllabusModel(syllabus: s, units: [])];
    }
  }

  @override
  List<Object?> get props => [syllabus];
}
