import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final supplySlide =   Slide(
  subunit: Subunit.supply,
  tags: [Tag.quickNotes],
  contents: [
    SlideContent.text('''
      <h3>Non-price determinants of supply</h3>
      <ul>
        <li><b>Change in costs of production</b> (resource prices)</li>
        <li><b>Technology & productivity</b></li>
        <li><b>Prices of related goods</b> (joint supply / competitive goods)</li>
        <li><b>Expectations of future prices</b></li>
        <li><b>Government intervention</b> (taxes / subsidies)</li>
        <li><b>Number of firms in the market</b></li>
        <li><b>Supply shocks (positive / negative)</b></li>
      </ul>
      '''),
    SlideContent.diagrams([
      DiagramEnum.microSupplyIncrease,
      DiagramEnum.microSupplyExtension,
    ],
        description: 'Non-price factors shift the supply curve. A movement along the supply-curve is caused by a change in price (or a shift in the demand curve).'
    ),

    SlideContent.text('''
      <h3>Reasons for upward-sloping supply curve</h3>
      <ul>
        <li><b>Profit-maximizing</b> Firms are incentivized to increase quantity supplied as higher prices to maximize profits.</li>
        <li><b>The Law of Diminishing Marginal Returns</b> When quantity supply increases, marginal costs rise, so firms need a higher price to cover increasing additional costs.</li>
      </ul>
      '''),
    SlideContent.diagrams(
        description:   '<b>Marginal cost</b> is the inverse (mirror) of <b>marginal product.</b> due to the law of diminishing marginal returns as Marginal Product (MP) begins to fall (workers become less productive), the Marginal Cost (MC) of producing each additional unit must begin to rise.',
        [
      DiagramEnum.microMarginalProduct,
      DiagramEnum.microMarginalCost,
    ]),
    SlideContent.econTerms([
      EconTerm.supply,
      EconTerm.marketSupply,
      EconTerm.competitiveSupply,
      EconTerm.jointSupply,
      EconTerm.marginalProduct,
      EconTerm.marginalCost,
    ]),
  ],
);