import 'package:economics_app/home_page/models/custom_slide.dart';
import 'package:economics_app/home_page/models/key_content.dart';

import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/enums/unit_type.dart';
import '../models/custom_slide_content.dart';
import '../models/custom_term.dart';

List<CustomSlide> get slides => [
  CustomSlide(
    section: Subunit.demand,
    title: 'Definition & The Law Of Demand',
    contents: [
      CustomSlideContent(
        term: CustomTerm(
          term: 'Demand',
          explanation:
              'is the willingness and ability of consumers to buy a good or service at different prices.',
        ),
      ),
      CustomSlideContent(
        content:
            'The demand curve is drawn as downward sloping. This '
            'represents a negative relationship between the price of a goods and its demand. '
            'If the price of a good falls, the quantity demanded will increase and vice versa',
      ),
      CustomSlideContent(
        term: CustomTerm(
          term: 'The Law of Demand',
          explanation:
              'states that as the price of a good decreases,'
              ' the quantity demanded by consumers increases, and vice versa.',
        ),
      ),
      CustomSlideContent(
        diagramBundleEnums: [DiagramBundleEnum.microDemandPriceChange],
      ),
    ],
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Non-Price Determinants of Demand',
    contents: [
      CustomSlideContent(
        content: '''
        <p>There are different factors (determinants) which can increase or decrease demand (shift demand). This means even at the same market price consumers demand more or less of the good. </p>
        

        ''',
        keyContent: KeyContent(
          title: 'Non-Price Determinants of Demand',
          content: '''
        <ul>
  <li>Consumer Income</li>
  <li>Tastes and preferences</li>
  <li>Future price expectations</li>
  <li>Price of related goods (substitutes and complements)</li>
  <li>Number of consumers</li>
</ul>
''',
        ),
      ),
      CustomSlideContent(
        term: CustomTerm(
          term: 'Substitute Good',
          explanation: '''
        Two goods which satisfy a similar need for a consumer (e.g. Coca-Cola & Pepsi).
        If the price of a substitute increases, the demand for a good increases.
        ''',
        ),
      ),
      CustomSlideContent(
        term: CustomTerm(
          term: 'Complement Good',
          explanation: '''
        A goods which is typically used with another good (e.g. A computer and keyboard).
        If the price of a complement increases, the demand for a good decreases.
        ''',
        ),
      ),
      CustomSlideContent(
        diagramBundleEnums: [DiagramBundleEnum.microDemandDeterminants],
      ),
    ],
  ),
  CustomSlide(
    section: Subunit.demand,
    title: 'Reasons For Downward Sloping Demand',
    hl: true,
    contents: [
      CustomSlideContent(
        content: '''
        <ul>
  <li><strong>Income effect:</strong> As the price of a good falls, consumers can afford to buy more with the same income, increasing demand.</li>
  <li><strong>Substitution effect:</strong> When the price of a good falls, it becomes relatively cheaper compared to substitutes, so consumers switch towards it.</li>
  <li><strong>Diminishing marginal utility:</strong> Each additional unit consumed gives less satisfaction, so consumers are only willing to buy more at lower prices.</li>
</ul>

        
        ''',
        keyContent: KeyContent(
          hl: true,
          title: 'Reasons For Downward Sloping Demand Curve',
          content: '''
      <ul>
        <li>Income effect</li>
        <li>Substitution effect</li>
        <li>Diminishing marginal utility</li>
      </ul>
    ''',
        ),
      ),
    ],
  ),
];
