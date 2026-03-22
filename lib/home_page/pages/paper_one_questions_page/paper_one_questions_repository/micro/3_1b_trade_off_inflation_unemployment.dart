import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/term.dart';
import '../../paper_one_answer.dart';
import '../../paper_question.dart';

final tradeOffInflationAndUnemployment15Mark = PaperQuestion(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Using real-world examples, discuss the potential trade-off between unemployment and inflation.',
  answer: PaperOneAnswer(
    tldr: '''
    A trade off is likely only to exist in short-run (SRPC) only, the government can use demand-side policies to balance
    price stability and employment. In long-run there is less evidence for a trade-off. Consumers will rationally expect price level
    to adjust to output (resource prices are flexible), thus real wages remain unchanged. 
    Additionally, supply-shocks can cause higher price level AND higher unemployment (1970s oil-shock) (negative)
    And 1990s technology boom in US saw price stability and low-inflation (positive supply-shock).
        ''',
    terms: [],
  ),
);
