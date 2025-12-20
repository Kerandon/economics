import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get inabilityAchieveEquitySlides => [
  Slide(
    subunit: Subunit.marketEquity,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Income',
        'Factor incomes earned, such as wages, rent, dividends, and interest.',
      ),
      SlideContent.term(
        'Wealth',
        'The total value of assets owned minus total liabilities owed.',
      ),
    ],
  ),
];
