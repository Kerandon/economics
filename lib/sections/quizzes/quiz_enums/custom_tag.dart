enum CustomTag {
  term,
  general,
  calculation,
  shortAnswer,
  longAnswer,
  iGWorkbookQuestion,
  iGCoursebookQuestion,
  iGPastPaperQuestion,
  hl
}

extension CustomTagFirebaseExtension on List<CustomTag> {

  List<String> toFirebase() {
    return map((tag) => tag.name).toList();
  }

  static CustomTag fromFirebase(String value) {
    return CustomTag.values.firstWhere(
      (tag) => tag.name == value,
      orElse: () => throw ArgumentError('Invalid value for CustomTag: $value'),
    );
  }

  static List<CustomTag>? fromFirebaseList(List<dynamic>? data) {
    if (data != null) {
      return data
          .map((e) => CustomTagFirebaseExtension.fromFirebase(e.toString()))
          .toList();
    }
    return null;
  }
}

extension CustomTagExtension on CustomTag {
  /// Converts a CustomTag to a user-friendly text representation.
  String toText() {
    switch (this) {
      case CustomTag.term:
        return "Term";
      case CustomTag.general:
        return "General";
      case CustomTag.calculation:
        return "Calculation";
      case CustomTag.shortAnswer:
        return "Short Answer";
      case CustomTag.longAnswer:
        return "Long Answer";
      case CustomTag.iGWorkbookQuestion:
        return "IG Workbook Question";
      case CustomTag.iGCoursebookQuestion:
        return "IG Coursebook Question";
      case CustomTag.iGPastPaperQuestion:
        return "IG Past Paper Question";
      case CustomTag.hl:
        return "HL";
    }
  }
}
