import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get publicGoodsSlides => [
  Slide(
    section: Subunit.marketFailurePublicGoods,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Public goods',
        'Non-rivalrous and non-excludable; consumption by one does not reduce availability for others.',
      ),
      SlideContent.term(
        'Free-rider problem',
        'When consumers benefit from a good without paying for it.',
      ),
      SlideContent.term(
        'Cost-benefit analysis',
        'Systematic evaluation of the benefits and costs of a project.',
      ),
      SlideContent.term(
        'Contracting out',
        'When the government hires private firms to provide goods or services on its behalf.',
      ),
    ],
  ),
];
