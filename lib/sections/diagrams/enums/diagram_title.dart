enum DiagramTitle {
  keynesianModel,
  monetaristNewClassicalModel,
  srasIncreaseDecrease,
}

extension ToTitle on DiagramTitle {
  String title() {
    switch (this) {
      case DiagramTitle.keynesianModel:
        return 'Keynesian Model';
      case DiagramTitle.monetaristNewClassicalModel:
        return 'Monetarist/New Classical Model';
      case DiagramTitle.srasIncreaseDecrease:
        return 'SRAS Increase/Decrease';
    }
  }
}

