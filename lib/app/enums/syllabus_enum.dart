import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

enum Syllabus {
  ib,
  igcse,
}

extension SyllabusEnumExtension on Syllabus {
  String toText() {
    switch (this) {
      case Syllabus.ib:
        return 'IB';
      case Syllabus.igcse:
        return 'IGCSE';
    }
  }
  static Syllabus? fromText(String? text) {
    switch (text?.trim().toUpperCase()) {
      case 'IB' || 'IBDP':
        return Syllabus.ib;
      case 'IG' || 'IGCSE':
        return Syllabus.igcse;
      default:
        return null; // or throw an error if preferred
    }
  }

  static Syllabus? fromFirebase(Map<String, dynamic>? map) {
    final key = QuestionKey.syllabus.name;
    if (map == null) {
      throw Exception('map null');
    }
    if (!map.containsKey(key)) {
      throw Exception('no syllabus key');
    }

    final value = map[key];

    if (value is! String) {
      throw Exception(
          'Invalid syllabus type: Expected a string but got ${value.runtimeType}');
    }

    try {
      return Syllabus.values.firstWhere(
        (e) =>
            e.toText().toLowerCase().split(' ').first ==
            map[key].toLowerCase().split(' ').first,
        orElse: () => throw Exception('Unknown syllabus: ${map[key]}'),
      );
    } catch (e) {
      throw Exception('Unknown syllabus: $value');
    }
  }
}
