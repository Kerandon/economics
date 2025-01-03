enum FlipCardTag {
  calculations,
  definitions,
  general,
  structured,
  short,
}

extension FlipCardTagExtension on FlipCardTag {
  static FlipCardTag? fromFirebase(String? value) {
    if (value != null) {
      return FlipCardTag.values.firstWhere(
        (e) => e.name == value,
        orElse: () => FlipCardTag.general,
      );
    }
    return null;
  }

  String toText() {
    switch (this) {
      case FlipCardTag.calculations:
        return "Calculations";
      case FlipCardTag.definitions:
        return "Definitions";
      case FlipCardTag.general:
        return "General";
      case FlipCardTag.structured:
        return "Structured Answer";
      case FlipCardTag.short:
        return "Short Answer";
    }
  }
}
