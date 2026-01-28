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
  consumerIncidence,
  producerIncidence,
  consumerGain,
  producerGain,
  governmentBurden,
  governmentRevenue,
  gainedRevenue,
  lostRevenue,
  costs,
  revenueUnchanged, // same color as governmentRevenue
  welfareLoss,
  abnormalProfit,
  loss,
  noChange, // 🆕 Added
}

extension Shade on ShadeType {
  Color setShadeColor() {
    const consumerSurplusColor = Colors.green;
    const producerSurplusColor = Colors.blue;
    const gainedColor = Colors.blue;
    const lostColor = Colors.red;
    const noChangeColor = Colors.grey;
    const consumerIncidenceColor = Colors.greenAccent;
    const producerIncidenceColor = Colors.blueAccent; // light grey

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
        return consumerIncidenceColor;
      case ShadeType.producerIncidence:
        return producerIncidenceColor;
      case ShadeType.governmentBurden:
        return Colors.grey;
      case ShadeType.governmentRevenue:
        return Colors.deepOrange;
      case ShadeType.gainedRevenue:
        return gainedColor;
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
        return Colors.grey.shade400;
      case ShadeType.consumerBurden:
        return consumerIncidenceColor;
      case ShadeType.producerBurden:
        return producerIncidenceColor;
      case ShadeType.consumerGain:
        return consumerIncidenceColor;
      case ShadeType.producerGain:
        return producerIncidenceColor;
      case ShadeType.costs:
        return Colors.red;
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
        return 'Lost Revenue';
      case ShadeType.revenueUnchanged:
        return 'Revenue Unchanged';
      case ShadeType.consumerBurden:
        return 'Consumer Burden';
      case ShadeType.producerBurden:
        return 'Producer Burden';

      case ShadeType.consumerGain:
        return 'Consumer Gain';
      case ShadeType.producerGain:
        return 'Producer Gain';
      case ShadeType.costs:
        return 'Costs';
    }
  }
}
