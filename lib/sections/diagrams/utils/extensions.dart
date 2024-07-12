import 'package:flutter/material.dart';

import 'mixins.dart';

extension CustomPainterExtension on CustomPainter {
  String get name {
    if (this is NameMixin) {
      return (this as NameMixin).name;
    }
    return "";
  }
}

extension CustomStringExtension on String {
  String getFirstWord() {
    if (isEmpty) return this;

    for (int i = 0; i < length; i++) {
      if (this[i].toUpperCase() == this[i]) {
        return substring(0, i);
      }
    }

    return this;
  }

  String getWordsBetweenFirstAndSecondUnderscores() {
    List<String> parts = split('_');

    if (parts.length < 3) {
      // Return an empty string if there are not enough parts
      return '';
    }

    List<String> words = parts[1].split(RegExp(r'(?=[A-Z])'));

    // Join the words with spaces
    return words.join(' ');
  }

  String getWordsAfterSecondUnderscore() {
    List<String> parts = split('_');

    if (parts.length < 3) {
      // Return an empty string if there are not enough parts
      return '';
    }

    List<String> words = parts[2].split(RegExp(r'(?=[A-Z])'));

    // Join the words with spaces
    return words.join(' ');
  }
  String getWordsAfterThirdUnderscore() {
    List<String> parts = split('_');

    if (parts.length < 4) {
      // Return an empty string if there are not enough parts
      return '';
    }

    List<String> words = parts[3].split(RegExp(r'(?=[A-Z])'));

    // Join the words with spaces
    return words.join(' ');
  }
}
