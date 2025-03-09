import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

enum Syllabus {
  ib,
  igcse,
}

extension SyllabusEnumExtension on Syllabus {

  String toText() {
    switch (this) {
      case Syllabus.ib:
        return 'IB Economics';
      case Syllabus.igcse:
        return 'IGCSE';
    }
  }

  static Syllabus? fromFirebase(Map<String, dynamic>? map) {
    final key = QuestionKey.syllabus.name;
    if (map == null) {
      throw Exception('map null');
      return null;
    }
    if (!map.containsKey(key)) {
      throw Exception('no syllabus key');
      return null;
    }

    final value = map[key];

    if (value is! String) {
      throw Exception('Invalid syllabus type: Expected a string but got ${value.runtimeType}');
    }

    try {
      return Syllabus.values.firstWhere(
            (e) => e.toText().toLowerCase().split(' ').first == map[key].toLowerCase().split(' ').first,
        orElse: () => throw Exception('Unknown syllabus: ${map[key]}'),

      );
    } catch (e) {
      throw Exception('Unknown syllabus: $value');
    }
  }


}
