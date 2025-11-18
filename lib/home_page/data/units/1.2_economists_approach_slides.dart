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
        'Cardinal Utility',
        'Assigns numerical values to measure utility. For example: Good A = 15 utils, Good B = 25 utils, Good C = 5 utils.',
      ),
      SlideContent.term(
        'Ceteris Paribus',
        'A Latin phrase that translates to "all else being equal".',
      ),
      SlideContent.term(
        'Classical Economics',
        'Economic theories dominant in the 19th century emphasizing self-regulation of markets to allocate resources efficiently.',
      ),
      SlideContent.term(
        'Empirical Evidence',
        'Evidence gathered from the real world.',
      ),
      SlideContent.term(
        'Hypothesis',
        'An assumption or proposition made prior to research.',
      ),
      SlideContent.term(
        'Laissez-Faire',
        'A French term meaning "let do, let be"; refers to minimal government intervention, where free markets drive competition and efficiency.',
      ),
      SlideContent.term('Law', 'A statement that is universally true.'),
      SlideContent.term(
        'Logic',
        'The use of reasoning to draw valid conclusions.',
      ),
      SlideContent.term(
        'Models',
        'Simplified frameworks used to illustrate economic theories and laws.',
      ),
      SlideContent.term(
        'Normative Economics',
        'The study of "what should be", involving value-based judgments about economic issues that cannot be proven right or wrong.',
      ),
      SlideContent.term(
        'Ordinal Utility',
        'Measures utility by ranking preferences. For example: Good B > Good A > Good C.',
      ),
      SlideContent.term(
        'Positive Economics',
        'The study of "what is", focusing on factual and objective analysis of economic phenomena that can be tested.',
      ),
      SlideContent.term(
        'Rationality',
        'Assumes humans act out of rational self-interest, making logical and consistent decisions to maximize benefit or profit.',
      ),
      SlideContent.term(
        'Refutation',
        'The process of disproving a statement or theory.',
      ),
      SlideContent.term(
        'Say\'s Law',
        'States that "supply creates its own demand". Production generates income, which enables spending.',
      ),
      SlideContent.term(
        'Theory',
        'A generalized explanation of economic phenomena based on models and empirical evidence.',
      ),
      SlideContent.term(
        'Utility',
        'The satisfaction or benefit gained from consuming a good or service.',
      ),
    ],
  ),
];
