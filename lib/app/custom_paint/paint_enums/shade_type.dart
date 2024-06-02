import 'package:flutter/material.dart';

enum ShadeType { consumerSurplus, producerSurplus, welfareLoss }

Color setShadeColor(ShadeType shade) {
  switch (shade) {
    case ShadeType.consumerSurplus:
      return Colors.green;
    case ShadeType.producerSurplus:
      return Colors.blue;
    case ShadeType.welfareLoss:
      return Colors.orange;
  }
}
