import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get competitiveMarketEquilibrium => [
  Slide(
    section: Subunit.competitiveMarket,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Competitive Market Equilibrium',
        'is the market price at which the quantity demanded equals the quantity supplied for a product. At this price, the market is cleared of any shortages or surpluses.',
      ),

      SlideContent.term(
        'Excess Demand',
        'is when quantity demanded is greater than quantity supplied at the current market price (resulting in a shortage).',
      ),

      SlideContent.term(
        'Excess Supply',
        'is when quantity supplied is greater than quantity demanded at the current market price (resulting in a surplus).',
      ),

      SlideContent.term(
        'Price Signals',
        'provide information to producers regarding where resources are required and to consumers to change consumption.',
      ),

      SlideContent.term(
        'Incentives',
        'provide motivation to change behavior. Higher price create an incentive to producers to supply more to maximize profit, and consumers to buy less to maximize utility.',
      ),

      SlideContent.term(
        'Price Rationing',
        'is when scarce goods and services are rationed by the price mechanism. When the quantity demanded of a good exceeds its quantity supplied, the price will rise and only those willing and able to pay will obtain the good.',
      ),

      SlideContent.term(
        'Non-Price Rationing',
        'is when scarce goods and services are allocated by methods other than price, such as queueing, lotteries, or on a needs basis.',
      ),

      SlideContent.term(
        'Marginal Benefit',
        'is the maximum amount a consumer is willing to pay for one more unit of a good or service. It represents the additional satisfaction or benefit gained from consuming one more unit.',
      ),

      SlideContent.term(
        'Consumer Surplus',
        'is the total welfare gained by consumers who are able to buy a product for a lower price than they are willing to pay. It is measured by the area below the demand curve (representing marginal benefit) and above the market price.',
      ),

      SlideContent.term(
        'Producer Surplus',
        'is the total welfare gained by producers by selling a good at a higher price they are willing to accept. It is measured by the area above the supply curve (representing the marginal cost of production) and below the market price.',
      ),

      SlideContent.term(
        'Social Surplus (Welfare)',
        'is the sum of consumer and producer surplus at a given level of output. Social welfare is maximized when the price mechanism clears the market of any excess demand or supply. When social welfare is maximized, the market is allocatively efficient.',
      ),

      SlideContent.term(
        'Allocative Efficiency',
        'is when resources are allocated in a way that maximizes social welfare, meaning the quantity of goods produced reflects what is most desired by society. This happens at the quantity where marginal benefit equals marginal cost.',
      ),

      SlideContent.term(
        tag: Tag.supplement,
        'Pareto Efficiency',
        'is when resources are allocated so that it is impossible to make one person better off without making someone else worse off.',
      ),
    ],
  ),
];
