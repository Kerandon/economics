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

    // If no capital letter found, return the input
    return this;
  }

  String getFirstTwoWords() {
    RegExp regExp = RegExp(r'^[a-z]+|[A-Z][a-z]*');
    Iterable<Match> matches = regExp.allMatches(this);
    if (matches.isNotEmpty) {
      int count = 0;
      String result = '';
      for (Match match in matches) {
        if (count == 2) break;
        result += match.group(0)!;
        count++;
      }
      return result;
    }
    return '';
  }

  String removeLastWord() {
    if (isEmpty) return '';

    final lastCapitalIndex = lastIndexOf(RegExp(r'[A-Z]'));
    if (lastCapitalIndex == -1) return this;

    return substring(0, lastCapitalIndex).trim();
  }

  String extractMiddleWords() {
    // Regular expression to match camelCase words
    RegExp regExp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    // Split the camelCase string into individual words
    List<String> words = split(regExp);
    // If there are 2 or fewer words, return an empty string as there are no middle words
    if (words.length <= 2) {
      return '';
    }
    // Join the middle words with a space
    return words.sublist(1, words.length - 1).join(' ');
  }

  String getLastWord() {
    // Regular expression to match camelCase words
    RegExp regExp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    // Split the camelCase string into individual words
    List<String> words = split(regExp);
    // If there are no words, return an empty string
    if (words.isEmpty) {
      return '';
    }
    // Get the last word and capitalize it
    String lastWord = words.last;
    return lastWord[0].toUpperCase() + lastWord.substring(1);
  }
}
