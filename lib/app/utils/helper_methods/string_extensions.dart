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
