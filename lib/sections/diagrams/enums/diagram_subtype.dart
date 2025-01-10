enum DiagramSubtype {
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
