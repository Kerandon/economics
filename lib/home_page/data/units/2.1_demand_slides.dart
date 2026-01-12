import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../custom_widgets/definitions_grid.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get demandSlides => [
  /// Demand
  Slide(
    syllabusPoint: SyllabusPoint.lawOfDemand,
    contents: [
      SlideContent.text('''
       <p><strong>The Law of Demand</strong> states that there is a negative (inverse) relationship between the price of a good and the quantity that consumers demand. </p> 
<p>As the demand schedule below shows, as price increases, <strong>quantity demanded</strong> falls.</p>
'''),

      SlideContent.evaluation(title: 'Demand Evaluation',
          leftTitle: 'leftTitle', rightTitle: 'rightTitle', leftItems: ['leftItems', 'left items2'], rightItems: ['A','B']),
      SlideContent.simpleTable(
        title: 'Individual Demand for Apples',
        headers: ['Price (\$)', 'Quantity Demanded by Sarah'],
        data: [
          ['0', '10'],
          ['1', '8'],
          ['2', '6'],
          ['3', '4'],
          ['4', '2'],
          ['5', '0'],
        ],
      ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.demandCurve,
    contents: [
      SlideContent.text('''
      The demand schedule for a good can be plotted - showing a downward sloping <strong>demand curve</strong>
      '''),
      SlideContent.diagrams([DiagramEnum.microDemandApples]),
    ],
  ),

  Slide(
    syllabusPoint: SyllabusPoint.individualVsMarketDemand,
    contents: [
      SlideContent.text('''
  <p><strong>Market demand</strong> is the sum of quantity demanded by individual consumers at different prices</p>
  '''),
      SlideContent.simpleTable(
          title: 'Market Demand For Apples',
          headers: ['Price (\$)', 'Sarah', 'Mike', 'Market Demand'],
          data: [
            ['0', '10', '13', '23'],
            ['1', '8', '12', '20'],
            ['2', '6', '10', '16'],
            ['3', '4', '9', '14'],
            ['4', '2', '7', '9'],
            ['5', '0', '3', '3'],
          ],
        ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.nonPriceDeterminants,
    contents: [
      SlideContent.text('''
      <p>The following factors shift the entire demand curve left or right.</p>
      <ul>
      <li>Income</li>
      <li>Tastes and preferences</li>
      <li>Future price expectations</li>
      <li>Price of related goods (substitutes and complements)</li>
      <li>Number of consumers</li>
      </ul>
      '''),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.movementsAndShiftsOfDemand,
    contents: [
      SlideContent.text('''
    <P>An <strong>extension in demand</strong> is a movement downwards along the demand curve.
    A lower price leads to an increase in quantity demanded. 
    </P>
        <P>A <strong>contraction in demand</strong> is a movement upwards along the demand curve.
    A higher price leads to an increase in quantity demanded. 
    </P>
    <p>A shift in supply will also cause a change in <strong>quantity demanded</strong></p>
    '''),
      SlideContent.diagrams([
        DiagramEnum.microDemandExtension,
        DiagramEnum.microDemandContraction,
        DiagramEnum.microDemandQuantityChangeDueToSupply,
      ]),
      SlideContent.text('''
        <p>Non-price determinants of demand lead to a shifts in the demand curve.</p>
    <P>An <strong>increase in demand</strong> is shown by a right-ward shift of the entire demand curve.
    </P>
    <P>An <strong>decrease in demand</strong> is shown by a left-ward shift of the entire demand curve.
    </P>

    '''),
      SlideContent.diagrams([
        DiagramEnum.microDemandIncrease,
        DiagramEnum.microDemandDecrease,
      ]),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.assumptionsLawOfDemand,
    contents: [
      SlideContent.text('''
    <ul>
    <li>
    The law of diminishing marginal utility
    </li>
    <li>
    The income effect
    </li><li>
    The substitution effect</li>
    </ul>
    '''),
    ],
  ),
  ...demandTerms,
];

List<Slide> get demandTerms => [
  Slide(
    subunit: Subunit.demand,
    title: kTermsGlossary,
    contents: [
      SlideContent.glossary(

        [
            SlideContent.term(
              'Change in Quantity Demanded',
              'A movement along the demand curve. A fall in price causes an <strong>extension</strong>, a rise in price causes a <strong>contraction</strong>.',
            ),
            SlideContent.term(
              'Complement Good',
              'A good consumed with another. When the price of one increases, demand for the other decreases (e.g., cars and petrol).',
            ),
            SlideContent.term(
              'Conspicuous Consumption',
              'Consumption of luxury goods to display their wealth or status rather than for their practical utility.',
              tag: Tag.supplement,
            ),
            SlideContent.term(
              'Demand',
              'The quantities of a good or service a consumer is willing and able to buy at different prices, ceteris paribus.',
            ),
            SlideContent.term(
              'Demand Curve',
              'Plots the relationship between the price of a good and the quantity demanded, showing a negative (inverse) relationship, ceteris paribus.',
            ),
            SlideContent.term(
              'Derived Demand',
              'Demand for a good, service, or resource that comes from the demand for a related good or resource.',
            ),
            SlideContent.term(
              'Giffen Good',
              'A staple good that make up a large proportion of consumers’ expenditure. When its price rises, consumers buy more of the good.',
              tag: Tag.supplement,
            ),
            SlideContent.term(
              'Income Effect',
              'A fall in the price of a good increases consumers’ purchasing power, allowing them to buy more of the good.',
            ),
            SlideContent.term(
              'Increase or Decrease in Demand',
              'A change in a non-price factor shifts the entire demand curve, changing demand at all prices.',
            ),
            SlideContent.term(
              'Inferior Good',
              'Demand rises when consumers’ income falls (e.g., public transport).',
            ),
            SlideContent.term(
              'Marginal Utility',
              'The extra utility (benefit) when one more unit of a good is consumed (MU = ∆TU ÷ ∆Q).',
              tag: Tag.hl,
            ),
            SlideContent.term(
              'Market',
              'Where buyers and sellers meet to exchange goods, services, or resources.',
            ),
            SlideContent.term(
              'Market Demand',
              'The total quantity demanded by all consumers in a market.',
            ),
            SlideContent.term(
              'Normal Good',
              'Demand rises when consumers’ income increases.',
            ),
            SlideContent.term(
              'Substitute Good',
              'An alternative good satisfying a similar need. When the price of one increases, demand for the substitute increases.',
            ),
            SlideContent.term(
              'Substitution Effect',
              'A fall in the price of a good makes it relatively cheaper compared to substitutes.',
            ),
            SlideContent.term(
              'The Law of Demand',
              'There is a negative relationship between price and quantity demanded, ceteris paribus.',
            ),
            SlideContent.term(
              'The Law of Diminishing Marginal Utility',
              'The additional benefit from consuming extra units of a good eventually decreases.',
              tag: Tag.hl,
            ),
            SlideContent.term(
              'Utility',
              'The benefit or satisfaction derived from consuming a good.',
            ),
            SlideContent.term(
              'Veblen Good',
              'A type of luxury good used to show wealth. Quantity demanded increases when price rises.',
              tag: Tag.supplement,
            ),
          ],
        ),
    ],
  ),
];
