import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get externalitiesSlides => [
  Slide(
    section: Subunit.marketFailureExternalities,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Private goods',
        'Goods which are rivalrous and excludable.',
      ),
      SlideContent.term(
        'Club goods',
        'Goods which are non-rivalrous but excludable, e.g., online subscription services exclude those who do not pay a fee.',
      ),
      SlideContent.term(
        'Common pool resources',
        'Rivalrous and non-excludable, making them vulnerable to overuse and depletion, e.g., overfishing, deforestation, pollution.',
      ),
      SlideContent.term(
        'Tragedy of the commons',
        'Illustrates the risk of overuse and depletion of shared resources when individuals act in their own self-interest.',
      ),
      SlideContent.term(
        'Sustainability',
        'Using resources to meet current needs without depleting them for future generations.',
      ),
      SlideContent.term(
        'Renewable resources',
        'Resources that can be replenished over a short time when used sustainably, e.g., fish stocks and forests.',
      ),
      SlideContent.term(
        'Non-renewable resources',
        'Resources that cannot be replenished, e.g., fossil fuels. Consumption often harms the environment.',
      ),
      SlideContent.term(
        'Jevons paradox',
        'Efficiency improvements in resource use can lead to higher total consumption.',
      ),
      SlideContent.term(
        'Externalities',
        'Costs or benefits of economic activities that affect third parties and are not reflected in market prices.',
      ),
      SlideContent.term(
        'Negative production externality',
        'When producing a good creates external costs for third parties, e.g., MSC > MPC.',
      ),
      SlideContent.term(
        'Negative consumption externality',
        'When consuming a good imposes external costs on third parties, e.g., MPB > MSB.',
      ),
      SlideContent.term(
        'Positive production externality',
        'When producing a good increases third-party well-being without compensation, e.g., MSC < MPC.',
      ),
      SlideContent.term(
        'Positive consumption externality',
        'When consuming a good benefits others without compensation, e.g., MSB > MPB.',
      ),
      SlideContent.term(
        'Pigouvian tax',
        'An indirect tax on activities generating negative externalities to correct market inefficiency.',
      ),
      SlideContent.term(
        'Internalizing the cost',
        'Factoring external costs into the market price of a good or service.',
      ),
      SlideContent.term(
        'Carbon tax',
        'An indirect tax on carbon emissions to reduce their social cost.',
      ),
      SlideContent.term(
        'Tradable pollution permits',
        'Government-issued permits to emit carbon that can be traded, reducing social cost.',
      ),
      SlideContent.term(
        'Collective self-governance',
        'Communities managing common-pool resources sustainably with clear boundaries and communication.',
      ),
      SlideContent.term(
        'Demerit good',
        'A good consumed more than socially desirable, often due to underestimating external costs.',
      ),
      SlideContent.term(
        'Merit good',
        'A good that creates positive externalities but is under-consumed compared to the social optimum.',
      ),
    ],
  ),
];
