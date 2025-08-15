enum DiagramTitle {
  microDemandPriceChange,
  keynesianModel,
  monetaristNewClassicalModel,
  srasIncreaseDecrease,
}

extension ToTitle on DiagramTitle {
  String title() {
    switch (this) {
      case DiagramTitle.microDemandPriceChange:
        return 'Micro Demand Price Change';
      case DiagramTitle.keynesianModel:
        return 'Keynesian Model';
      case DiagramTitle.monetaristNewClassicalModel:
        return 'Monetarist/New Classical Model';
      case DiagramTitle.srasIncreaseDecrease:
        return 'SRAS Increase/Decrease';
    }
  }
}
