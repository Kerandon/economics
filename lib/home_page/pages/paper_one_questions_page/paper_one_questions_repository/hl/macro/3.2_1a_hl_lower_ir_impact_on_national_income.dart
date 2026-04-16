import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart';
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final explainLowerIRImpactOnNationalIncome1aHL = Slide(
  subunit: Subunit.aDAS,
  tags: [Tag.hl, Tag.p1a],
  question: 'Explain how a decrease in interest rates is likely to affect the equilibrium level of national income.',
  contents: [

    SlideContent.econTerms([
      EconTerm.interestRates,
      EconTerm.nationalIncome,
      EconTerm.equilibriumNationalIncome,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
<ul>
<li>A decrease in interest rates reduces the cost of borrowing for consumers, increasing consumption as credit (e.g. loans and mortgages) becomes cheaper.</li>
<li>It also reduces the incentive to save, increasing spending from household income and raising consumption (C).</li>
<li>Lower interest rates reduce borrowing costs for firms, increasing the expected rate of return on investment.</li>
<li>This encourages higher investment (I), further increasing AD and equilibrium national income.</li>
<li>This leads to an increase in aggregate demand (AD = C + I + G + (X − M)), shifting AD to the right and raising equilibrium national income.</li>
</ul>

<ul>
<h3>Extra:</h3>
<li>In the Keynesian model, if there is spare capacity, an increase in AD can raise real output with limited inflation.</li>
<li>In the monetarist/new classical model: lower interest rates only change macro-equilibrium in the short-run. In the long run, nominal resource prices adjust causing real national income to be unchanged.</li>
</ul>
'''),
    SlideContent.diagrams([
      DiagramEnum.macroAggregateDemandInflationTradeOff,
      DiagramEnum.macroADASKeynesianSpareCapacity,
    ]),
    SlideContent.diagrams([
      DiagramEnum.macroClassicalInflationaryGapAdjustment,
    ]),
  ],
);