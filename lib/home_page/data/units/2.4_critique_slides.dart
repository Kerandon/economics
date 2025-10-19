import 'package:economics_app/diagrams/enums/unit_type.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/diagram_bundle_enum.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get critiqueSlides => [
  Slide(
    section: Subunit.critiqueBehaviour,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        tag: Tag.hl,
        'Behavioral Economics',
        'studies how psychological factors influence economic decision-making. It is an alternative to the rational consumer choice model of classical economics.',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Rational Consumer Choice',
        'assumes consumers are motivated by rational self-interest, have access to perfect information, and aim to maximize their utility based on their budget constraints.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Biases',
        'refer to the use of heuristics (mental shortcuts) in decision-making, which can lead consumers away from fully rational choices. Examples include rules of thumb, anchoring, availability bias, and framing.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Rationality',
        'refers to humans having limited cognitive ability, time, and imperfect information, which constrains rational decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Self-Control',
        'refers to humans’ limited self-control. Individuals may consume beyond the point their maximum utility. For example, eating chocolate while on a diet.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Bounded Selfishness',
        'refers to humans making decisions that consider the welfare of others, rather than only acting in their own self-interest (altruistic behavior).',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Imperfect Information',
        'occurs when economic agents do not have access to all relevant information, preventing fully rational decision-making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Nudge Theory',
        'is the study of how indirect suggestions can influence the behavior of individuals and groups.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Choice Architecture',
        'studies how the presentation of choices to consumers can influence decision making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Default Choice',
        'is the usual choice, or the choice if nothing is selected.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Restricted Choice',
        'is when consumers face a limited set of options.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Mandated Choice',
        'is when a consumer must choose between different options. ',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Rules of Thumb',
        'is an informal shortcut (heuristic) that simplifies decision-making',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Inertia',
        'refers to sticking with the usual or default choice.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Anchoring',
        'refers to comparing options to the first piece of information seen.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Framing',
        'refers to how the presentation of information affects decision making.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Availability Bias',
        'refers to overestimating the likelihood of recent or vivid events.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Corporate Social Responsibility (CSR)',
        'is when firms take responsibility for the social and environmental impacts of their business operations.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Satisficing',
        'is when an individual or firm settles for a satisfactory outcome rather than striving for the optimal one.',
      ),
      SlideContent.diagram(DiagramBundleEnum.microDemandExtension),
    ],
  ),
];
