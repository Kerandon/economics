// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainImportanceOfSustainableDebt10Mark = Slide(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain why a sustainable level of government (national) debt is an important macroeconomic objective.',
  contents: [
    SlideContent.econTerms([
      EconTerm.debtToGDPRatio,
      EconTerm.budgetDeficit,
      EconTerm.nationalDebt,
      EconTerm.unsustainableDebt,
      EconTerm.crowdingOut,
    ]),
    SlideContent.text('''
      <p>Important to focus on meaning of <strong>'sustainable'</strong>. Sustainable debt can be beneficial to macroeconomic objectives of economic growth, employment and price stability - government can borrow to invest in merit goods and capital infrastructure to increase potential output.</p> 
      <p>Unsustainable government debt has high opportunity costs and reduces long-term economic growth through higher interest payments, crowding out of private investment, and reduced fiscal flexibility.</p>
      <p>A falling debt-to-GDP ratio indicates debt is cecomimng .</p>
      '''),
    SlideContent.simpleTable(
      title: 'Sustainable vs Unsustainable Debt',
      headers: ['Benefits of Sustainable Debt', 'Costs of Unsustainable Debt'],
      data: [
        [
          'Funds merit goods & infrastructure',
          'High debt servicing (interest opportunity cost)',
        ],
        [
          'Government spending supports AD in recession.',
          'Opportunity cost in future: Higher T, Lower G.',
        ],
        [
          'Promotes long-term economic growth',
          'Crowding out of private investment',
        ],
        [
          'Maintains investor confidence',
          'Higher interest rates / poor credit ratings',
        ],
        [
          'Stable debt-to-GDP ratio (manageable)',
          'Risk of sovereign default / debt trap',
        ],
        [
          'Greater fiscal flexibility in future',
          'Reduced fiscal space in recessions',
        ],
        ['', 'Capital flight & lower FDI'],
        [
          '',
          'Inflation risk (monetising debt - central bank buys government bonds increasing money supply)',
        ],
        ['', 'Exchange rate risk (external debt)'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.macroCrowdingOut]),
    SlideContent.diagrams([DiagramEnum.macroClassicalLongTermGrowth]),
  ],
);
