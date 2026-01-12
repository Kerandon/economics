import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get whatIsEconomicsSlides => [
  Slide(
    subunit: Subunit.whatIsEconomics,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Change',
        'Refers to how societies must respond to evolving internal and external factors.',
      ),
      SlideContent.term(
        'Choice',
        'Refers to how societies make decisions to deal with the problem of scarcity.',
      ),
      SlideContent.term(
        'Circular Flow of Income Model',
        'A visual representation of economic activity, showing the interdependence of different sectors in an economy and the flows of money, output, and resources.',
      ),
      SlideContent.term(
        'Circular Economy',
        'A model that aims to eliminate waste and pollution, keep products and materials in use, and regenerate natural systems to ensure sustainability.',
      ),
      SlideContent.term(
        'Economic Goods',
        'Goods that result in an opportunity cost to produce and consume. Due to their scarcity, they can command a price when sold.',
      ),
      SlideContent.term(
        'Economic well-being',
        'The quality of life and economic satisfaction of individuals. Typical indicators include income, health, education, and the environment.',
      ),
      SlideContent.term(
        'Economics',
        'The study of how individuals and societies allocate scarce resources to meet unlimited wants and needs.',
      ),
      SlideContent.term(
        'Efficiency',
        'Making the best use of resources to minimize waste and maximize social welfare.',
      ),
      SlideContent.term(
        'Equity',
        'A normative concept concerning fairness and justice, particularly in the distribution of income and wealth.',
      ),
      SlideContent.term(
        'Free Goods',
        'Goods with zero opportunity cost in their consumption. These are abundant and naturally occurring, e.g., wind and sunlight.',
      ),
      SlideContent.term(
        'Geographic Mobility',
        'How easily resources can be relocated to another geographic location. For example, a worker moving to a new region for a job.',
      ),
      SlideContent.term(
        'Injection',
        'Money entering the economy, expanding economic activity. Main injections are investment, government spending, and export revenue.',
      ),
      SlideContent.term(
        'Interdependence',
        'The mutual reliance of individuals, firms, and governments, both within a society and between countries.',
      ),
      SlideContent.term(
        'Intervention',
        'Government involvement in free markets to achieve objectives such as correcting market failure or redistributing income.',
      ),
      SlideContent.term(
        'Leakages',
        'Money leaving the economy, reducing economic activity. Main leakages are savings, taxes, and import expenditure.',
      ),
      SlideContent.term(
        'Macroeconomics',
        'The study of the economy as a whole, including topics like inflation, economic growth, and national employment.',
      ),
      SlideContent.term(
        'Microeconomics',
        'The study of individual behavior and markets, including supply and demand, market failure, and government intervention.',
      ),
      SlideContent.term(
        'Normal Good',
        'A good for which demand rises as consumers’ income increases.',
      ),
      SlideContent.term(
        'Occupational Mobility',
        'How easily resources can switch between different uses in production. For example, a worker retrains for a new occupation.',
      ),
      SlideContent.term(
        'Opportunity Cost',
        'The value of the best alternative forgone when a decision is made.',
      ),
      SlideContent.term(
        'Private Sector',
        'Part of the economy made up of private individuals and firms.',
      ),
      SlideContent.term(
        'Public Sector',
        'Part of the economy controlled by the state (government).',
      ),
      SlideContent.term(
        'Scarcity',
        'Resources and goods and services are limited in supply.',
      ),
      SlideContent.term(
        'Sustainability',
        'Using scarce resources in a way that meets current needs without degrading resources for future generations.',
      ),
      SlideContent.term(
        'Economic well-being',
        'The quality of life and economic satisfaction of individuals. Typical indicators include income, health, education, and the environment.',
      ),
      SlideContent.term(
        'The Production Possibilities Curve (PPC)',
        'A model showing the maximum combination of any two goods an economy can produce at a given time, demonstrating choice, opportunity cost, and scarcity.',
      ),
    ],
  ),
  Slide(
    subunit: Subunit.whatIsEconomics,
    title: kTermsGlossary,
    contents: [
      // SlideContent(
      //   diagramEnums: [DiagramEnum.globalAbsoluteAdvantageBothGoods],
      // ),
    ],
  ),
];
