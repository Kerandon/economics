import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:flutter/material.dart';

enum DiagramSubtype {
  outputPoints,
  opportunityCost,
  increasingOpportunityCost,
  constantOpportunityCost,
  increaseInPotentialOutput,
  decreaseInPotentialOutput,
  growth,
  equilibrium,
  increaseInDemand,
  decreaseInDemand,
  increaseInSupply,
  decreaseInSupply,
  shortage,
  surplus,
  negativeProduction,
  negativeConsumption,
  positiveProduction,
  positiveConsumption,
  commonPoolResources,
  perfectCompetitionNormalProfit,
  perfectCompetitionAbnormalProfit,
  perfectCompetitionLoss,
  monopolyAbnormalProfit,
  monopolyNormalProfit,
  monopolyLoss,
  socialWelfare,
  closed,
  open,
  macro,
  fullEmployment,
  shortRun,
  standard,
  exporter,
  importer,
}

extension DiagramSubtypeExtension on DiagramSubtype {
  String toText() {
    switch (this) {
      case DiagramSubtype.outputPoints:
        return 'Output points';
      case DiagramSubtype.opportunityCost:
        return 'Opportunity cost';
      case DiagramSubtype.increasingOpportunityCost:
        return 'Increasing opportunity cost';
      case DiagramSubtype.constantOpportunityCost:
        return 'Constant opportunity cost';
      case DiagramSubtype.increaseInPotentialOutput:
        return 'Increase in potential output';
      case DiagramSubtype.decreaseInPotentialOutput:
        return 'Decrease in potential output';
      case DiagramSubtype.growth:
        return 'Actual vs. potential growth';
      case DiagramSubtype.equilibrium:
        return 'Equilibrium';
      case DiagramSubtype.increaseInDemand:
        return 'Increase in demand';
      case DiagramSubtype.decreaseInDemand:
        return 'Decrease in demand';
      case DiagramSubtype.increaseInSupply:
        return 'Increase in supply';
      case DiagramSubtype.decreaseInSupply:
        return 'Decrease in supply';
      case DiagramSubtype.shortage:
        return 'Shortage';
      case DiagramSubtype.surplus:
        return 'Surplus';
      case DiagramSubtype.commonPoolResources:
        return 'Common Pool Resources';
      case DiagramSubtype.perfectCompetitionAbnormalProfit:
        return 'Abnormal Profit';
      case DiagramSubtype.perfectCompetitionNormalProfit:
        return 'Long-Run Equilibrium';
      case DiagramSubtype.closed:
        return 'Closed-model';
      case DiagramSubtype.open:
        return 'Open-model';
      case DiagramSubtype.macro:
        return 'Macro';
      case DiagramSubtype.fullEmployment:
        return 'Full employment';
      case DiagramSubtype.shortRun:
        return 'Short-run';
      case DiagramSubtype.standard:
        return 'Standard';
      case DiagramSubtype.exporter:
        return 'Exporter';
      case DiagramSubtype.importer:
        return 'Importer';
      case DiagramSubtype.negativeProduction:
        return 'Negative production externality';
      case DiagramSubtype.negativeConsumption:
        return 'Negative consumption externality';
      case DiagramSubtype.positiveProduction:
        return 'Positive production externality';
      case DiagramSubtype.positiveConsumption:
        return 'Positive consumption externality';

      case DiagramSubtype.socialWelfare:
        return 'Social welfare';
      case DiagramSubtype.perfectCompetitionLoss:
        return 'Loss';
      case DiagramSubtype.monopolyAbnormalProfit:
        return 'Abnormal profit';
      case DiagramSubtype.monopolyNormalProfit:
        return 'Normal profit';
      case DiagramSubtype.monopolyLoss:
        return 'Loss';
    }
  }

