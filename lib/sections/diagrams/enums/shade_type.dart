import 'package:flutter/material.dart';

enum ShadeType {
  consumerSurplus,
  producerSurplus,
  welfareLoss,
  abnormalProfits,
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
      case ShadeType.abnormalProfits:
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
      case ShadeType.abnormalProfits:
        return 'Abnormal Profits';
      case ShadeType.loss:
        return 'Loss';
    }
  }

  String toHexColorString() {
    final color = setShadeColor();
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
