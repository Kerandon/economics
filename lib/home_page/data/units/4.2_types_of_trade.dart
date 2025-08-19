import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get typesOfTradeProtectionSlides => [
  /// 'Definition & Types of Protection',
  Slide(
    section: Subunit.typesTradeProtection,
    title: 'Definition & Types of Protection',
    contents: [
      SlideContent.term('Trade Protectionism', '''
        Government policies that restrict international trade to support domestic industries.
        '''),

      SlideContent.key('Forms of Trade Protectionism', '''
        <ul>
  <li>Tariffs (customs duties)</li>
  <li>Import quotas</li>
  <li>Production subsidies</li>
  <li>Export subsidies</li>
  <li>Administrative barriers</li>
</ul>
        '''),
    ],
  ),
  Slide(
    section: Subunit.typesTradeProtection,
    title: 'Tariff',
    contents: [
      SlideContent.term('Tariff', '''
is a tax (known as a custom duty) imposed by a government on imported goods or services, usually
with the goal of protecting domestic industries from foreign competition and to raise tax revenue.

        '''),
      SlideContent.text('''
      <h2>Welfare Analysis</h2>
      <p>Before the tariff,
      global resources are allocated as efficiently as possible.
      However, the imposition of a tariff causes a <strong>miss-allocation of global resources</strong>
   which results in a <strong>net welfare loss</strong> to society. 
   The social welfare impacts however are 
      unevenly distributed in the domestic market: domestic producers and government gain at the expense of 
      domestic consumers.  </p>
      
      ''',
      ),

      SlideContent.textWithDiagram('''
      <h2>Consumer Surplus</h2>
        <em>(Net welfare loss)</em>
      <h3>Before the tariff</h3>
      <p>Consumers bought Q4-0 of the good. Total surplus is the  green plus grey areas.
      This is shown as a <strong>contraction</strong>
      upwards on the domestic demand curve from Q4/Pw to Q3/Pw+t. 
      Total domestic sales are now Q3-0 
      <h3>After the tariff</h3>
       <p>After the tariff the domestic price increases from Pw to Pw+t for
      domestic consumers and they buy less of the good. 
     The green area is the consumer surplus after the tariff,
      And the grey area is lost consumer surplus.</p>
      ''', DiagramBundleEnum.globalTariffConsumerSurplusChange),
      SlideContent.textWithDiagram('''
      <h2>Producer Surplus</h3>
  <em>(Net welfare gain)</em>
      <h3>Before the tariff</h3>
      <p>Only the most efficient domestic producers who are below the 
      world price (pW) can compete and sell the good domestically (Q1-0).
      (This is the part of the Sd curve which is under the Pw/Sw curve).
      Domestic surplus is small (blue area only).
      </p>
          <h3>After the tariff</h3>
          <p>The domestic price increases from Pw to Pw+t and domestic producers
          can now better compete with imports. Domestic producers expand upwards on the supply curve
          and increase production by Q3 to Q2. 
          Domestic surplus grows and now equals blue area plus the new green area.</p>
      ''', DiagramBundleEnum.globalTariffProducerSurplusChange),
      SlideContent.textWithDiagram('''
           <h2>Government Revenue</h3>

        <em>(Net welfare gain)</em>
        <p>
        After the tariff is imposed, the government collects tax revenue on
        all imported goods (Q3-Q2) X (Pw+t-Pw).</p>
        <p>This represents a welfare gain because the tax revenue 
        can be used by governments to benefit the public.</p>
      ''',
          DiagramBundleEnum.globalTariffGovernmentRevenue),
      SlideContent.textWithDiagram('''
       <h2>Welfare Loss</h2>
       <p>While the gains and losses are mixed, the imposition of a tariff results in an overall net-loss to society, 
       represented by two areas:</p>
       <ul><li><strong>Left triangle (inefficiency in production):</strong>
       Q2-Q1, domestic supply, once imported from efficient world producers,
       is now supplied by more inefficient domestic producers at a higher price.
       The area under the Ds curve from Q2-Q1, (previously consumer surplus), is lost and not gained by anyone.
       </li>
<li><strong>Right triangle (decreased consumption):</strong>
    After the tariff domestic consumption shrinks the whole market by Q4-Q3, reducing consumer surplus - and social surplus as it is not gained by anyone.
     
       </li></ul>
      ''',
          DiagramBundleEnum.globalTariffWelfareLoss),
      SlideContent.textWithDiagram('''
        <h3>Before the Tariff</h3>
<p>The world price (p<sub>W</sub>) is lower than the domestic price, so the domestic market is a net importer of the good.</p>

<p>Domestic consumers benefit from the low world price and consume from Q2 to 0. Only domestic producers who are more competitive than the world price can supply the domestic market (Q1 to 0). The remaining domestic demand is met by imports (Q4 to Q3).</p>

<h3>After the Tariff</h3>
<p>Once the tariff is imposed, the price of imported goods rises to (p<sub>W</sub> + T). The higher price causes domestic producers to expand supply along their supply curve from Q1/p<sub>W</sub> to Q3/(p<sub>W</sub> + T), reducing reliance on imports (Q3 - Q1).</p>

<p>At the same time, higher prices reduce consumer demand, moving up along the demand curve, so domestic sales decrease from Q2 to Q4.</p>

          ''', DiagramBundleEnum.globalTariff),
    ],
  ),
];
