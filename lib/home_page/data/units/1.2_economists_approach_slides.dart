import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/models/slide_content.dart';

import '../../models/slide.dart';
import '../../models/term.dart';

List<Slide> get economistsApproach => [
  Slide(
    section: Subunit.economistsApproach,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Positive Economics',
        'is the study of "what is", focusing on factual and objective analysis of economic phenomena that can be tested.',
      ),
      SlideContent.term(
        'Normative Economics',
        'is the study of "what should be", involving value-based judgments about economic issues that cannot be proven right or wrong.',
      ),
      SlideContent.term(
        'Ceteris Paribus',
        'is a Latin phrase that translates to ‘all else being equal’.',
      ),
      SlideContent.term(
        'Hypothesis',
        'is an assumption or proposition made prior to research.',
      ),

      SlideContent.term(
        'Empirical Evidence',
        'refers to evidence gathered from the real world.',
      ),

      SlideContent.term(
        'Refutation',
        'is the process of disproving a statement or theory.',
      ),

      SlideContent.term(
        'Logic',
        'is the use of reasoning to draw valid conclusions.',
      ),

      SlideContent.term(
        'Law',
        'refers to a statement which is universally true.',
      ),

      SlideContent.term(
        'Theory',
        'is a generalized explanation of economic phenomena based on models and empirical evidence.',
      ),

      SlideContent.term(
        'Models',
        'are simplified frameworks used to illustrate economic theories and laws.',
      ),

      SlideContent.term(
        'Classical Economics',
        'refers to economic theories dominant in the 19th Century which emphasized the self-regulation of markets to efficiently allocate resources.',
      ),
      SlideContent.term(
        'Rationality',
        'assumes that humans act out of rational self-interest, making logical and consistent decisions to maximize benefit or profit.',
      ),

      SlideContent.term(
        'Laissez-Faire',
        'a French term meaning "let do, let be"; refers to minimum government intervention, where free markets drive competition and efficiency.',
      ),
      SlideContent.term(
        'Utility',
        'is the satisfaction or benefit gained from consuming a good or service.',
      ),
      SlideContent.term(
        'Ordinal Utility',
        'measures utility by ranking of preferences. For example: Good B > Good A > Good C.',
      ),

      SlideContent.term(
        'Cardinal Utility',
        'assigns numerical values to measure utility. For example: Good A = 15 utils, Good B = 25 utils, Good C = 5 utils.',
      ),
      SlideContent.term(
        'Say\'s Law',
        'states that ‘supply creates its own demand’. This implies that production generates income, which enables spending.',
      ),
    ],
  ),
];
