import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get demandSlides => [
  /// Demand
  Slide(
    section: Subunit.demand,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Market',
        'Where buyers and sellers meet to exchange goods, services or resources.',
      ),

      SlideContent.term(
        'Demand',
        'The quantities of a good or service a consumer is willing and able to buy at different prices, ceteris paribus.',
      ),

      SlideContent.term(
        'The Law of Demand',
        'There is a negative relationship between price and quantity demanded, ceteris paribus.',
      ),

      SlideContent.term(
        'Derived Demand',
        'Demand for a good, service, or resource that comes from the demand for a related good or resource.',
      ),

      SlideContent.term(
        'Market Demand',
        'The total quantity demanded by all consumers in a market at various prices over a period, ceteris paribus.',
      ),

      SlideContent.term(
        'Change in Quantity Demanded',
        'A price change causes movement along the demand curve. A fall in price causes <strong>extension</strong> in demand, and a rise in price causes <strong>contraction</strong> in demand.',
      ),

      SlideContent.term(
        'Increase or Decrease in Demand',
        'A change in a non-price factor shifts the entire demand curve, changing demand at all prices.',
      ),

      SlideContent.term(
        'Normal Good',
        'Demand rises when consumers’ income increases.',
      ),

      SlideContent.term(
        'Inferior Good',
        'Demand rises when consumers’ income falls (e.g., public transport, second-hand clothes).',
      ),

      SlideContent.term(
        'Substitute Good',
        'An alternative good satisfying a similar need. When the price of one increases, demand for the substitute increases (e.g., Cola and Pepsi).',
      ),

      SlideContent.term(
        'Complement Good',
        'A good consumed with another. When the price of one increases, demand for the other decreases (e.g., cars and petrol).',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'The Law of Diminishing Marginal Utility',
        'As consumption increases, marginal utility decreases with each additional unit, ceteris paribus.',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Substitution Effect',
        'A fall in the price of a good makes it relatively cheaper compared to substitutes, causing consumers to switch to it and increase quantity demanded.',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Income Effect',
        'A fall in the price of a good increases consumers’ purchasing power, allowing them to buy more of the good.',
      ),

      // SlideContent.term(
      //   'Conspicuous Consumption',
      //   'refers to individuals who make purchases of luxury to display their wealth or status rather than for their practical utility.',
      // ),
      //
      // SlideContent.term(
      //   'Veblen Good',
      //   'is a type of luxury good which is used to show wealth or status. It shows a positive relationship between price and quantity demanded, making it an exception to the law of demand',
      // ),
      //
      // SlideContent.term(
      //   tag: Tag.supplement,
      //   'Giffen Good',
      //   'is a staple good that make up a large proportion of consumers’ expenditure. When its price rises, consumers buy more of the good, creating a positive relationship between price and quantity demanded, making it an exception to the law of demand. The increase in demand occurs because the income effect of the higher price outweighs the substitution effect.',
      // ),
    ],
  ),
  Slide(
    title: 'Changes In Demand',
    section: Subunit.demand,
    contents: [
      SlideContent.text(
        'An <strong>extension in demand (L)</strong> or <strong>contraction in demand (R)</strong> is '
            'a movement along the demand curve caused by a change in the <strong>price</strong> of a good (or a shift'
            ' of the supply curve).',
      ),
      SlideContent(
        diagramBundleEnums: [
          DiagramBundleEnum.microDemandExtension,
          DiagramBundleEnum.microDemandContraction,

        ],
      ),
      SlideContent.text('An <strong>increase (L)</strong> or <strong>decrease in demand (R)</strong> is caused by <strong>non-price determinants</strong>'),
      SlideContent.key('Non-Price Determinants of Demand', '''
<ul>
<li>Consumer Income</li>
<li>Tastes and preferences</li>
<li>Future price expectations</li>
<li>Price of related goods (substitutes and complements)</li>
<li>Number of consumers</li>
</ul>
'''),
      SlideContent(
        diagramBundleEnums: [
          DiagramBundleEnum.microDemandIncrease,
          DiagramBundleEnum.microDemandDecrease,
        ],
      ),

    ],
  ),
  Slide(
    section: Subunit.demand,
    title: 'Reasons For Downward Sloping Demand',
    hl: true,
    contents: [
      SlideContent.key('Reasons For Downward Sloping Demand Curve', '''
<ul>
<li>Income effect</li>
<li>Substitution effect</li>
<li>The Law of Diminishing Marginal Utility</li>
</ul>
''', tag: Tag.hl), // 🔧 placeholder for now
    ],
  ),
];
