import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

enum CourseEnum {
  ib,
  igcse,
}

extension CourseEnumExtension on CourseEnum {

  String toText() {
    switch (this) {
      case CourseEnum.ib:
        return 'IB Economics';
      case CourseEnum.igcse:
        return 'IGCSE';
    }
  }

  static CourseEnum? fromFirebase(Map<String, dynamic>? map) {
    print('GET COURSE');
    final key = QuestionKey.course.name;
    if (map == null) {
      throw Exception('map null');
      return null;
    }
    if (!map.containsKey(key)) {
      throw Exception('no courses key');
      return null;
    }

    final value = map[key];

    if (value is! String) {
      throw Exception('Invalid course type: Expected a string but got ${value.runtimeType}');
    }

    try {
      return CourseEnum.values.firstWhere(
            (e) => e.toText().toLowerCase().split(' ').first == map[key].toLowerCase().split(' ').first,
        orElse: () => throw Exception('Unknown course: ${map[key]}'),

      );
    } catch (e) {
      throw Exception('Unknown course: $value');
    }
  }

  static CourseEnum fromText(String text){
    try {

      return CourseEnum.values.firstWhere(
            (e) => e.toText().toLowerCase().split(' ').first == text.toLowerCase().split(' ').first,
        orElse: () => throw Exception('Unknown course: $text'),

      );
    } catch (e) {
      throw Exception('Unknown course: $text');
    }

  }

}
