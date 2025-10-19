import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get asymmetricInfoSlides => [
  Slide(
    section: Subunit.marketFailureAsymmetric,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Adverse selection',
        'When one party has more information than the other in a transaction and exploits it.',
      ),
      SlideContent.term(
        'Asymmetric information',
        'When buyers and sellers do not have access to the same information.',
      ),
      SlideContent.term(
        'Screening',
        'When buyers reduce asymmetric information by gathering information, e.g., researching options.',
      ),
      SlideContent.term(
        'Signaling',
        'When firms reduce asymmetric information by showing quality, e.g., warranties or testimonials.',
      ),
      SlideContent.term(
        'Moral hazard',
        'When a party takes more risk because they do not bear the full negative consequences.',
      ),
    ],
  ),
];
