import 'package:flutter/material.dart';

enum ShadeType {
  consumerSurplus,
  producerSurplus,
  surplus,
  shortage,
  consumerBurden,
  producerBurden,
  governmentBurden,
  governmentRevenue,
  welfareLoss,
  abnormalProfit,
  loss,
  lost,
  gained,
}

extension Shade on ShadeType {
  Color setShadeColor() {
    switch (this) {
      case ShadeType.consumerSurplus:
        return Colors.green;
      case ShadeType.producerSurplus:
        return Colors.blue;
      case ShadeType.surplus:
        return Colors.cyan; // 💡 Picked a distinct color for surplus
      case ShadeType.shortage:
        return Colors.deepOrange; // 💡 Picked a distinct color for shortage
      case ShadeType.consumerBurden:
        return Colors.yellow;
      case ShadeType.producerBurden:
        return Colors.purple;
      case ShadeType.governmentBurden:
        return Colors.grey;
      case ShadeType.governmentRevenue:
        return Colors.brown;
      case ShadeType.welfareLoss:
        return Colors.orange;
      case ShadeType.abnormalProfit:
        return Colors.lightBlue;
      case ShadeType.loss:
        return Colors.red;
      case ShadeType.lost:
        return Colors.blueGrey;
      case ShadeType.gained:
        return Colors.green;
    }
  }

  String get defaultLabel {
    switch (this) {
      case ShadeType.consumerSurplus:
        return 'Consumer Surplus';
      case ShadeType.producerSurplus:
        return 'Producer Surplus';
      case ShadeType.surplus:
        return 'Surplus';
      case ShadeType.shortage:
        return 'Shortage';
      case ShadeType.consumerBurden:
        return 'Consumer Burden';
      case ShadeType.producerBurden:
        return 'Producer Burden';
      case ShadeType.governmentBurden:
        return 'Government Burden';
      case ShadeType.governmentRevenue:
        return 'Government Revenue';
      case ShadeType.welfareLoss:
        return 'Welfare Loss';
      case ShadeType.abnormalProfit:
        return 'Abnormal Profits';
      case ShadeType.loss:
        return 'Loss';
      case ShadeType.lost:
        return 'Lost Surplus';
      case ShadeType.gained:
        return 'Gained Surplus';
    }
  }

  String toHexColorString({bool withAlpha = false}) {
    final color = setShadeColor();

    // Convert normalized values (0.0–1.0) to 0–255
    final red = (color.r * 255).round() & 0xff;
    final green = (color.g * 255).round() & 0xff;
    final blue = (color.b * 255).round() & 0xff;
    final alpha = (color.a * 255).round() & 0xff;

    final redHex = red.toRadixString(16).padLeft(2, '0');
    final greenHex = green.toRadixString(16).padLeft(2, '0');
    final blueHex = blue.toRadixString(16).padLeft(2, '0');
    final alphaHex = alpha.toRadixString(16).padLeft(2, '0');

    return withAlpha
        ? '#$alphaHex$redHex$greenHex$blueHex'.toUpperCase()
        : '#$redHex$greenHex$blueHex'.toUpperCase();
  }
}
