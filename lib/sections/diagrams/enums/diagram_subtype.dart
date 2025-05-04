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
  longRunEquilibrium,
  abnormalProfit,
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
      case DiagramSubtype.abnormalProfit:
        return 'Abnormal Profit';
      case DiagramSubtype.longRunEquilibrium:
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
    }
  }
}
