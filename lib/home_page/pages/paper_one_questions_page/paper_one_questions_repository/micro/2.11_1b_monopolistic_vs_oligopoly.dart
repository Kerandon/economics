// We use a top-level variable so we can import it elsewhere
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/diagram_group.dart';

import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide_content.dart';
import '../../../../models/term.dart';
import '../../../real_world_examples/real_world_examples.dart';
import '../../../terms/terms.dart';
import '../../paper_one_answer.dart';
import '../../paper_question.dart';

final monopolisticVsOligopolyQuestion = PaperQuestion(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the view that monopolistic competition is a more desirable market structure than oligopoly.',
  answer: PaperOneAnswer(
    tldr:
        'Desirability depends on the industry. Monopolistic Comp for variety and price which is desirable for restaurants; '
        'Oligopoly for economies of scale, R&D investment (EV market, technology AI firms, airlines).',
    terms: [EconTerm.monopolisticCompetition, EconTerm.oligopoly],
    explanation: [SlideContent.text('''
     <p>To accurately evaluate we must first consider the <strong>industry</strong>, the <strong>level of government intervention</strong>
    and from which stakeholders in society (consumers, producers, society)</p>
    <p>For example, in Shanghai restaurant industry, consumers value choice. Another example is detergent products in the supermarket. In these situations monopolistic competition
    is desirable for consumers in particular due to large product variety, choice and competition leading to relatively low prices.</p>
    <p>On the other hand, an oligopoly market provides benefits overall where there are high sunk and operating costs. For example, the airline industry in the UK due to the higher costs of operating
    an. Another example is the big four banks in Australia. These two industries are also very closely regulated. As long as there is appropriate government regulation to reduce implicit collusion, Oligopoly can lead 
    to low prices due to price-wars</p>
    <p>It is important to consider the concentration ratio. Arguable Woolworths and Coles (duopoly) are less desirable 
    due to the incentive of competing on non-price factors and inflating grocery prices.</p>
    <p>Furthermore technology firms (Google, Apple, ChatGPT, Microsoft, Meta) have used abnormal profits to invest
    in significant technological improvements (dynamic efficiency) that consumers, firms and society largely value. This 
    is highly desirable. Additionally these firms are more internationally competitive due to their economies of scale.</p>
    <p>On the other-hand, Oligopoly requires a higher level of government regulations to risk anti-competitive practices. 
    For example, technology firms discussed have many examples of anti-competitive practices. For example Apple abusing its market power due to its near monopoly on iOS apps and Microsoft bundling software.</p>

    '''
    ),],
    evaluation: [
      EvaluationData(
        title: 'Monopolistic Competition',
        leftTitle: 'Pros',
        rightTitle: 'Cons',
        leftItems: ['High competition, low prices', 'Greater product variety which consumers value'],
        rightItems: [
          'No abnormal profits in LR mean lower investment in R&D (reduced dynamic efficiency)',
          'Smaller economies of scale mean higher long-run average costs.',
        ],
      ),
      EvaluationData(
        title: 'Oligopoly',
        leftTitle: 'Pros',
        rightTitle: 'Cons',
        leftItems: ['Economies of scale. Lower long-run average costs can be passed on to consumer',
        'Price competition can leads to low prices',
          'Abnormal profits can be invested in R&D (Technology, EV market)'
        ],
        rightItems: [
          'Risk of implicit collusion (firms avoid competing on price (Australian Supermarkets)',
          'Collusion (price fixing)',
          'Less product variety'
        ],
      ),
    ],
    realWorldExamples: [
      RealWorldExamples.shanghaiCoffeeShops,
      RealWorldExamples.bigSuperMarketsAustralia,
      RealWorldExamples.eVIndustryInChina,
    ],
    diagrams: DiagramGroup(
      explanation:
          'Show monopolistic competition earning normal profit in long-run vs. Oligopoly earning'
          'abnormal profits acting as monopoly. Draw oligopoly demand curve noticeably more inelastic!',
      enums: [
        DiagramEnum.microMonopolisticCompetitionLongRun,
        DiagramEnum.microOligopolyKinkedDemandCurve,
      ],
    ),
  ),
);
