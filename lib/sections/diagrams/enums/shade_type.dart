import 'package:flutter/material.dart';

enum ShadeType {
  consumerSurplus,
  producerSurplus,
  welfareLoss,
  abnormalProfit,
  loss
}
extension Shade on ShadeType {
  Color setShadeColor() {
    switch (this) {
      case ShadeType.consumerSurplus:
        return Colors.green;
      case ShadeType.producerSurplus:
        return Colors.blue;
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
    final red = (color.r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final green = (color.g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blue = (color.b * 255).toInt().toRadixString(16).padLeft(2, '0');
    final alpha = (color.a * 255).toInt().toRadixString(16).padLeft(2, '0');

    return withAlpha
        ? '#$alpha$red$green$blue'.toUpperCase()
        : '#$red$green$blue'.toUpperCase();
  }

}
