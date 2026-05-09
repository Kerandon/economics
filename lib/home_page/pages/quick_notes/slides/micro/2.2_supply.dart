import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final supplySlide = Slide(
  subunit: Subunit.supply,
  tags: [Tag.quickNotes],
  contents: [
    SlideContent.text('''
      <h3>Non-price determinants of supply</h3>
      <ul>
        <li>Change in costs of production (resource prices)</li>
        <li>Technology & productivity</li>
        <li>Prices of related goods (joint supply / competitive goods)</li>
        <li>Expectations of future prices</li>
        <li>Government intervention(taxes / subsidies)</li>
        <li>Number of firms in the market</li>
        <li>Shocks (positive / negative)</li>
      </ul>
      '''),
    SlideContent.diagrams(
      [DiagramEnum.microSupplyIncrease, DiagramEnum.microSupplyExtension],
      description:
          'Non-price factors shift the supply curve. A movement along the supply-curve is a change in quantity supplied.',
    ),

    SlideContent.text('''
      <h3>Reasons for upward-sloping supply curve</h3>
      <ul>
        <li><b>Profit-maximizing</b> Firms are incentivized to increase quantity supplied as higher prices to maximize profits.</li>
        <li><b>The Law of Diminishing Marginal Returns</b> When quantity supply increases, marginal costs rise, so firms need a higher price to cover increasing additional costs.</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Marginal cost is the inverse of marginal product. Because of the law of diminishing marginal returns as Marginal Product (MP) begins to fall (workers become less productive), the Marginal Cost (MC) of producing each additional unit must begin to rise.',
      [DiagramEnum.microMarginalProduct, DiagramEnum.microMarginalCost],
    ),
    SlideContent.econTerms(
      EconTerm.values.where((term) => term.subunit == Subunit.supply).toList(),
    ),
  ],
);
