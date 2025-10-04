import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get supplySlides => [
  /// Terms
  Slide(
    section: Subunit.supply,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        tag: Tag.hl,
        'Supply',
        'is the various quantities of a good or service a firm is willing and able to sell at different prices, during a particular time period, ceteris paribus.',
      ),

      SlideContent.term(
        'The Law of Supply',
        'states that there is a positive relationship between the price of a good and its quantity supplied, ceteris paribus.',
      ),
      SlideContent.term(
        'Change In Quantity Supplied',
        'is when a change in the price of a good or service leads to a movement up or down the supply curve. An increase in price results in an <strong>extension</strong> in supply, while a fall in price leads to a <strong>contraction</strong> in supply.',
      ),
      SlideContent.term(
        'Increase Or Decrease In Supply',
        'is when a non-price determinant of supply changes the supply of a good or service at every price. This is shown by a shift of the entire supply curve.',
      ),
      SlideContent.term(
        'Market Supply',
        'is the total (aggregate) quantity of a good or service supplied by all producers in a market at different prices, over a specific period of time, ceteris paribus.',
      ),
      SlideContent.term(
        'Costs of production',
        'are the expenses a firm incurs in the process of producing goods or services. They include all payments for resources as well as opportunity costs of using those resources.',
      ),
      SlideContent.term(
        'Supply Shock',
        'is an unexpected event that significantly increase or decrease supply. Typical examples include political instability, natural disasters or technological breakthroughs',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Marginal Product',
        'is the additional output that results from employing one more input, ceteris paribus. <strong>MP = ∆Total Product ÷ ∆Input</strong>',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Marginal Cost',
        'is the change in cost incurred when producing one more unit of a good, ceteris paribus. <strong>MC = ∆Total Cost ÷ ∆Quantity</strong>',
      ),
    ],
  ),

  /// Supply
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
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange),
      // 🔧 placeholder
    ],
  ),
];
