import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final demandSlide =   Slide(
  subunit: Subunit.demand,
  tags: [Tag.quickNotes],
  contents: [
    SlideContent.text('''
      <h3>Non-price determinants of demand</h3>
      <ul>
        <li><b>Income</b> (normal and inferior goods)</li>
        <li><b>Preferences and tastes</b></li>
        <li><b>Prices of related goods</b> (substitutes and complements)</li>
        <li><b>Population and demographics</b></li>
        <li><b>Seasonal factors</b></li>
        <li><b>Expectations of future prices</b> (demand increases if consumers expect prices to rise)</li>
        <li><b>Government policies</b> (income taxes, regulations)</li>
      </ul>
      '''),
    SlideContent.text('''
      <h3>Reasons For A Downward Sloping Demand Curve</h3>
      <ul>
        <li><b>The Law of Diminishing Marginal Utility</b>.</li>
        <li><b>Substitution effect</b></li>
        <li><b>The income effect</b></li>
      </ul>
      ''',
      tags: [Tag.hl],
    ),
    SlideContent.text('content'),
    SlideContent.diagrams(
        description: 'Non-price determinants shift demand. A change in the price (or a shift in the supply-curve) leads to a change in <b>quantity demanded</b>.',
        [
          DiagramEnum.microDemandIncrease,
          DiagramEnum.microDemandExtension,
        ]),
    SlideContent(econTerms: [
      EconTerm.demand,
      EconTerm.marketDemand,
      EconTerm.normalGood,
      EconTerm.inferiorGood,
      EconTerm.marginalBenefit,
      EconTerm.marginalUtility,
      EconTerm.lawOfDiminishingMarginalUtility,
      EconTerm.substitutionEffect,
      EconTerm.incomeEffect,
    ]),
  ],
);