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
