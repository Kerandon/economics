import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final demandSlide = Slide(
  subunit: Subunit.demand,
  tags: [Tag.quickNotes],
  contents: [
    SlideContent.text('''
      <h3>Non-price determinants of demand</h3>
      <ul>
        <li>Income (normal and inferior goods)</li>
        <li>Preferences and tastes</b></li>
        <li>Prices of related goods (substitutes and complements)</li>
        <li>Population and demographics</li>
        <li>Seasonal factors</li>
        <li>Expectations of future prices (demand increases if consumers expect prices to rise)</li>
        <li>Government policies (income taxes, regulations)</li>
      </ul>
      '''),
    SlideContent.text(
      '''
      <h3>Reasons For A Downward Sloping Demand Curve</h3>
      <ul>
        <li>The Law of Diminishing Marginal Utility</li>
        <li>Substitution effect</li>
        <li>The income effect</li>
      </ul>
      ''',
      tags: [Tag.hl],
    ),
    SlideContent.diagrams(
      description:
          'Non-price determinants increase or decrease demand. A movement along the demand curve is a change in <b>quantity demanded.</b>',
      [DiagramEnum.microDemandIncrease, DiagramEnum.microDemandExtension],
    ),
    SlideContent.econTerms(
      EconTerm.values.where((term) => term.subunit == Subunit.demand).toList(),
    ),
  ],
);
