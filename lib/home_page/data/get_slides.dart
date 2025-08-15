import 'package:economics_app/home_page/models/custom_slide.dart';

import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/enums/unit_type.dart';

List<CustomSlide> get slides => [
  CustomSlide(
    section: Subunit.demand,
    title: 'Definition & The Law of Demand',
    content: '''
      <strong>Demand</strong> is the <strong>willingness</strong> and <strong>ability</strong> of consumers to purchase a good or service at various prices during a given time period.
    <p>Demand has a downward sloping curve. This reflects a negative relationship between price 
    and the quantity demanded. As price decreases the quantity demanded increases, 
    and vice-versa.</p> 
    <p>For example, at a price of \$9 the consumer demands 8 chocolate bars per week.
    If the seller drops the price (and nothing else changes), the quantity demanded increases to 10 bars.
    This negative relationship between price and quantity demanded is known as <strong>The Law of Demand</strong>.
    ''',
    diagramBundleEnums: [DiagramBundleEnum.microDemandPriceChange],
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Individual vs. Market Demand',
    content: '''
      <ul>
        <li><strong>Individual demand</strong> refers to the quantity of a good a single consumer is willing and able to buy at different prices.</li>
        <li><strong>Market demand</strong> is the total quantity demanded by all consumers in the market at different prices.</li>
      </ul>
    ''',
    diagramBundleEnums: [DiagramBundleEnum.microDemandIndividualVsMarketDemand],
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Changes in Price and Quantity Demanded',
    content: '''
      <ul>
        <li>A change in price causes a <strong>movement along</strong> the demand curve, changing the quantity demanded.</li>
        <li>This is known as a <strong>change in quantity demanded</strong>.</li>
      </ul>
    ''',
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Non-Price Determinants of Demand',
    content: '''
      Factors that shift the demand curve include:
      <ul>
        <li><strong>Income</strong> (normal and inferior goods)</li>
        <li><strong>Prices of related goods</strong> (substitutes and complements)</li>
        <li><strong>Tastes and preferences</strong></li>
        <li><strong>Expectations</strong> of future prices or income</li>
        <li><strong>Demographic changes</strong></li>
      </ul>
    ''',
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Reasons for Downward Sloping Demand Curve (HL)',
    content: '''
      The demand curve slopes downwards due to:
      <ul>
        <li><strong>Substitution effect:</strong> consumers switch to cheaper alternatives when price rises.</li>
        <li><strong>Income effect:</strong> a rise in price reduces purchasing power.</li>
        <li><strong>Diminishing marginal utility:</strong> each additional unit consumed provides less satisfaction.</li>
      </ul>
    ''',
  ),
];
