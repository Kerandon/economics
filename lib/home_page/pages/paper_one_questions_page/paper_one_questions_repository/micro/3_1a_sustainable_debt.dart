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

final importanceOfSustainableDebt10Mark = PaperQuestion(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question:
  'Explain why a sustainable level of government (national) debt is an important macroeconomic objective.',
  answer: PaperOneAnswer(
    tldr:
    'Manageable government debt is beneficial as fund merit goods and infrastructure to increase LRAS and/or spending in deflationary gap. '
        'Unsustainable debt which requires large opportunity costs:'
        'debt servicing of high interest means higher future taxation, lower government spending, lower credit ratings, higher future interest rates to attract lenders,'
        'crowding out, debt in foreign currency and exchange rate risk, sovereign risk-default, debt-trap.'
        '',
    terms: [EconTerm.monopolisticCompetition, EconTerm.oligopoly],
    explanation: [SlideContent.text('''
    <p>Government debt refers to accumulation of past budget deficits (tax revenue is less than government spending in one year).
   <p> Debt can be measured by <strong>debt to GDP ration (debt / GDP) X 100.</strong></p>
    </p>
    <p><strong>sustainable debt</strong> is beneficial as it funds merit goods, infrastructure and during deflationary gap.</p>
    <p><strong>unsustainable debt</strong> refers to high debt that is not manageable without signficant costs to society.</p>
    <p>A major cost of unsustainable debt is the government will either need to make steep cuts in future fiscal spending or signfiicant increases in tax.
    There a major cost of unsustainable debt is lower long-term economic growth.</p>
    <p>Another major cost is interest rates might increase to attact borrowers. This is contractionary monetary policy and another cost</p>.
    <p>Very high levels of debt cannot be repaid even with tax increases, and this can lead to sovereign risk default.
    This can result in long-term negative impact to a country's economic growth</p>
    '''
    ),],
  ),
);
