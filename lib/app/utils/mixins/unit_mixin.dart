import 'package:economics_app/app/enums/ib_section.dart';
import 'package:economics_app/app/enums/ig_units.dart';

import '../../enums/course.dart';

mixin UnitMixin {
  String? get id;

  String get name;

  List<UnitMixin> get subunits;

  int? get numberOfQuestions;
}

extension GetUnit on UnitMixin {
  static UnitMixin? fromText(String text, SelectedCourse course) {
    if (course == SelectedCourse.ib) {
      return IBSection.values.firstWhere((section) => section.name == text,
          orElse: () => IBSection.all);
    } else if (course == SelectedCourse.ib) {
      return IGSection.values.firstWhere((section) => section.name == text,
          orElse: () => IGSection.all);
    }
    return null;
  }
}
