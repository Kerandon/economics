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
        'The market price at which the quantity demanded equals the quantity supplied. The market is cleared of any shortages or surpluses.',
      ),

      SlideContent.term(
        'Excess Demand',
        'When quantity demanded exceeds quantity supplied at the current price (shortage).',
      ),

      SlideContent.term(
        'Excess Supply',
        'When quantity supplied exceeds quantity demanded at the current price (surplus).',
      ),

      SlideContent.term(
        'Price Signals',
        'Information conveyed by price changes that guide consumer and producer decisions.',
      ),

      SlideContent.term(
        'Incentives',
          'Motivations created by price changes that encourage consumers and producers to adjust behaviour to maximise profit or benefit.'

      ),

      SlideContent.term(
        'Non-Price Rationing',
        'Allocation of goods using methods other than price, such as queueing, lotteries, or needs-based systems.',
      ),

      SlideContent.term(
        'Marginal Benefit',
        'The extra benefit from consuming one more unit; the maximum a consumer is willing to pay for the next unit.',
      ),

      SlideContent.term(
        'Consumer Surplus',
        'The difference between what consumers are willing to pay and the market price; area under demand and above price.',
      ),

      SlideContent.term(
        'Producer Surplus',
        'The difference between the market price and the minimum price producers are willing to accept; area above supply and below price.',
      ),

      SlideContent.term(
        'Social Surplus (Welfare)',
        'The sum of consumer and producer surplus; maximized at market equilibrium.',
      ),


      SlideContent.term(
        'Allocative Efficiency',
        'The quantity of goods most desired by society, representing maximum social welfare (<strong>MSB = MSC</strong>)',
      ),

      SlideContent.term(
        'Pareto Efficiency',
        'Resources are allocated so that it is impossible to make one person better off without making someone else worse off.',
      ),
    ],
  ),
];
