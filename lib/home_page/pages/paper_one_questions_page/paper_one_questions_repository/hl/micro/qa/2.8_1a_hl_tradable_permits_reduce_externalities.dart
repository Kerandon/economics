// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainTradeablePermitsReduceExternalities10MarkHL = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl],
  question:
      'Explain how a system of tradeable permits could be used to reduce externalities caused by high levels of carbon emissions.',

  contents: [
    SlideContent.econTerms([
      EconTerm.negativeProductionExternality,
      EconTerm.tradablePermits,
    ]),
    SlideContent.text('''
<ul>
<li>A market-based scheme aiming to reduce the external costs to society caused by CO2 emissions (air pollution, effects of climate change).</li>
<li>Government sets a maximum (cap) on total carbon emissions (draw as perfectly inelastic supply).</li>
<li>Permits are issued/sold to firms allowing a fixed amount of emissions.</li>
<li>Firms can trade permits on a secondary-market. Internalizes cost by setting a market price to pollute.</li>
<li>Efficient / Incentive-based: Efficient firms gain by selling surplus permits. Inefficient firms face higher costs as need to buy additional permits.</li>
<li>Demand for permits decrease over-time as firms have incentive to substitute to cleaner energy sources.</li>
<li>Supply of permits reduced over time to further cut emissions.</li>
<li>Challenges: monitoring/measuring emissions, administrative costs, risk of under/overallocation.</li>
</ul>
'''),
    SlideContent.diagrams([
      DiagramEnum.microTradablePollutionPermits,
      DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease,
    ]),
  ],
);