  String description() {
    switch (this) {
      case DiagramSubtype.outputPoints:
        return 'Output points';
      case DiagramSubtype.opportunityCost:
        return 'Opportunity cost';
      case DiagramSubtype.increasingOpportunityCost:
        return 'Increasing opportunity cost';
      case DiagramSubtype.constantOpportunityCost:
        return 'Constant opportunity cost';
      case DiagramSubtype.increaseInPotentialOutput:
        return 'Increase in potential output';
      case DiagramSubtype.decreaseInPotentialOutput:
        return 'Decrease in potential output';
      case DiagramSubtype.growth:
        return 'Actual vs. potential growth';
      case DiagramSubtype.equilibrium:
        return 'Equilibrium';
      case DiagramSubtype.increaseInDemand:
        return 'Increase in demand';
      case DiagramSubtype.decreaseInDemand:
        return 'Decrease in demand';
      case DiagramSubtype.increaseInSupply:
        return 'Increase in supply';
      case DiagramSubtype.decreaseInSupply:
        return 'Decrease in supply';
      case DiagramSubtype.shortage:
        return 'Shortage';
      case DiagramSubtype.surplus:
        return 'Surplus';
      case DiagramSubtype.commonPoolResources:
        return 'Common Pool Resources';
      case DiagramSubtype.perfectCompetitionAbnormalProfit:
        return '';
      case DiagramSubtype.perfectCompetitionLoss:
        return "";
      case DiagramSubtype.perfectCompetitionNormalProfit:
        return 'AR = AC (normal profit). P = MC (allocatively efficient). AC = MC (productively efficient).';
      case DiagramSubtype.closed:
        return 'Closed-model';
      case DiagramSubtype.open:
        return 'Open-model';
      case DiagramSubtype.macro:
        return 'Macro';
      case DiagramSubtype.fullEmployment:
        return 'Full employment';
      case DiagramSubtype.shortRun:
        return 'Short-run';
      case DiagramSubtype.standard:
        return 'Standard';
      case DiagramSubtype.exporter:
        return 'Exporter';
      case DiagramSubtype.importer:
        return 'Importer';
      case DiagramSubtype.negativeProduction:
        return createColorKey([KeyEntry(shadeType: ShadeType.welfareLoss),]);
      case DiagramSubtype.negativeConsumption:
        return createColorKey([KeyEntry(shadeType: ShadeType.welfareLoss),]);
      case DiagramSubtype.positiveProduction:
        return createColorKey([KeyEntry(shadeType: ShadeType.welfareLoss),]);
      case DiagramSubtype.positiveConsumption:
        return createColorKey([KeyEntry(shadeType: ShadeType.welfareLoss),]);
      case DiagramSubtype.socialWelfare:
        return 'Social welfare';
      case DiagramSubtype.monopolyAbnormalProfit:
        return 'Abnormal profit';
      case DiagramSubtype.monopolyNormalProfit:
        return 'Normal profit';
      case DiagramSubtype.monopolyLoss:
        return 'loss';

    }
  }
}


class KeyEntry {
  final ShadeType? shadeType;
  final Color? customColor;
  final String? _label;

  KeyEntry({
    this.shadeType,
    this.customColor,
    String? label,
  })  : _label = label,
        assert(
        (shadeType != null) ^ (customColor != null),
        'Exactly one of shadeType or customColor must be provided.',
        );

  Color get color => customColor ?? shadeType!.setShadeColor();

  String get label {
    if (_label != null) return _label!;
    if (shadeType != null) return shadeType!.defaultLabel;
    throw ArgumentError('Label must be provided if no shadeType is set.');
  }
}
String createColorKey(List<KeyEntry> entries) {
  final buffer = StringBuffer();
  buffer.writeln('<table>');

  for (var entry in entries) {
    final color = entry.color;
    final hexColor = color.red.toRadixString(16).padLeft(2, '0') +
        color.green.toRadixString(16).padLeft(2, '0') +
        color.blue.toRadixString(16).padLeft(2, '0') +
        color.alpha.toRadixString(16).padLeft(2, '0');

    buffer.writeln('''
      <tr>
        <td style="width:12px;height:12px;background-color:#$hexColor;"></td>
        <td style="padding-left:6px;">${entry.label}</td>
      </tr>
    ''');
  }

  buffer.writeln('</table>');
  return buffer.toString();
}
