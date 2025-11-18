import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get externalitiesSlides => [
  Slide(
    section: Subunit.marketFailureExternalities,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Carbon tax',
        'An indirect tax on carbon emissions to reduce their social cost.',
      ),
      SlideContent.term(
        'Club goods',
        'Goods that are non-rivalrous but excludable, e.g., online subscription services.',
      ),
      SlideContent.term(
        'Collective self-governance',
        'Local communities managing common-pool resources sustainably through shared rules and cooperation.',
      ),
      SlideContent.term(
        'Common pool resources',
        'Goods that are rivalrous but non-excludable, making them vulnerable to overuse and depletion, e.g., ocean fisheries.',
      ),
      SlideContent.term(
        'Demerit good',
        'A good that creates negative externalities but is consumed more than socially desirable, often because it is relatively affordable or consumers do not appreciate its social costs.',
      ),
      SlideContent.term(
        'Externalities',
        'Costs or benefits of economic activities that affect third parties and are not reflected in market prices.',
      ),
      SlideContent.term(
        'Internalizing the externality',
        'Including external costs or benefits in the market price of a good or service.',
      ),
      SlideContent.term(
        tag: Tag.supplement,
        'Jevons paradox',
        'The idea that improvements in resource-use efficiency can lead to increased consumption and total energy use (i.e., counter-productive).',
      ),
      SlideContent.term(
        'Marginal private benefit',
        'The extra benefit to consumers when one more unit is consumed.',
      ),
      SlideContent.term(
        'Marginal private cost',
        'The extra cost to producers when one more unit is produced.',
      ),
      SlideContent.term(
        'Marginal social benefit',
        'The extra benefit to society when one more unit is consumed.',
      ),
      SlideContent.term(
        'Marginal social cost',
        'The extra cost to society when one more unit is produced.',
      ),
      SlideContent.term(
        'Merit good',
        'A good that creates positive externalities but is consumed less than socially desirable, often because it is unaffordable or consumers do not appreciate its social benefits.',
      ),
      SlideContent.term(
        'Negative consumption externality',
        'When consuming a good imposes external costs on third parties, e.g., MPB < MSB.',
      ),
      SlideContent.term(
        'Negative production externality',
        'When producing a good imposes external costs on third parties, e.g., MSC > MPC.',
      ),
      SlideContent.term(
        'Non-renewable resources',
        'Resources that cannot be replenished within a human timescale, e.g., fossil fuels.',
      ),
      SlideContent.term(
        'Pigouvian tax',
        'An indirect tax on activities that create negative externalities to correct market inefficiency.',
      ),
      SlideContent.term(
        'Positive consumption externality',
        'When consuming a good creates external benefits for third parties, e.g., MSB > MPB.',
      ),
      SlideContent.term(
        'Positive production externality',
        'When producing a good creates external benefits for third parties, e.g., MSC < MPC.',
      ),
      SlideContent.term(
        'Private goods',
        'Goods that are rivalrous and excludable.',
      ),
      SlideContent.term(
        'Renewable resources',
        'Resources that can be replenished naturally over time when used sustainably, e.g., fish stocks and forests.',
      ),
      SlideContent.term(
        'Socially optimum output',
        'The level of production and consumption where social welfare is maximized (MSB = MSC).',
      ),
      SlideContent.term(
        'Sustainability',
        'Using resources to meet present needs without compromising the ability of future generations to meet theirs.',
      ),
      SlideContent.term(
        'Tragedy of the commons',
        'Illustrates how individuals acting in self-interest overuse a shared resource, leading to its depletion.',
      ),
      SlideContent.term(
        'Tradable pollution permits',
        'Government-issued permits to emit carbon that can be traded on a secondary market, reducing social cost.',
      ),
      SlideContent.term(
        'Unsustainable Production',
        'Production that leads to depletion and degradation of resources.',
      ),
      SlideContent.term(
        'Excludability',
        'The extent to which access to a good or resource can be restricted, usually by price.',
      ),
      SlideContent.term(
        'Rivalrous',
        'Consumption of a good or resource reduces the amount available for others.',
      ),
    ],
  ),
];
