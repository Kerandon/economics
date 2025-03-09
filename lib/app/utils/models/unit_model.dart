import 'package:equatable/equatable.dart';

import '../../../sections/quizzes/quiz_enums/question_key.dart';

class UnitModel with EquatableMixin {
  final String? index;
  final String? name;
  final List<UnitModel> subunits;

  UnitModel({
    this.index,
    this.name,
    this.subunits = const [],
  });

  @override
  List<Object?> get props => [name];
}
extension UnitModelExtension on UnitModel {
  static List<UnitModel> fromFirebase(Map<String, dynamic>? map, {bool subunit = false}) {
    if (map == null) {
      return [];
    }

    final key = subunit ? QuestionKey.subunits.name : QuestionKey.units.name;
    final dynamic data = map[key];

    if (data == null) {
      return [];
    }
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) {
        if (e.isNotEmpty) {
          final index = e.keys.first;
          final name = e.values.first;
          return UnitModel(index: index, name: name);
        }
      })
          .whereType<UnitModel>()
          .toList();
    }

    return [];
  }
}

