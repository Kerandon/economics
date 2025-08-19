import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';


List<Slide> get demandSlides => [


  /// Demand
  Slide(
    section: Subunit.demand,
    title: 'Definition & The Law Of Demand',
    contents: [
      SlideContent.termWithContentAndDiagram(
        'Demand',
        'is the willingness and ability of consumers to buy a good or service at different prices.',
        'The demand curve is drawn as downward sloping. This represents a negative relationship between the price of a good and its demand. If the price of a good falls, the quantity demanded will increase and vice versa.',
        DiagramBundleEnum.microDemandPriceChange,
      ),
      SlideContent.term(
        'The Law of Demand',
        'states that as the price of a good decreases, the quantity demanded by consumers increases, and vice versa.',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange),
    ],
  ),

  Slide(
    section: Subunit.demand,
    title: 'Non-Price Determinants of Demand',
    contents: [
      SlideContent.key(
        'Non-Price Determinants of Demand',
        '''
        <ul>
          <li>Consumer Income</li>
          <li>Tastes and preferences</li>
          <li>Future price expectations</li>
          <li>Price of related goods (substitutes and complements)</li>
          <li>Number of consumers</li>
        </ul>
        ''',
      ),
      SlideContent.term(
        'Substitute Good',
        '''
        Two goods which satisfy a similar need for a consumer (e.g. Coca-Cola & Pepsi).
        If the price of a substitute increases, the demand for a good increases.
        ''',
      ),
      SlideContent.term(
        'Complement Good',
        '''
        A good which is typically used with another good (e.g. A computer and keyboard).
        If the price of a complement increases, the demand for a good decreases.
        ''',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandDeterminants),
    ],
  ),

  Slide(
    section: Subunit.demand,
    title: 'Reasons For Downward Sloping Demand',
    hl: true,
    contents: [
      SlideContent.key(
        'Reasons For Downward Sloping Demand Curve',
        '''
        <ul>
          <li>Income effect</li>
          <li>Substitution effect</li>
          <li>Diminishing marginal utility</li>
        </ul>
        ''',
        hl: true,
      ),
      SlideContent.text(
        '''
        <ul>
          <li><strong>Income effect:</strong> As the price of a good falls, consumers can afford to buy more with the same income, increasing demand.</li>
          <li><strong>Substitution effect:</strong> When the price of a good falls, it becomes relatively cheaper compared to substitutes, so consumers switch towards it.</li>
          <li><strong>Diminishing marginal utility:</strong> Each additional unit consumed gives less satisfaction, so consumers are only willing to buy more at lower prices.</li>
        </ul>
        ''',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange), // 🔧 placeholder for now
    ],
  ),

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
      SlideContent.key(
        'Non-Price Determinants of Supply',
        '''
        <ul>
          <li>Changes in costs of factors of production (FOPs)</li>
          <li>Prices of related goods (joint and competitive supply)</li>
          <li>Indirect taxes and subsidies</li>
          <li>Future price expectations</li>
          <li>Changes in technology</li>
          <li>Number of firms</li>
        </ul>
        ''',
      ),
      SlideContent.term(
        'Joint Supply',
        '''
        When the production of one good supports the production of another good. 
        E.g., producing beef also produces leather.
        ''',
      ),
      SlideContent.term(
        'Competitive Supply',
        '''
        When producers can use the same resources to produce different goods, so making more of one means making less of the other. 
        E.g., A farmer can use land to grow either wheat or corn.
        ''',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange), // 🔧 placeholder
    ],
  ),
];
