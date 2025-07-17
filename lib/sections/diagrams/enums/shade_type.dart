import 'package:flutter/material.dart';
enum ShadeType {
  consumerSurplus,
  producerSurplus,
  consumerBurden,
  producerBurden,
  governmentBurden,
  governmentRevenue,
  welfareLoss,
  abnormalProfit,
  loss,
}

extension Shade on ShadeType {
  Color setShadeColor() {
    switch (this) {
      case ShadeType.consumerSurplus:
        return Colors.green;
      case ShadeType.producerSurplus:
        return Colors.blue;
      case ShadeType.consumerBurden:
        return Colors.yellow;
      case ShadeType.producerBurden:
        return Colors.purple;
      case ShadeType.governmentBurden:
        return Colors.grey; // 👈 Add your preferred color here
      case ShadeType.governmentRevenue:
        return Colors.brown;
      case ShadeType.welfareLoss:
        return Colors.orange;
      case ShadeType.abnormalProfit:
        return Colors.lightBlue;
      case ShadeType.loss:
        return Colors.red;
    }
  }

  String get defaultLabel {
    switch (this) {
      case ShadeType.consumerSurplus:
        return 'Consumer Surplus';
      case ShadeType.producerSurplus:
        return 'Producer Surplus';
      case ShadeType.consumerBurden:
        return 'Consumer Burden';
      case ShadeType.producerBurden:
        return 'Producer Burden';
      case ShadeType.governmentBurden:
        return 'Government Burden'; // 👈 Added label
      case ShadeType.governmentRevenue:
        return 'Government Revenue';
      case ShadeType.welfareLoss:
        return 'Welfare Loss';
      case ShadeType.abnormalProfit:
        return 'Abnormal Profits';
      case ShadeType.loss:
        return 'Loss';
    }
  }

  String toHexColorString({bool withAlpha = false}) {
    final color = setShadeColor();
    final red = color.red.toRadixString(16).padLeft(2, '0');
    final green = color.green.toRadixString(16).padLeft(2, '0');
    final blue = color.blue.toRadixString(16).padLeft(2, '0');
    final alpha = color.alpha.toRadixString(16).padLeft(2, '0');

    return withAlpha
        ? '#$alpha$red$green$blue'.toUpperCase()
        : '#$red$green$blue'.toUpperCase();
  }
}
