import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get elasticitySupplySlides => [
  Slide(
    section: Subunit.elasticitySupply,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Perfectly price elastic supply (PES = ∞)',
        'When producers can supply any quantity at a given price.',
      ),
      SlideContent.term(
        'Perfectly price inelastic supply (PES = 0)',
        'When a change in price causes no change in quantity supplied.',
      ),
      SlideContent.term(
        'Price elastic supply (PES > 1)',
        'When the quantity supplied is relatively responsive to a change in price.',
      ),
      SlideContent.term(
        'Price inelastic supply (PES < 1)',
        'When the quantity supplied is relatively unresponsive to a change in price.',
      ),
      SlideContent.term(
        'Unitary price elasticity of supply (PES = 1)',
        'When the percentage change in quantity supplied equals the percentage change in price.',
      ),

    ],
  ),
];
