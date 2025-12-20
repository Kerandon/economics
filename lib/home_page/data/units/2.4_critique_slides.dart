import 'package:economics_app/diagrams/enums/unit_type.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_enum.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get critiqueSlides => [
  Slide(
    subunit: Subunit.critiqueBehaviour,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        tag: Tag.hl,
        'Anchoring',
        'Comparing options to the first piece of information seen.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Availability Bias',
        'Overestimating the likelihood of recent or vivid events.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Behavioral Economics',
        'Studies how psychological factors influence economic decision-making, as an alternative to the rational consumer choice model.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Biases',
        'The use of heuristics (mental shortcuts) in decision-making, which leads consumers away from fully rational choices. E.g., rules of thumb, anchoring, availability bias, and framing.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Rationality',
        'Humans have limited cognitive ability, time, and imperfect information, which constrains rational decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Self-Control',
        'Humans have limited self-control and may consume beyond the point of maximum utility, e.g., eating chocolate while on a diet.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Selfishness',
        'Humans sometimes make decisions that consider the welfare of others, rather than only acting in self-interest (altruistic behavior).',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Choice Architecture',
        'The way choices are presented to consumers can influence decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Corporate Social Responsibility (CSR)',
        'When firms take responsibility for the social and environmental impacts of their business operations.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Default Choice',
        'The usual choice, or the choice selected if nothing else is chosen.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Framing',
        'How the presentation of information affects decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Growth Maximization',
        'When a firm aims to expand its size or output.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Imperfect Information',
        'When economic agents do not have access to all relevant information, preventing fully rational decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Inertia',
        'Sticking with the usual or default choice.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Mandated Choice',
        'When a consumer must choose between different options.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Market Share',
        'The percentage of total industry sales held by a firm (<strong>Firm sales ÷ total industry sales</strong>).',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Nudge Theory',
        'The study of how indirect suggestions can influence the behavior of individuals and groups.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Rational Consumer Choice',
        'Assumes consumers act in rational self-interest, have access to perfect information, and aim to maximize utility given their budget constraints.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Rational Producer Behavior',
        'Firms aim to maximize profit by acting efficiently with given revenues and costs.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Revenue Maximization',
        'When a firm aims to maximize total revenue (sales).',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Restricted Choice',
        'When consumers face a limited set of options.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Rules of Thumb',
        'An informal shortcut (heuristic) that simplifies decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Satisficing',
        'When an individual or firm settles for a satisfactory outcome rather than striving for the optimal one, e.g., balancing profit maximization with multiple objectives.',
      ),
    ],
  ),
  Slide(
    title: 'Consumer rationality',
    subunit: Subunit.critiqueBehaviour,
    contents: [
      SlideContent.text('''
    Rational consumer choice assumes consumers are motivated by rational self-interest, have access to perfect information, and aim to maximize their utility based on their budget constraints.

      <ul>
<li><strong>Consumer Rationality:</strong>
<ul>
<li>i. Completeness (can rank all bundles of goods)</li>
<li>ii. Transitivity (preferences are consistent)</li>
<li>iii. Non-satiation (more is preferred to less)</li>
</ul>
</li>
<li><strong>Perfect Information</strong></li>
<li><strong>Utility Maximization</strong></li>
</ul>
'''),
    ],
  ),
  Slide(
    subunit: Subunit.critiqueBehaviour,
    title: 'Limitations of the assumptions of rational consumer choice (A03)',
    contents: [
      SlideContent.text('''
    Behavioral economics challenges the idea of consumer rationality, based on the following limitations:
   Behavioral economics challenges the idea of consumer rationality, based on the following limitations:
<ul>
  <li>Biases
    <ul>
      <li>Rule of Thumb</li>
      <li>Inertia</li>
      <li>Anchoring</li>
      <li>Framing</li>
      <li>Availability Bias</li>
    </ul>
  </li>
  <li>Bounded rationality</li>
  <li>Bounded self-control</li>
  <li>Bounded selfishness</li>
  <li>Imperfect information</li>
</ul>

        '''),
    ],
  ),
  Slide(
    title: 'Behavioural economics in action (A03)',
    subunit: Subunit.critiqueBehaviour,
    contents: [
      SlideContent.text('''
  

    <strong>Choice Architecture</strong> studies how the presentation of choices to consumers can influence decision-making.
    There are three ways choices can be presented to influence decision making:
  
     <ul>
  <li>
 Default Choice   </li>
   <li>Restricted Choice</li> 
  <li>Mandated Choice</li>

</ul>
<p><strong>Nudges</strong> aim to influence decision making without limiting freedom of choice. Examples include:</p>
<ul>
  <li>Placing healthier foods at eye level to encourage better eating choices.</li>
  <li>Sending reminders to pay bills on time.</li>
  <li>Adding footprints on steps to encourage physical activity over elevators.</li>
</ul>

        '''),
    ],
  ),
  Slide(
    title: 'Business objectives (A03)',
    subunit: Subunit.critiqueBehaviour,
    contents: [
      SlideContent.text('''
<p><strong>Alternative Business Objectives</strong></p>
<ul>
  <li>Corporate Social Responsibility (CSR)</li>
  <li>Market Share</li>
  <li>Growth Maximization</li>
  <li>Revenue Maximization</li>
  <li>Satisficing</li>
</ul>

        '''),
    ],
  ),
];
