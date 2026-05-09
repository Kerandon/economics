// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainTradeablePermitsReduceExternalities10MarkHL = Slide(
  subunit: Subunit.marketFailureMarketPower,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain how a system of tradeable permits could be used to reduce externalities caused by high levels of carbon emissions.',
  contents: [
    SlideContent.econTerms([
      EconTerm.negativeProductionExternality,
      EconTerm.tradablePermits,
    ]),
    SlideContent.text('''
<ul>
  <li>A market-based scheme (Cap and Trade) aiming to reduce the external costs to society caused by CO2 emissions (e.g., air pollution, climate change).</li>
  <li>Government sets a maximum (cap) on total carbon emissions.</li>
  <li>Permits are issued or sold to firms, allowing a fixed amount of emissions per permit.</li>
  <li>Firms can trade permits on a secondary market, which <b>internalizes the externality</b> by setting a market price to pollute.</li>
  <li><b>Reducing the externality:</b> The cost of buying permits increases a firm's costs of production, shifting their MPC towards MSC, reducing output to a more socially optimum level.</li>
  <li><b>Incentive-based:</b> Efficient firms gain by selling surplus permits. Inefficient firms face higher costs as they need to buy additional permits.</li>
  <li>Demand for permits decreases over time as firms have an incentive to substitute to cleaner energy sources.</li>
  <li>Supply of permits can be reduced by the government over time to further cut emissions.</li>
  <li><b>Challenges:</b> Monitoring/measuring emissions, administrative costs, and the risk of under/over-allocation of permits.</li>
</ul>
<p>Diagrams: A diagram showing the external cost of production. And diagrams showing the market for tradeable permits. Diagram can show the government decreasing supply and/or demand falling as firms substitute to clean energy sources.</p>
'''),
    SlideContent.diagrams([DiagramEnum.microNegativeProductionExternality]),
    SlideContent.diagrams([
      DiagramEnum.microTradablePollutionPermits,
      DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease,
    ]),
  ],
);
