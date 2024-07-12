import 'package:flutter/material.dart';

enum ShadeType { consumerSurplus, producerSurplus, welfareLoss, abnormalProfits, losses}

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
      case ShadeType.losses:
        return Colors.red;
    }
  }
}
