import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';



List<Slide> get supplySlides => [
  /// Supply
  Slide(
    section: Subunit.supply,
    title: 'Definition',
    contents: [
      SlideContent.termWithContentAndDiagram(
        'Supply',
        'is the willingness and ability of a firm to sell a good or service at different prices',
        'Supply is drawn with an upward sloping curve, representing a positive relationship between the price of a good and the quantity supplied.',
        DiagramBundleEnum.microSupplyPriceChanges,
      ),
    ],
  ),

  Slide(
    section: Subunit.supply,
    title: 'Non-Price Determinants of Supply',
    contents: [
      SlideContent.key('Non-Price Determinants of Supply', '''
        <ul>
          <li>Changes in costs of factors of production (FOPs)</li>
          <li>Prices of related goods (joint and competitive supply)</li>
          <li>Indirect taxes and subsidies</li>
          <li>Future price expectations</li>
          <li>Changes in technology</li>
          <li>Number of firms</li>
        </ul>
        '''),
      SlideContent.term('Joint Supply', '''
        When the production of one good supports the production of another good. 
        E.g., producing beef also produces leather.
        '''),
      SlideContent.term('Competitive Supply', '''
        When producers can use the same resources to produce different goods, so making more of one means making less of the other. 
        E.g., A farmer can use land to grow either wheat or corn.
        '''),
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange),
      // 🔧 placeholder
    ],
  ),
];

