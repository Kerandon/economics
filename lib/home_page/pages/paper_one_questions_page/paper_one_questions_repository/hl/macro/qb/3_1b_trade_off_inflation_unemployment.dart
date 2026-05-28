import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final tradeOffInflationAndUnemployment15Mark = Slide(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Using real-world examples, discuss the potential trade-off between unemployment and inflation.',
  contents: [
    SlideContent.econTerms([
      EconTerm.nru,
      EconTerm.unemployment,
      EconTerm.inflation,
    ]),

    SlideContent.text('''
<h3>Theory:</h3>
<ul>
  <li>Product markets: higher real output raises price levels. Labor market: unemployment falls as a <strong>derived demand</strong>.</li>
  
  <li>Short-run trade-off (SRPC): demand-side stabilization policies balance conflicting goals of low inflation and low unemployment.</li>
  
  <li>Long-run relationship breaks down; LRPC/LRAS is vertical.</li>
  
  <li>Expansionary policies create short-run inflationary gaps (Ye > Yp, U < NRU).</li>
  
  <li>Falling real wages (expected < actual inflation) create labor shortages. Workers demand higher nominal wages, raising production costs. SRPC shifts outward, restoring full employment equilibrium (Ye = Yp, U = NRU, actual = expected inflation).</li>
  
  <li>Example: US Covid-19 stimulus lowered unemployment but caused persistently high inflation.</li>
</ul>

<h3>Supply Shocks:</h3>
<ul>
  <li>Negative shock: 1973-1974 oil crisis (OPEC) caused stagflation in USA (high inflation and high unemployment).</li>
  
  <li>Positive shock: 1990s US economic boom brought low inflation and high real output.</li>
</ul>

<h3>Other:</h3>
<ul>
  <li>Short-run capital investment yields long-run supply-side improvements.</li>
  
  <li>Long-run adjustment is costly as inflation expectations adapt (e.g., post-Covid inflation).</li>
  
  <li>Keynesian theory: little to no trade-off during severe recessions (e.g., initial Covid-19 stimulus).</li>
  
</ul>
'''),

    SlideContent.diagrams([
      DiagramEnum.macroSRPC,
      DiagramEnum.macroAggregateDemandInflationTradeOff,
    ]),
    SlideContent.diagrams([
      DiagramEnum.macroSRPCCostPushInflation,
      DiagramEnum.macroSRASCostPushInflation,
    ]),
    SlideContent.diagrams([
      DiagramEnum.macroExpectationsAugmentedPhillipsCurveInflationaryGap,
      DiagramEnum.macroClassicalInflationaryGapAdjustment,
    ]),
    SlideContent.diagrams([DiagramEnum.macroADASKeynesianSpareCapacity]),
    SlideContent.realWorldExamples([
      RealWorldExamples.tradeOffInflationUnemployment,
    ]),
  ],
);
