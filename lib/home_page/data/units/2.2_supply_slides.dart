import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get supplySlides => [
  /// Terms
  Slide(
    subunit: Subunit.supply,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Change in Quantity Supplied',
        'A movement along the supply curve. Higher prices cause an <strong>extension</strong>, lower prices a <strong>contraction</strong>.',
      ),
      SlideContent.term(
        'Costs of Production',
        'The costs a firm incurs when producing a good or service.',
      ),
      SlideContent.term(
        'Increase or Decrease in Supply',
        'A shift of the supply curve caused by a change in a non-price determinant of supply.',
      ),

      SlideContent.term(
        'Market Supply',
        'The total quantity supplied by all firms in a market at various prices, ceteris paribus.',
      ),

      SlideContent.term(
        'Supply',
        'The quantities of a good a firm is willing and able to produce at various prices, ceteris paribus.',
      ),
      SlideContent.term(
        'Supply Curve',
        'Plots the relationship between the price of a good and the quantity supplied, showing a positive (direct) relationship, ceteris paribus.',
      ),
      SlideContent.term(
        'Supply Shock',
        'An unexpected event that suddenly raises or reduces supply, e.g., natural disasters or technological changes.',
      ),
      SlideContent.term(
        'The Law of Supply',
        'As the price of a good increases, its quantity supplied increases, ceteris paribus.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Average Product',
        'Total output produced by a firm divided by the quantity of input used. <strong>AP = TP ÷ Input</strong>.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'The Law of Diminishing Marginal Returns',
        'In the short-run, as additional units of a variable factor are added to fixed factors, marginal product eventually decreases, ceteris paribus.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Long-run',
        'A time period where all factors of production (inputs) are variable.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Marginal Cost',
        'The extra cost of producing one more unit of output. <strong>MC = ∆TC ÷ ∆Q</strong>.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Marginal Product',
        'The extra output produced by employing one more unit of an input. <strong>MP = ∆TP ÷ ∆Input</strong>.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Short-run',
        'A time period where at least one factor of production (input) is fixed (e.g., capital), with one or more variable factors (e.g., labor).',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Total Product',
        'Total output produced by a firm.',
      ),
    ],
  ),

  /// Supply
  Slide(
    subunit: Subunit.supply,
    title: 'Changes in Supply',
    contents: [
      SlideContent.text(
        'An <strong>extension in supply (R)</strong> or <strong>contraction in supply (L)</strong> '
        'is a movement along the supply curve caused by a change in the <strong>price</strong> of the good '
        '(or due to a shift in the demand curve).',
      ),

      SlideContent(
        diagramEnums: [
          DiagramEnum.microSupplyContraction,
          DiagramEnum.microSupplyExtension,
        ],
      ),
      SlideContent.text(
        'An <strong>increase in supply (L)</strong> or a <strong>decrease in supply (R) </strong> is caused by <strong>non-price</strong> determinants.',
      ),
      SlideContent.key('Non-Price Determinants of Supply', '''
        <ul>
          <li>Changes in costs of factors of production (e.g., wages, raw materials, capital, energy, transport)</li>
          <li>Prices of related goods (joint and competitive supply)</li>
          <li>Indirect taxes and subsidies</li>
          <li>Future price expectations</li>
          <li>Changes in technology</li>
          <li>Number of firms</li>
        </ul>
        '''),
      SlideContent(
        diagramEnums: [
          DiagramEnum.microSupplyIncrease,
          DiagramEnum.microSupplyDecrease,
        ],
      ),
    ],
  ),
  Slide(
    subunit: Subunit.supply,
    title: 'Assumptions underlying the law of supply',
    hl: true,
    contents: [
      SlideContent.text(
        'Marginal Product (MP) is the additional output produced by one more unit of a variable input, ceteris paribus. '
        'It is calculated as: MP = ∆Total Output ÷ ∆Labor.',
      ),
      SlideContent.text(
        'When labor increases from 2 to 3, output rises from 7 to 10. '
        'MP = 10 - 7 = 3 units.',
      ),
      SlideContent.customWidget(
        SimpleTable(
          headers: ['Labor', 'Output', 'Marginal Product (MP)'],
          data: [
            ['1', '3', '3'], // 3 - 0 = 3
            ['2', '7', '4'], // 7 - 3 = 4
            ['3', '10', '3'], // 10 - 7 = 3
            ['4', '12', '2'], // 12 - 10 = 2
            ['5', '13', '1'], // 13 - 12 = 1
            ['6', '12', '-1'], // 12 - 13 = -1
          ],
        ),
      ),

      SlideContent.text(
        '<strong>The Law of Diminishing Marginal Returns</strong> '
        'states that the extra output must eventually fall. '
        'In the table, diminishing returns sets in when the third unit of labor is hired. '
        'Diminishing returns is due to factors such as overcrowding, and full use of fixed resources (thus in the short-run only).',
      ),

      SlideContent(
        diagramEnums: [
          DiagramEnum.microMarginalProduct,
          DiagramEnum.microTotalAndMarginalProduct,
        ],
      ),
      SlideContent.text(
        'Marginal Cost is inversely related to Marginal Product.',
      ),
      SlideContent(
        diagramEnums: [
          DiagramEnum.microMarginalProduct,
          DiagramEnum.microMarginalCost,
        ],
      ),
      SlideContent.key('Reasons for the upwards sloping supply curve', '''
        <ul>
          <li>Firms are motivated to increase quantity supplied as prices rise to maximize profit
 </li>
          <li>Increasing marginal costs (The Law of Diminishing Marginal Returns)</li>
          <li>Rising opportunity costs of using resources which were used in other production</li>
        </ul>
        '''),
    ],
  ),
];
