enum DiagramSubtype {
  closed,
  longRunEquilibrium,
  commonPoolResources,
}

extension DiagramSubtypeExtension on DiagramSubtype {
  String toText() {
    switch (this) {
      case DiagramSubtype.closed:
        return 'Closed';
      case DiagramSubtype.longRunEquilibrium:
        return 'Long-Run Equilibrium';
      case DiagramSubtype.commonPoolResources:
        return 'Common Pool Resources';
    }
  }
}
