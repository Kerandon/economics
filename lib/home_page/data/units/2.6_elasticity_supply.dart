import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get elasticitySupplySlides => [
  Slide(
    section: Subunit.elasticityDemand,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Price inelastic supply (PES < 1)',
        'is when the quantity supplied of a good is relatively unresponsive to a change in its price.',
      ),
      SlideContent.term(
        'Price elastic supply (PES > 1)',
        'is when the quantity supplied of a good is relatively responsive to a change in its price.',
      ),
      SlideContent.term(
        'Unitary price elasticity of supply (PES = 1)',
        'is when the percentage change in quantity supplied is equal to the percentage change in price.',
      ),
      SlideContent.term(
        'Perfectly price inelastic supply (PES = 0)',
        'is when a change in the price of a good has no impact on its quantity supplied.',
      ),
      SlideContent.term(
        'Perfectly price elastic supply (PES = ∞)',
        'is when a firm can essentially supply an infinite quantity of a good at a given price.',
      ),
    ],
  ),
];
