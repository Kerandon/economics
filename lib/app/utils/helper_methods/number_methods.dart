extension IntToAlphabet on int {
  static const int _asciiOffset = 64;

  String toAlphabet() {
    if (this >= 1 && this <= 26) {
      return String.fromCharCode(_asciiOffset + this);
    } else {
      return ''; // Return empty string if input is out of range
    }
  }
}

extension PercentageExtension on double {
  String toPercentageString() {
    // Multiply by 100 to convert to percentage and round to two decimal places
    final percentage = (this * 100).toStringAsFixed(2);

    // Check if the value is 100% or 0%
    if (percentage == "100.00" || percentage == "0.00") {
      return "${percentage.substring(0, percentage.indexOf('.'))}%";
    }

    // Remove trailing zeros and the decimal point if it's not needed
    return "${percentage.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}%";
  }
}
