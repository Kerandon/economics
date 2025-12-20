import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get externalitiesSlides => [
  Slide(
    subunit: Subunit.marketFailureExternalities,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Carbon tax',
        'A market-based approach to addressing the social cost of carbon by imposing an indirect tax on carbon emission output.',
      ),

      SlideContent.term(
        'Club goods',
        'Goods that are non-rivalrous but excludable, e.g., online subscription services or private parks.',
      ),

      SlideContent.term(
        'Collective self-governance',
        'When communities manage common-pool resources sustainably through shared rules and cooperation. It requires clear resource boundaries and effective communication.',
      ),

      SlideContent.term(
        'Common pool resources',
        'Resources that are rivalrous but non-excludable, making them vulnerable to overuse and depletion (tragedy of the commons), e.g., ocean fisheries or groundwater.',
      ),

      SlideContent.term(
        'Demerit good',
        'A good that generates negative externalities and is consumed more than socially desirable, often because consumers are not aware of its social costs.',
      ),

      SlideContent.term(
        'Excludable',
        'Can be prevented from consuming or using a good or resource, usually through price.',
      ),

      SlideContent.term(
        'Rivalrous',
        'When consumption of a good or resource reduces the amount available for others.',
      ),

      SlideContent.term(
        'Externalities',
        'Costs or benefits of economic activities that affect third parties and are not reflected in market prices.',
      ),

      SlideContent.term(
        'Internalizing the externality',
        'External costs or benefits are included in the market price of a good or service.',
      ),

      SlideContent.term(
        'Marginal private benefit',
        'The extra benefit to consumers from consuming one additional unit of a good.',
      ),

      SlideContent.term(
        'Marginal private cost',
        'The extra cost to producers from producing one additional unit of a good.',
      ),

      SlideContent.term(
        'Marginal social benefit',
        'The extra benefit to society from consuming one additional unit of a good.',
      ),

      SlideContent.term(
        'Marginal social cost',
        'The extra cost to society from producing one additional unit of a good.',
      ),

      SlideContent.term(
        'Merit good',
        'A good that generates positive externalities and is consumed less than socially desirable, often because consumers do not appreciate its social benefits.',
      ),

      SlideContent.term(
        'Negative consumption externality',
        'When consumption imposes external costs on third parties, e.g., MSB < MPB.',
      ),

      SlideContent.term(
        'Negative production externality',
        'When production imposes external costs on third parties, e.g., MSC > MPC.',
      ),

      SlideContent.term(
        'Non-renewable resources',
        'Resources that cannot be replenished, e.g., fossil fuels.',
      ),

      SlideContent.term(
        'Pigouvian tax',
        'An indirect tax on activities that generate negative externalities, aimed at reducing external costs and correcting market failure.',
      ),

      SlideContent.term(
        'Property rights',
        'Legal ownership and control over tangible and intangible property. E.g., land, patents, fishing rights, pollution permits.',
      ),

      SlideContent.term(
        'Positive consumption externality',
        'When consumption creates external benefits for third parties, e.g., MSB > MPB.',
      ),

      SlideContent.term(
        'Positive production externality',
        'When production creates external benefits for third parties, e.g., MSC < MPC.',
      ),

      SlideContent.term(
        'Private goods',
        'Goods that are both rivalrous and excludable.',
      ),

      SlideContent.term(
        'Renewable resources',
        'Resources that can replenish naturally over time when used sustainably, e.g., fish stocks or forests.',
      ),

      SlideContent.term(
        'Socially optimum output',
        'The level of output where social welfare is maximised (MSB = MSC).',
      ),

      SlideContent.term(
        'Sustainability',
        'Using resources to meet present needs without compromising the ability of future generations to meet their own.',
      ),

      SlideContent.term(
        'Tragedy of the commons',
        'When individuals acting in their own self-interest overuse a shared resource, leading to depletion.',
      ),

      SlideContent.term(
        'Tradable pollution permits (Cap and Trade)',
        'Government-issued permits allowing firms to emit a certain amount of carbon. A market-based approach which creates a secondary market which facilitates an efficient exchange between low-cost and high-cost polluters.',
      ),

      SlideContent.term(
        'Unsustainable production',
        'Production that depletes or degrades natural resources over time, reducing future generations’ ability to meet their needs.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Jevons paradox',
        'The idea that improvements in resource-use efficiency can increase total consumption, offsetting environmental benefits.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Coase Theorem',
        'If property rights are clearly defined and transaction costs are low, private bargaining can resolve externalities efficiently.',
      ),
    ],
  ),
  Slide(
    title: 'Externalities and common pool or common access resources',
    subunit: Subunit.marketFailureExternalities,
  ),
  Slide(
    title:
        'Externalities and common pool or common access resources (A02, A04)',
    subunit: Subunit.marketFailureExternalities,
  ),
];
