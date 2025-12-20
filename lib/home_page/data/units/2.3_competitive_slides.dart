import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get competitiveMarketEquilibrium => [
  Slide(
    subunit: Subunit.competitiveMarket,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Allocative Efficiency',
        'The quantity of goods most desired by society, representing maximum social welfare (<strong>MSB = MSC</strong>).',
      ),
      SlideContent.term(
        'Competitive Market Equilibrium',
        'The market price at which quantity demanded equals quantity supplied, clearing the market of shortages or surpluses.',
      ),
      SlideContent.term(
        'Consumer Surplus',
        'The difference between what consumers are willing to pay and the market price; area under demand (MB) and above price.',
      ),
      SlideContent.term(
        'Producer Surplus',
        'The difference between the market price and the minimum price producers are willing to accept; area above supply (MC) and below price.',
      ),
      SlideContent.term(
        'Social Surplus (Community Surplus)',
        'The sum of consumer and producer surplus; maximized at market equilibrium.',
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
        'Marginal Benefit',
        'The additional benefit gained from consuming one more unit, measured by the maximum a consumer is willing to pay.',
      ),

      SlideContent.term(
        'Price Mechanism',
        'How prices adjust to allocate resources, goods, and services in response to changes in demand and supply, through price signals, incentives, and rationing.',
      ),
      SlideContent.term(
        'Price Signals',
        'Information conveyed by price changes that guide consumer and producer decisions.',
      ),
      SlideContent.term(
        'Incentives',
        'Motivations created by price changes that encourage consumers and producers to adjust behavior to maximize profit or benefit.',
      ),
      SlideContent.term(
        'Price Rationing',
        'When scarce goods and services are allocated by the price mechanism. E.g., when a good is in shortage, its price rises and only those willing and able to pay can obtain it.',
      ),
      SlideContent.term(
        'Non-Price Rationing',
        'Allocation of goods using methods other than price, such as queueing, lotteries, or needs-based systems.',
      ),
      SlideContent.term(
        tag: Tag.supplement,
        'Pareto Efficiency',
        'Resources are allocated so that it is impossible to make one person better off without making someone else worse off.',
      ),
    ],
  ),
  Slide(
    subunit: Subunit.competitiveMarket,
    title: 'Market equilibrium',
    contents: [
      SlideContent.text(
        'Market equilibrium is the market price where the quantity demanded (Qd) is equal to quantity supplied (Qs)',
      ),
      SlideContent.diagram(DiagramEnum.microMarketEquilibrium),
      SlideContent.text(
        'Market disequilibrium is either when <strong>Qd > Qs (shortage) (L)</strong> '
        'or when <strong>Qs > Qd (R)</strong>  at the current market price.',
      ),
      SlideContent.diagrams([
        DiagramEnum.microShortage,
        DiagramEnum.microSurplus,
      ]),
    ],
  ),
  Slide(
    subunit: Subunit.competitiveMarket,
    title: 'Resource Allocation - Price Mechanism',
    contents: [
      SlideContent.text(
        'The price mechanism allocates resources and rations goods and services through three key functions:'
        '<ul><li>Price signalling</li>'
        '<li>Incentives</li>'
        '<li>Price Rationing</li>'
        '</ul>',
      ),
      SlideContent.text(
        '<ul>'
        '<li><strong>(L)</strong> Demand increases leading to a shortage at P1,Q1 creating upward pressure on price '
        'signalling to producers to allocate more resources to production, as profit incentives increase. '
        'Consumers respond to higher prices by reducing consumption. '
        'Qs rises and Qd falls until the surplus is cleared at P2,Q2.</li>'
        '<li><strong>(R)</strong> Demand falls leading to a surplus at P1,Q1, creating downward pressure on price, '
        'signalling to producers to reduce resource allocation, '
        'while lower prices provide an incentive to consumers to increase consumption to maximize utility.'
        'Qs falls and Qd rises until the surplus is cleared at P2,Q2.</li>'
        '</ul>',
      ),

      SlideContent.diagrams([
        DiagramEnum.microDemandIncreasePriceMechanism,
        DiagramEnum.microDemandDecreasePriceMechanism,
      ]),

      SlideContent.text(
        'Price rationing is how the price mechanism allocates scarce goods and services among consumers. '
        'E.g., when there is a shortage, price rises and only consumers willing to pay the higher price obtain the good'
        ' (thereby \'rationing\' the good).',
      ),

      SlideContent.diagram(DiagramEnum.microPriceRationing),
    ],
  ),
  Slide(
    title: 'The Law of Diminishing Marginal Utility',
    subunit: Subunit.competitiveMarket,
    contents: [
      SlideContent.text(
        'As consumption increases the additional utility (satisfaction) falls. '
        'This is because consumers become more and more satiated with a good the more they consume. '
        'This is known as <strong>The Law of Diminishing Marginal Utility</strong>.',
      ),
      SlideContent.customWidget(
        SimpleTable(
          headers: ['Slices of Pizza', 'Total Utility', 'Marginal Utility'],
          data: [
            ['1', '10', '10'],
            ['2', '18', '8'],
            ['3', '23', '5'],
            ['4', '23', '0'],
            ['5', '19', '-4'],
          ],
        ),
      ),
      SlideContent.text(
        'Marginal Utility = ΔTotal Utility / ΔQuantity <strong>(MU = ΔTU / ΔQ)</strong>. '
        'The additional utility of the second slice of pizza is (18 − 10) / (2 − 1) = 8 MU. '
        'Maximum satiation occurs when four slices are eaten. A fifth slice may make the consumer feel sick, resulting in negative marginal utility.',
      ),
    ],
  ),
  Slide(
    title: 'Marginal Benefit and Marginal Cost',
    subunit: Subunit.competitiveMarket,
    contents: [
      SlideContent.text(
        'Marginal Benefit (MB) represents the maximum a consumer is willing to pay for one more unit of a good'
        ' (a quantifiable way to measure marginal utility).\n'
        'MB is the demand curve.',
      ),
      SlideContent.diagrams([
        DiagramEnum.microMarginalBenefit,
        DiagramEnum.microMarginalCostSteps,
      ]),
      SlideContent.text(
        'Marginal Cost (MC) represents the additional cost for a firm to supply one more unit of a good'
        ' (underpinned by The Law of Diminishing Marginal Utility).\n'
        'MC is the supply curve.',
      ),
    ],
  ),
  Slide(
    title: 'Consumer, Producer and Social Surplus',
    subunit: Subunit.competitiveMarket,
    contents: [
      SlideContent.text(
        'Consumer Surplus is calculated the area below the marginal benefit curve (demand) and above the market price.',
      ),
      SlideContent.diagrams([
        DiagramEnum.microConsumerSurplus,
        DiagramEnum.microProducerSurplus,
      ]),
      SlideContent.text(
        'Allocative Efficiency is achieved when <strong>MB = MC</strong>. At this quantity any surpluses or shortages are cleared from the market, and'
        ' the <strong>sum</strong> of consumer surplus and producer surplus is maximized.'
        ' This represents the most efficient allocation of resources from society\'s point of view.',
      ),
      SlideContent.diagrams([DiagramEnum.microAllocativeEfficiency]),
    ],
  ),
];
