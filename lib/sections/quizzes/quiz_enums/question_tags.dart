enum FlipCardTag {
  calculations,
  definitions,
  general,
  structured,
  short,
}

extension FlipCardTagExtension on FlipCardTag {
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
