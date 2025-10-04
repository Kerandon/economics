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
        'Demand',
        'is the various quantities of a good or service that a consumer is willing and able to buy at different prices during a particular time period, ceteris paribus.',
      ),
      SlideContent.term(
        'The Law of Demand',
        'states that there is a negative relationship between the price of a good or service and the quantity demanded over a particular period of time, ceteris paribus.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Derived Demand',
        'is the demand for a good, service or resource that arises from the demand for a related good, service or resource.',
      ),
      SlideContent.term(
        'Market Demand',
        'is the total (aggregate) quantity of a good or service demanded by all consumers in a market at various prices, over a specific period of time, ceteris paribus.',
      ),
      SlideContent.term(
        'Change in Quantity Demanded',
        'is when a change in the price of the good or service leads to a movement along the demand curve. A fall in price leads to an <strong>extension</strong> in demand, while a rise in price leads to a <strong>contraction</strong> in demand.',
      ),
      SlideContent.term(
        'Increase Or Decrease In Demand',
        'is when a non-price determinant of demand changes the demand for a good or service at every price. This is shown by a shift in the entire demand curve.',
      ),
      SlideContent.term(
        'Market Demand',
        'is the total (aggregate) quantity of a good or service demanded by all consumers in a market at various prices, over a specific period of time, ceteris paribus.',
      ),
      SlideContent.term(
        'Normal Good',
        'is a good for which demand increases when consumers’ real income rises.',
      ),
      SlideContent.term(
        'Inferior Good',
        'a is a good for which demand increases when consumers’ real income falls. Typical examples include public transportation or second-hand clothes.',
      ),
      SlideContent.term(
        'Substitute Good',
        'is an alternative good which satisfies a similar want or need. The price of the substitute and demand move in the same direction. For example, if the price of Cola increases, the demand for Pepsi increases',
      ),
      SlideContent.term(
        'Complement Good',
        'is a good which are consumed together. Price and demand move in opposite directions. For example, if the price of cars increase, the demand for gasoline falls.,',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'The Law of Diminishing Marginal Returns', 'states that as consumption of a good increases, the marginal utility (extra satisfaction) decreases with each additional unit consumed, ceteris paribus.',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Substitution effect',
        'occurs when a fall in the price of a good makes it relatively cheaper compared to substitutes, causing consumers to switch from other goods and increase quantity demanded.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Conspicuous Consumption',
        'refers to individuals who make purchases of luxury to display their wealth or status rather than for their practical utility.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Veblen Good',
        'is a type of luxury good which is used to show wealth or status. It shows a positive relationship between price and quantity demanded, making it an exception to the law of demand',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Giffen Good',
        'is a staple good that make up a large proportion of consumers’ expenditure. When its price rises, consumers buy more of the good, creating a positive relationship between price and quantity demanded making it an exception to the law of demand. The increase in demand is due to the income effect of the higher price outweighing the substitution effect.',),


],
  ),

  Slide(
    section: Subunit.demand,
    title: 'Non-Price Determinants of Demand',
    contents: [
      SlideContent.key('Non-Price Determinants of Demand', '''
<ul>
<li>Consumer Income</li>
<li>Tastes and preferences</li>
<li>Future price expectations</li>
<li>Price of related goods (substitutes and complements)</li>
<li>Number of consumers</li>
</ul>
'''),
      SlideContent.diagram(DiagramBundleEnum.microDemandDeterminants),
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
<li>Diminishing marginal utility</li>
</ul>
''', tag: Tag.hl),
      SlideContent.text('''
<ul>
<li><strong>Income effect:</strong> As the price of a good falls, consumers can afford to buy more with the same income, increasing demand.</li>
<li><strong>Substitution effect:</strong> When the price of a good falls, it becomes relatively cheaper compared to substitutes, so consumers switch towards it.</li>
<li><strong>Diminishing marginal utility:</strong> Each additional unit consumed gives less satisfaction, so consumers are only willing to buy more at lower prices.</li>
</ul>
'''),
      SlideContent.diagram(
        DiagramBundleEnum.microDemandPriceChange,
      ), // 🔧 placeholder for now
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
      SlideContent.diagram(
        DiagramBundleEnum.microDemandPriceChange,
      ), // 🔧 placeholder
    ],
  ),
];
