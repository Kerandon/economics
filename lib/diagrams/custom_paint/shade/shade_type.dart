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
  consumerIncidence,
  producerIncidence,
  governmentBurden,
  governmentRevenue,
  gainedRevenue,
  lostRevenue,
  revenueUnchanged,// same color as governmentRevenue
  welfareLoss,
  abnormalProfit,
  loss,
  noChange, // 🆕 Added
}

extension Shade on ShadeType {
  Color setShadeColor() {
    const consumerSurplusColor = Colors.green;
    const producerSurplusColor = Colors.blue;
    const gainedColor = Colors.indigo;
    const lostColor = Colors.blueGrey;
    const noChangeColor = Colors.grey; // light grey

    switch (this) {
      case ShadeType.consumerSurplus:
        return consumerSurplusColor;
      case ShadeType.producerSurplus:
        return producerSurplusColor;
      case ShadeType.surplus:
        return Colors.cyan;
      case ShadeType.shortage:
        return Colors.deepOrange;
      case ShadeType.consumerIncidence:
        return Colors.green;
      case ShadeType.producerIncidence:
        return Colors.blueAccent;
      case ShadeType.governmentBurden:
        return Colors.grey;
      case ShadeType.governmentRevenue:
        return Colors.deepOrange;
      case ShadeType.gainedRevenue:
        return consumerSurplusColor;
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
      case ShadeType.noChange: // 🆕 Light grey
        return noChangeColor;
      case ShadeType.lostRevenue:
return lostColor;
      case ShadeType.revenueUnchanged:
        return Colors.grey.shade100;
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
      case ShadeType.consumerIncidence:
        return 'Consumer Incidence';
      case ShadeType.producerIncidence:
        return 'Producer Incidence';
      case ShadeType.governmentBurden:
        return 'Government Burden';
      case ShadeType.governmentRevenue:
        return 'Government Revenue';
      case ShadeType.gainedRevenue:
        return 'Gained Revenue';
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
      case ShadeType.noChange: // 🆕 Label
        return 'No Change';
      case ShadeType.lostRevenue:
 return 'Revenue Loss';
      case ShadeType.revenueUnchanged:
        return 'Revenue';
    }
  }
}
