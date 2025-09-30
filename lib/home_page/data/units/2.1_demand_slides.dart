import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get demandSlides => [
  /// Demand
  Slide(
    section: Subunit.demand,
    title: 'Definition & The Law Of Demand',
    contents: [
      SlideContent.term(
        'Demand',
        'is the various quantities of a good or service that a consumer is willing and able to purchase at different prices during a particular time period, ceteris paribus.',
      ),
      SlideContent.term(
        'The Law of Demand',
        'states that there is a negative relationship between the price of a good or service and the quantity demanded over a particular period of time, ceteris paribus. As the price decreases, the quantity demanded will increase and vice-versa.',
      ),

      SlideContent.term(
        'Derived Demand',
        'is the demand for a good, service or resource that arises from the demand for a related good, service or resource.',
      ),
      SlideContent.term(
        'Market Demand',
        'is the total (aggregate) quantity of a good or service demanded by all consumers in a market at various prices, over a specific period of time, ceteris paribus.',
      ),
      SlideContent.term(
        'Change in quantity demanded',
        'is caused by a change in price of the good or service. This results in a movement along the demand curve: a fall in price leads to an extension in demand while a rise in price leads to a contraction in demand.',
      ),
      SlideContent.term(
        'Market Demand',
        'is the total (aggregate) quantity of a good or service demanded by all consumers in a market at various prices, over a specific period of time, ceteris paribus.',
      ),
      SlideContent.term(
        'Normal Good',
        'is a good for which demand increases when consumers’ real income rises. These include most everyday consumer goods and services.',
      ),
      SlideContent.term(
        'Inferior Good',
        'a is a goods for which demand increases when consumers’ real income falls. Examples may include public transport or second-hand clothing.',
      ),
      SlideContent.term(
        'Substitute Good',
        'is an alternative good which satisfies a similar want or need. The price of the substitute & demand move in the same direction. If the price of Cola increases, the demand for Pepsi increases',
      ),
      SlideContent.term(
        'Complement Good',
        'is a good which are consumed together. Price and demand move in opposite directions. For example, if the price of cars increase, the demand for gasoline falls.,',
      ),
      SlideContent.term(
        'Supply Shock',
        'is an unexpected exogenous event that significantly '
            'affect supply. Typical examples include war, political instability, or natural disasters, '
            'which can disrupt supply chains, reduce the availability of resources, and increase production '
            'costs for producers. A supply shock can be either positive or negative.',
      ),

      SlideContent.term(
        hl: true,
        'The Law of Diminishing Marginal Returns',
        'states that as consumption of a good increases, '
            'the marginal utility (extra satisfaction) decreases with each additional unit consumed, ceteris paribus.',
      ),

      SlideContent.term(
        hl: true,
        'Substitution effect',
        'occurs when a fall in the price of a good makes it relatively cheaper '
            'compared to substitutes, causing consumers to switch from other goods and increase quantity demanded.',
      ),

      SlideContent.term(
        hl: true,
        'Conspicuous Consumption',
        'refers to individuals who make purchases of luxury '
            'to display their wealth or status rather than for their practical utility.',
      ),

      SlideContent.term(
        hl: true,
        'Veblen Good',
        'is a type of luxury good which is used to show wealth or status. '
            'It shows a positive relationship between price and quantity demanded, making them an exception to the law of demand.',
      ),

      SlideContent.term(
        hl: true,
        'Giffen Good',
        'is a staple good that make up a large proportion of consumers’ expenditure. '
            'When its price rises, consumers buy more of the good, creating a positive relationship between price and quantity demanded '
            '(an exception to the law of demand). The increase in demand is due to the income effect of the higher price outweighing the substitution effect.',
      ),

      SlideContent.term(
        hl: true,
        'Supply',
        'is the various quantities of a good or service a firm is willing and able to sell '
            'at different prices, during a particular time period, ceteris paribus.',
      ),

      SlideContent.term(
        'The Law of Supply',
        'states that there is a positive relationship between the price of a good and its '
            'quantity supplied, ceteris paribus.',
      ),

      SlideContent.term(
        'Market Supply',
        'is the total (aggregate) quantity of a good or service supplied by all producers '
            'in a market at different prices, over a specific period of time, ceteris paribus.',
      ),

      SlideContent.term(
        hl: true,
        'Marginal Product',
        'is the additional output that results from employing one more unit of an input, '
            'ceteris paribus. <strong>MP = ∆Total Product ÷ ∆Input</strong>',
      ),

      SlideContent.term(
        hl: true,
        'Marginal Cost',
        'is the change in cost incurred when producing one more unit of a good, '
            'ceteris paribus. <strong>MC = ∆Total Cost ÷ ∆Quantity</strong>',
      ),

      SlideContent.term(
        'Competitive Market Equilibrium',
        'is the market price at which the quantity demanded equals the quantity supplied '
            'for a product. At this price, the market is cleared of any shortages or surpluses.',
      ),

      SlideContent.term(
        'Excess Demand',
        'is when quantity demanded is greater than quantity supplied at the current market price '
            '(resulting in a shortage).',
      ),

      SlideContent.term(
        'Excess Supply',
        'is when quantity supplied is greater than quantity demanded at the current market price '
            '(resulting in a surplus).',
      ),

      SlideContent.term(
        'Price Signals',
        'provide information to producers regarding where resources are required and to consumers to change consumption.',
      ),

      SlideContent.term(
        'Incentives',
        'provide motivation to change behavior. Producers supply more or less to maximize profit, '
            'and consumers buy more or less to maximize utility.',
      ),

      SlideContent.term(
        'Price Rationing',
        'is when scarce goods and services are rationed by the price mechanism. When the quantity demanded '
            'of a good exceeds its quantity supplied, the price will rise and only those willing and able to pay will obtain the good.',
      ),

      SlideContent.term(
        'Non-Price Rationing',
        'is when scarce goods and services are allocated by methods other than price, '
            'such as queueing, lotteries, or on a needs basis.',
      ),

      SlideContent.term(
        'Marginal Benefit',
        'is the maximum amount a consumer is willing to pay for one additional unit of a good or service.',
      ),

      SlideContent.term(
        'Consumer Surplus',
        'is the total welfare gained by buyers who are able to buy a product for a lower price than they '
            'are willing and able to pay. It is measured by the area below the demand curve (marginal benefit) and above the market price.',
      ),

      SlideContent.term(
        'Producer Surplus',
        'is the total welfare gained by producers by selling a good at a higher price they are willing '
            'and able to accept. It is measured by the area above the supply curve (marginal cost) and below the market price.',
      ),

      SlideContent.term(
        ''
            'Social Surplus (Welfare)',
        'is the sum of consumer and producer surplus at a given level of output. Social welfare is maximized when the price mechanism clears the market of any excess demand or supply. When social welfare is maximized, the market is allocatively efficient.',
      ),
      SlideContent.term(
        'Social Surplus (Welfare)',
        'is the sum of consumer and producer surplus at a given level of output. Social welfare is maximized when the price mechanism clears the market of any excess demand or supply. When social welfare is maximized, the market is allocatively efficient.',
      ),
      SlideContent.term(
        ''
            'Allocative Efficiency',
        'is when resources are allocated in a way that maximizes social welfare, meaning the quantity of goods produced reflects what is most desired by society. This happens when marginal benefit (MB) equals marginal cost (MC).',
      ),

      SlideContent.term(
        hl: true,
        ''
            'Pareto Efficiency',
        'is when resources are allocated so that it is impossible to make one person better off without making someone else worse off.',
      ),
      SlideContent.term(
        hl: true,
        'Behavioral Economics',
        'studies how psychological factors influence economic decision-making. It is an alternative to the rational consumer choice model of classical economics.',
      ),

      SlideContent.term(
        hl: true,
        'Rational Consumer Choice',
        'assumes consumers are motivated by rational self-interest, have access to perfect information, and aim to maximize their utility based on their budget constraints.',
      ),
      SlideContent.term(
        hl: true,
        'Biases',
        'refer to the use of heuristics (mental shortcuts) in decision-making, which can lead consumers away from fully rational choices. Examples include rules of thumb, anchoring, availability bias, and framing.',
      ),
      SlideContent.term(
        hl: true,
        'Bounded Rationality',
        'refers to humans having limited in cognitive ability, time and imperfect information which constrains rational decision making',
      ),
      SlideContent.term(
        hl: true,
        'Bounded Self-Control',
        'refers to humans’ limited self-control. Individuals may consume beyond the point where they maximize their utility for a good (for example, eating chocolate while on a diet.',
      ),
      SlideContent.term(
        hl: true,
        'Bounded Selfishness',
        'refers to humans making decisions that consider the welfare of others, rather than only acting in their own self-interest (altruistic behavior).',
      ),
      SlideContent.term(
        hl: true,
        'Imperfect Information',
        'occurs when economic agents do not have access to all relevant information, preventing fully rational decision-making.',
      ),
      SlideContent.term(
        hl: true,
        'Nudge Theory',
        'is the study of how indirect suggestions and positive reinforcements can influence the behavior of individuals or groups.',
      ),
      SlideContent.term(
        hl: true,
        'Choice Architecture',
        'studies how choices presented to consumers can influence decision making (part of nudges).',
      ),
      SlideContent.term(
        hl: true,
        'Rules of Thumb',
        'is an informal shortcut (heuristic) that simplifies decision-making',
      ),
      SlideContent.term(
        hl: true,
        'Inertia',
        'refers to sticking with the usual or default choice.',
      ),
      SlideContent.term(
        hl: true,
        'Anchoring',
        'refers to comparing options to the first piece of information seen.',
      ),
      SlideContent.term(
        hl: true,
        'Framing',
        'refers to how the presentation of information affects decision making.',
      ),
      SlideContent.term(
        hl: true,
        'Availability Bias',
        'refers to overestimating the likelihood of recent or vivid events.',
      ),
      SlideContent.term(
        hl: true,
        'Corporate Social Responsibility (CSR)',
        'is when firms take responsibility for the social and environmental impacts of their activities, going beyond profit maximization to act ethically and sustainably.',
      ),
      SlideContent.term(
        hl: true,
        'Satisficing',
        'is when an individual or firm settles for a satisfactory outcome rather than striving for the optimal one.',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandPriceChange),
    ],
  ),

  Slide(
    section: Subunit.demand,
    title: 'Non-Price Determinants of Demand',
    contents: [
      SlideContent.key('Non-Price Determinants of Demand', '''
<ul>
<li>Consumer Income</li>
<li>Tastes and preferences</li>
<li>Future price expectations</li>
<li>Price of related goods (substitutes and complements)</li>
<li>Number of consumers</li>
</ul>
'''),
      SlideContent.diagram(DiagramBundleEnum.microDemandDeterminants),
    ],
  ),

  Slide(
    section: Subunit.demand,
    title: 'Reasons For Downward Sloping Demand',
    hl: true,
    contents: [
      SlideContent.key('Reasons For Downward Sloping Demand Curve', '''
<ul>
<li>Income effect</li>
<li>Substitution effect</li>
<li>Diminishing marginal utility</li>
</ul>
''', hl: true),
      SlideContent.text('''
<ul>
<li><strong>Income effect:</strong> As the price of a good falls, consumers can afford to buy more with the same income, increasing demand.</li>
<li><strong>Substitution effect:</strong> When the price of a good falls, it becomes relatively cheaper compared to substitutes, so consumers switch towards it.</li>
<li><strong>Diminishing marginal utility:</strong> Each additional unit consumed gives less satisfaction, so consumers are only willing to buy more at lower prices.</li>
</ul>
'''),
      SlideContent.diagram(
        DiagramBundleEnum.microDemandPriceChange,
      ), // 🔧 placeholder for now
    ],
  ),

  Slide(
    section: Subunit.supply,
    title: 'Non-Price Determinants of Supply',
    contents: [
      SlideContent.key('Non-Price Determinants of Supply', '''
<ul>
<li>Changes in costs of factors of production (FOPs)</li>
<li>Prices of related goods (joint and competitive supply)</li>
<li>Indirect taxes and subsidies</li>
<li>Future price expectations</li>
<li>Changes in technology</li>
<li>Number of firms</li>
</ul>
'''),
      SlideContent.diagram(
        DiagramBundleEnum.microDemandPriceChange,
      ), // 🔧 placeholder
    ],
  ),
];
