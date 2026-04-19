// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
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
      EconTerm.sustainableDebt,
      EconTerm.crowdingOut,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
    <p>Government debt refers to the accumulation of past budget deficits (tax revenue is less than government spending in one year).</p>
    <p>Debt can be measured by the <strong>debt-to-GDP ratio = (debt / GDP) × 100.</strong></p>
    <p><strong>Sustainable debt</strong> is beneficial as it funds merit goods, infrastructure, and supports the economy during a deflationary gap.</p>
    <p><strong>Unsustainable debt</strong> refers to high debt that is not manageable without significant costs to society.</p>
    <p>A major cost of unsustainable debt is that the government will either need to make steep cuts in future fiscal spending or implement significant increases in tax. Therefore, a major consequence of unsustainable debt is lower long-term economic growth.</p>
    <p>Another major cost is that interest rates might increase to attract borrowers. This acts as contractionary monetary policy and is another drag on the economy.</p>
    <p>Very high levels of debt cannot be repaid even with tax increases, and this can lead to sovereign risk default. This can result in a long-term negative impact on a country's economic growth.</p>
    '''),
  ],
);
