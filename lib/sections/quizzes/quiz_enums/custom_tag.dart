enum CustomTag {
  iGWorkbookQuestion,
  iGCoursebookQuestion,
  iGPastPaperQuestion,
}

extension CustomTagFirebaseExtension on List<CustomTag> {
  List<String> toFirebase() {
    return map((tag) => tag.name).toList();
  }

  // Match a string value to the corresponding CustomTag enum
  static CustomTag fromFirebase(String value) {
    return CustomTag.values.firstWhere(
      (tag) => tag.name == value,
      orElse: () => throw ArgumentError('Invalid value for CustomTag: $value'),
    );
  }

  // Convert a List<String> to a List<CustomTag>
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
  String toText() {
    switch (this) {
      case CustomTag.iGWorkbookQuestion:
        return "IG Workbook Question";
      case CustomTag.iGCoursebookQuestion:
        return "IG Coursebook Question";
      case CustomTag.iGPastPaperQuestion:
        return "IG Past Paper Question";
    }
  }
}
