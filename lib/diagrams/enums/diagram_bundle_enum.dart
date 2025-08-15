enum DiagramBundleEnum {
  microPPCConstantOppCost,
  microPPCIncreaseOppCost,
  microDemand,
  microDemandPriceChange,
  microDemandIndividualVsMarketDemand,
  microDemandDeterminants,
  microSupply,
  microSupplyDeterminants,
}

extension DiagramBundleExtension on DiagramBundleEnum {
  String get title {
    switch (this) {
      case DiagramBundleEnum.microPPCConstantOppCost:
        return 'Micro PPC Constant Opp Cost';
      case DiagramBundleEnum.microPPCIncreaseOppCost:
        return 'Micro PPC Constant Opp Cost';
      case DiagramBundleEnum.microDemand:
        return 'Micro PPC Constant Opp Cost';
      case DiagramBundleEnum.microDemandPriceChange:
        return 'Demand For Chocolate Bars (Per Week)';
      case DiagramBundleEnum.microDemandIndividualVsMarketDemand:
        return 'Individual Vs. Market Demand';
      case DiagramBundleEnum.microDemandDeterminants:
        return 'Micro PPC Constant Opp Cost';
      case DiagramBundleEnum.microSupply:
        return 'Micro PPC Constant Opp Cost';
      case DiagramBundleEnum.microSupplyDeterminants:
        return 'Micro PPC Constant Opp Cost';
    }
  }
}
