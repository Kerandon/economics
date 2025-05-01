enum DiagramSubtype {
  outputPoints,
  opportunityCost,
  increasingOpportunityCost,
  constantOpportunityCost,
  increaseInPotentialOutput,
  decreaseInPotentialOutput,
  equilibrium,
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
      case DiagramSubtype.equilibrium:
        return 'Equilibrium';
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
    }
  }
}
