import 'package:flutter/material.dart';

enum ShadeType {
  consumerSurplus,
  originalConsumerSurplus,
  gainedConsumerSurplus,
  lostConsumerSurplus,
  producerSurplus,
  originalProducerSurplus,
  gainedProducerSurplus,
  lostProducerSurplus,
  surplus,
  shortage,
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
    const consumerSurplusColor = Colors.green;
    const producerSurplusColor = Colors.blue;
    const gainedColor = Colors.indigo;
    const lostColor = Colors.blueGrey;
    switch (this) {
      case ShadeType.consumerSurplus:
        return consumerSurplusColor;
      case ShadeType.producerSurplus:
        return producerSurplusColor;
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
        return Colors.deepPurple;
      case ShadeType.welfareLoss:
        return Colors.red;
      case ShadeType.abnormalProfit:
        return Colors.lightBlue;
      case ShadeType.loss:
        return Colors.red;
      case ShadeType.gainedConsumerSurplus:
        return gainedColor;
      case ShadeType.lostConsumerSurplus:
        return lostColor;
      case ShadeType.gainedProducerSurplus:
        return gainedColor;
      case ShadeType.lostProducerSurplus:
        return lostColor;
      case ShadeType.originalConsumerSurplus:
        return consumerSurplusColor;
      case ShadeType.originalProducerSurplus:
        return producerSurplusColor;
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
      case ShadeType.gainedConsumerSurplus:
        return 'Gained Consumer Surplus';
      case ShadeType.lostConsumerSurplus:
        return 'Lost Consumer Surplus';
      case ShadeType.gainedProducerSurplus:
        return 'Gained Producer Surplus';
      case ShadeType.lostProducerSurplus:
        return 'Lost Producer Surplus';
      case ShadeType.originalConsumerSurplus:
        return 'Original Consumer Surplus';
      case ShadeType.originalProducerSurplus:
        return 'Original Producer Surplus';
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
