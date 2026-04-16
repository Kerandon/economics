import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart';
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final explainNRUPaper1aHL = Slide(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question: 'Explain the natural rate of unemployment.',
  contents: [

    // 2. Definitions / Terms (Updated from the micro terms!)
    SlideContent.econTerms([
      EconTerm.nru,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
    <ul>
    <li>The NRU is the sum of structural, seasonal, and frictional unemployment.</li>
    <li>When the economy is in long-run macroeconomic equilibrium, it is operating at <strong>full employment</strong>. The actual rate of unemployment equals the NRU. There is zero cyclical unemployment (demand-deficit unemployment)</li>
    <li>The NRU is determined by supply-side factors in the labor market. E.g., structural unemployment is caused by a skills mismatch, geographic immobility, labor market rigidities such as excessive employment regulations; frictional unemployment is when workers are between jobs.</li>
    </ul>
  
    '''),
    SlideContent.diagrams([
      DiagramEnum.macroBusinessCycleNRU,
      DiagramEnum.macroSRPC,
      DiagramEnum.macroNaturalRateOfUnemployment,
    ]),
  ],
);