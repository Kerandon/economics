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

  /// Tariff
  Slide(
    section: Subunit.typesTradeProtection,
    title: 'Tariff',
    contents: [
      SlideContent.term('Tariff', '''
is a tax (known as a custom duty) imposed by a government on imported goods or services, usually
with the goal of protecting domestic industries from foreign competition and to raise tax revenue.

        '''),

      SlideContent.textWithDiagram('''
        <h3>Before the Tariff</h3>
<p>The world price (p<sub>W</sub>) is lower than the domestic price, so the domestic market is a net importer of the good.</p>

<p>Domestic consumers benefit from the low world price and consume from Q2 to 0. Only domestic producers who are more competitive than the world price can supply the domestic market (Q1 to 0). The remaining domestic demand is met by imports (Q4 to Q3).</p>

<h3>After the Tariff</h3>
<p>Once the tariff is imposed, the price of imported goods rises to (p<sub>W</sub> + T). The higher price causes domestic producers to expand supply along their supply curve from Q1/p<sub>W</sub> to Q3/(p<sub>W</sub> + T), reducing reliance on imports (Q3 - Q1).</p>

<p>At the same time, higher prices reduce consumer demand, moving up along the demand curve, so domestic sales decrease from Q2 to Q4.</p>

          ''', DiagramBundleEnum.globalTariff),
      SlideContent.textWithDiagram('''
      <h1>Welfare Analysis</h1>
      <p>Before the tariff,
      global resources are allocated as efficiently as possible.
      However, the imposition of a tariff causes a <strong>miss-allocation of global resources</strong>
   which results in a <strong>net welfare loss</strong> to society. 
   The social welfare impacts however are 
      unevenly distributed in the domestic market: domestic producers and government gain at the expense of 
      domestic consumers.  </p>
     
      ''', DiagramBundleEnum.globalTariffWelfare),

      SlideContent.textWithDiagram('''
      <h2>Consumer Surplus</h2>
        <em>(Net welfare loss)</em>
      <h3>Before the tariff</h3>
      <p>Consumers bought Q4-0 of the good. Total surplus is the  green plus grey areas.
      
      <h3>After the tariff</h3>
       <p>After the tariff the domestic price increases from Pw to Pw+t for
      domestic consumers and they buy less of the good. 
      This is shown as a <strong>contraction</strong>
      upwards on the domestic demand curve from Q4/Pw to Q3/Pw+t. 
      Total domestic sales are now Q3-0 
     The higher price causes the consumer surplus to shrink with the green area only representing the consumer surplus after the tariff.</p>
      ''', DiagramBundleEnum.globalTariffConsumerSurplusChange),
      SlideContent.textWithDiagram('''
      <h2>Producer Surplus</h2>
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
      ''', DiagramBundleEnum.globalTariffGovernmentRevenue),
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
      ''', DiagramBundleEnum.globalTariffWelfareLoss),
    ],
  ),

  /// Import Quota
  Slide(
    section: Subunit.typesTradeProtection,
    title: 'Import Quota',
    contents: [
      SlideContent.termWithContentAndDiagram(
        'Import Quota',
        'is a legal <strong>quantitative limit</strong> on the amount of a good'
            ' that can be imported into a country over a period of time (usually one year)',
        '''
              <p>An import quota is similar to a tariff in that
              it increases the price of the good in the domestic market, benefiting
              domestic producers while making consumers worse off.</p>
              
              <p>However, an import quota has one key distinction: unlike a tariff it <strong>does not</strong> generate 
              tax revenue for the government. </p>
              <h1>Import Quota Diagram</h1>
              <p>Like the tariff diagram, the domestic market is a net importer 
              (shown by the Pw/Sw horizontal curve drawn below where Sd and Dd intersect).
              After the import quota is applied, <strong>a new supply curve</strong> is created. 
              The new supply curve is domestic supply <strong>plus</strong> the fixed quota which
              can be imported. 
              To draw this new supply curve, add the quota amount to the right of the domestic
              supply curve (shifting horizontally right).
              Where this new supply curve (Sd+q) intersects with domestic demand (Dd)
              determines the new domestic market price and quantity.

              
              </p>
                  ''',
        DiagramBundleEnum.globalImportQuota,
      ),
      SlideContent.alert(
        'The Sd+q curve should not cross under the Pw/Sw curve, '
        'because foreign exporters would not sell their good below the world price.',
      ),
      SlideContent.tip('''
        A government may grant foreign exporters the import quota licenses. 
        In this case, foreign exporters benefit from the higher price, 
        even though the quantity they can sell is restricted. 
        This is why an import quota is often considered a less aggressive 
        form of trade protectionism compared to a tariff, '
            'where foreign exporters do not gain from the higher price.
            '''),
      SlideContent.textWithDiagram('''
<h1>Welfare Analysis</h1>
<p>Like the welfare effects of a tariff, domestic producers gain due to the higher domestic price
and producer surplus increases, 
while domestic consumers are worse off who now face a higher domestic price and consumer surplus decreases. 
However, unlike a tariff the government does not gain tax revenue. This rectangle area in the center of 
the diagram (Q3 - Q2) X (Pw+q - Pw), which is tax revenue under a tariff diagram, is now lost to 
society. Society loses overall as the total social surplus is smaller.
</p>
''', DiagramBundleEnum.globalImportQuotaWelfare),

      SlideContent.textWithDiagram('''
  <h3>Consumers</h3>
  
        <em>(Net welfare loss)</em>
  <p>Domestic consumers lose out. Before the tariff, they benefited from free-trade and the low world price (Pw),
  importing Q4-0. After the import quota, the restricted supply pushes up the domestic price, and there is a
  contraction in domestic demand from Pw/Q4 to Pw+q/Q3, which results in a decrease in consumer surplus.</p> 
  ''', DiagramBundleEnum.globalImportQuotaConsumerSurplusChange),

      SlideContent.textWithDiagram('''
  <h3>Producers</h3>
  
        <em>(Net welfare gain)</em>
  <p>Domestic producers in the protected industry gain. Before the import quota, only the most efficient domestic
  producers could compete with the low world price (Pw) selling only Q1-0.
  After the restriction in imports, the domestic market price increases to Pw+q and 
  domestic producers increase their sales from Q1-0 to Q2-0, increasing total producer surplus.</p> 
  ''', DiagramBundleEnum.globalImportQuotaConsumerSurplusChange),
      SlideContent.textWithDiagram('''
  <h3>Social Welfare Loss (Dead-Weight Loss)</h3>
 
  <p>An import quota creates an relatively large area of dead-weight loss compared to a tariff, which can
  be separated into three areas on the diagram, all of which represent <strong>lost consumer surplus</strong>:</p>
<ul>
    <li><strong>Left triangle (inefficiency in production):</strong> Like a tariff, inefficient 
    domestic producers replace efficient foreign exporters (Q2-Q1) X (Pw+q - Pw).</li>
  <li><strong>Middle rectangle (not picked up by government):</strong> Unlike a tariff, this rectangle (Q3-Q2) X (Pw+q - Pw) 
  is lost to society because it is
  not picked up by the government in the form of tax revenue.</li>
 <strong>Right triangle (loss of consumption):</strong> This consumer surplus (Q4-Q3) X (Pw+q - Pw) 
 is caused by the market shrinking in size by Q4-Q3.
  </li>


  </li></ul>
  </p> 
  ''', DiagramBundleEnum.globalImportQuotaWelfareLoss),
    ],
  ),
  Slide(
    section: Subunit.typesTradeProtection,
    title: 'Production Subsidy',
    contents: [
      SlideContent.termWithContentAndDiagram(
        'Production Subsidy',

        '''A payment made by the government to domestic producers for each unit of output, aimed at helping domestic firms compete with imported goods.
''',
        '''
        <h1>Production Subsidy Diagram</h1>
        <p>
        The diagram assumes the domestic market is a net importer of the good, with world price (Pw) below 
        where Sd and Dd intersect.
        Like a subsidy diagram in microeconomics, draw a new supply curve under the existing one (the vertical 
        distance being the size of the subsidy per unit). 
        Important to note that the world price hasn't changed, only that domestic producers are now more 
        competitive and can sell more at the world price (extending from Q1 to Q2).
        </p>
        ''',
        DiagramBundleEnum.globalProductionSubsidy,
      ),
      SlideContent.textWithDiagram(
      '''
      <h3>Welfare Analysis</h3>
      Like all forms of trade protectionism, domestic producers gain, however, 
      unlike tariffs, import quotas or export subsides, <strong>consumers are not worse off</strong> because
      they are able to continue to buy the same quantity at the world price.
      Society overall still loses however as the government must use tax revenue to pay for the subsidy,
      resulting in a <strong>dead-weight loss</strong>.
      <p>Note consumer surplus crosses over with 
      the gain in producer surplus (section above Pw) and the dead-weight loss (between Q2 - Q1).</p>
      ''',
      DiagramBundleEnum.globalProductionSubsidyWelfare,
      ),SlideContent.tip('''
      Unlike a tariff, import quota or export subsidy, a production subsidy <strong>does not</strong>
    is the only trade barrier where consumers are not made worse off. 
    Consumers continue to the good at the same world price, although they
    increase the share of domestic purchases and decrease their purchase of imports.
      '''),
      SlideContent.textWithDiagram(
        '''
      <h3>Consumer Surplus</h3>
<p>Because a production subsidy does not change the market price consumer surplus is unchanged. 
Consumers continue to purchase the good at the world price Pw,
although they switch from spending Q2-Q1 on imported goods to domestic goods.</p>
      ''',
        DiagramBundleEnum.globalProductionSubsidyConsumerSurplus,
      ),
      SlideContent.textWithDiagram(
      '''
      <h3>Producer Surplus</h3>
      The subsidy lowers the costs of production and therefore increases their ability to compete
      with imports, increasing producer surplus.
      ''',
      DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange,),
      SlideContent.textWithDiagram(
        '''
      <h3>Government Expenditure</h3>
  <p>The government needs to fund all domestic production. 
  This is calculated by (Q2 - 0) X (Pw+Sub - Pw). Because the government must use public funding
  to pay for this subsidy it is counted as a welfare loss for society.</p>
  
      ''',
        DiagramBundleEnum.globalProductionSubsidyWelfareLoss,
      ),
      SlideContent.textWithDiagram(
        '''
      <h3>Dead-Weight Loss</h3>
  <p>Because the government needs to use taxpayer revenue to pay for the subsidy it a 
  creates a dead-weight loss, represented increased production by relatively inefficient domestic firms 
  from Q2 - Q1.</p><p>
  The entire rectangle is a loss for society because the public needs to pay for it.
  However, the area above Sd curve (between Pw and P _ Sub) is new producer surplus.
  </p>
  
      ''',
        DiagramBundleEnum.globalProductionSubsidyWelfareLoss,
     ),
    ],
  ),
];
