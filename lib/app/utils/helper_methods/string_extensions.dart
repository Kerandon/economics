extension CapitalizeFirstLetterExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringToListOfWords on String {
  List<String> toListOfWords() {
    return split(RegExp(r'\s+'));
  }
}

extension BracketExtractExtension on String {
  String? extractStringInsideBrackets() {
    RegExp regExp = RegExp(r'\((.*?)\)');
    RegExpMatch? match = regExp.firstMatch(this);
    if (match != null) {
      return match.group(1);
    }
    return null; // Return null if no match found
  }
}

extension StringListExtensions on List<String> {
  bool hasDuplicates() {
    final seenStrings = <String>{}; // Set to track unique strings

    for (var str in this) {
      if (seenStrings.contains(str)) {
        return true; // Duplicate found
      }
      seenStrings.add(str); // Add string to the set if it's unique so far
    }
    return false; // No duplicates
  }
}
