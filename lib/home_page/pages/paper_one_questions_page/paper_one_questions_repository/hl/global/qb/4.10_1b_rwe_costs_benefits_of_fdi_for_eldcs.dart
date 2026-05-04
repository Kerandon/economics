import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final rweDiscussCostsAndBenefitsOfFDIForELDCs1bHL = Slide(
  subunit: Subunit.aDAS,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the benefits and costs of inward foreign direct investment (FDI) for economically less developed countries. ',
  contents: [
    SlideContent.econTerms([]),

    SlideContent.diagrams([
      DiagramEnum.macroAggregateDemandInflationTradeOff,
      DiagramEnum.macroADASKeynesianSpareCapacity,
    ]),
    SlideContent.diagrams([
      DiagramEnum.macroClassicalInflationaryGapAdjustment,
    ]),
  ],
);
