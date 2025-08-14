

import 'diagram_type.dart';

enum DiagramBundleEnum {
  microPPCConstantOppCost,
  microPPCIncreaseOppCost,
  microDemand,
  microDemandDeterminants,
  microSupply,
  microSupplyDeterminants,
}

extension DiagramBundleExtension on DiagramBundleEnum {
  DiagramType getType() {
    switch (this) {
      case DiagramBundleEnum.microPPCConstantOppCost:
      case DiagramBundleEnum.microPPCIncreaseOppCost:
        return DiagramType.microPPC;

      case DiagramBundleEnum.microDemand:
      case DiagramBundleEnum.microDemandDeterminants:
        return DiagramType.microDemand;

      case DiagramBundleEnum.microSupply:
      case DiagramBundleEnum.microSupplyDeterminants:
        return DiagramType.microSupply;
    }
  }
}
