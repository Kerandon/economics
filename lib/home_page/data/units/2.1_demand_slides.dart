import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get demandSlides => [
  /// Demand
  Slide(
    subunit: Subunit.demand,
    title: kTermsGlossary,
    contents: [
      SlideContent.diagrams([DiagramEnum.microDemandApples]),

      SlideContent.term(
        'Change in Quantity Demanded',
        'A movement along the demand curve. A fall in price causes an <strong>extension</strong>, a rise in price causes a <strong>contraction</strong>.',
      ),
      SlideContent.term(
        'Complement Good',
        'A good consumed with another. When the price of one increases, demand for the other decreases (e.g., cars and petrol).',
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
        'Increase or Decrease in Demand',
        'A change in a non-price factor shifts the entire demand curve, changing demand at all prices.',
      ),
      SlideContent.term(
        'Income Effect',
        'A fall in the price of a good increases consumers’ purchasing power, allowing them to buy more of the good, ceteris paribus.',
      ),
      SlideContent.term(
        'Inferior Good',
        'Demand rises when consumers’ income falls (e.g., public transport, second-hand clothes).',
      ),
      SlideContent.term(
        'Market',
        'Where buyers and sellers meet to exchange goods, services, or resources.',
      ),
      SlideContent.term(
        'Market Demand',
        'The total quantity demanded by all consumers in a market at various prices over a period, ceteris paribus.',
      ),

      SlideContent.term(
        'Normal Good',
        'Demand rises when consumers’ income increases.',
      ),
      SlideContent.term(
        'Substitute Good',
        'An alternative good satisfying a similar need. When the price of one increases, demand for the substitute increases (e.g., Cola and Pepsi).',
      ),
      SlideContent.term(
        'Substitution Effect',
        'A fall in the price of a good makes it relatively cheaper compared to substitutes, causing consumers to switch to it and increase quantity demanded.',
      ),
      SlideContent.term(
        'The Law of Demand',
        'There is a negative relationship between price and quantity demanded, ceteris paribus.',
      ),

      SlideContent.term(
        'Utility',
        'The benefit or satisfaction derived from consuming a good.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Marginal Utility',
        'The extra utility (benefit) when one more unit of a good is consumed (<strong>MU = ∆TU ÷ ∆Q</strong>).',
      ),
      SlideContent.term(
        'The Law of Diminishing Marginal Utility',
        'The additional benefit (utility) from consuming extra units of a good eventually decreases, ceteris paribus.',
        tag: Tag.hl,
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Giffen Good',
        'A staple good that make up a large proportion of consumers’ expenditure. When its price rises, consumers buy more of the good (exception to the law of demand).',
      ),
      SlideContent.term(
        tag: Tag.supplement,
        'Conspicuous Consumption',
        'Consumption of luxury goods to display their wealth or status rather than for their practical utility.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Veblen Good',
        'A type of luxury good which is used to show wealth or status. Quantity demanded increases when price rises (exception to the law of demand).',
      ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.lawOfDemand,
    contents: [
      SlideContent.text('''
        There is a negative relationship between the price of a good and the quantity that consumers demand. 
        This is known as
        <strong>The Law of Demand</strong>.
'''),
      SlideContent.customWidget(
        SimpleTable(
          title: 'Quantity of Apples',
          headers: ['Price (\$)', 'Quantity Demanded'],
          data: [
            ['0', '10'],
            ['1', '8'],
            ['2', '6'],
            ['3', '4'],
            ['4', '2'],
            ['5', '0'],
          ],
        ),
      ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.demandCurve,
    contents: [
      SlideContent.diagrams([DiagramEnum.microDemandApples]),
      SlideContent.text('Demand curve'),
    ],
  ),
  Slide(syllabusPoint: SyllabusPoint.individualVsMarketDemand, contents: []),
  Slide(syllabusPoint: SyllabusPoint.nonPriceDeterminants, contents: []),
  Slide(syllabusPoint: SyllabusPoint.movementsAndShiftsOfDemand, contents: []),
  Slide(
    syllabusPoint: SyllabusPoint.assumptionsLawOfDemand,
    contents: [SlideContent.text('')],
  ),
];
