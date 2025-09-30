import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';
import 'package:flutter/material.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get benefitsOfInternationalTradeSlides => [
  Slide(
    section: Subunit.benefitsTrade,
    title: 'International Trade',
    contents: [
      SlideContent.term('International Trade', '''
        refers to the exchange of goods and services across national borders.
      '''),
      SlideContent.term('Free Trade', '''
        is international trade without government restrictions such as tariffs or quotas.
      '''),

      SlideContent.textWithDiagram('''
        <h2>The World Market</h2>
        World price (**Pw**) is determined by global supply and demand.
        Countries are <strong>price takers</strong> because they are small compared to the world market.
      ''', DiagramBundleEnum.globalWorldPriceStandAlone),

      SlideContent.tip('''
        If a country was in <strong>autarky</strong>, price is set by domestic supply and demand.
        With trade, the price is set by the world price (**Pw**).
      '''),

      SlideContent.textWithDiagram('''
        <h2>Domestic Market with World Price</h2>
        - World supply is drawn as <strong>perfectly elastic</strong> (horizontal line) at Pw.
        - Country can import or export at Pw.
        - Actual domestic price = Pw.
        - If Pw < domestic price → <strong>net importer</strong>.
        - If Pw > domestic price → <strong>net exporter</strong>.
      ''', DiagramBundleEnum.globalNetImporter),

      SlideContent.textWithDiagram('''
        <h3>Net Exporter</h3>
        If Pw is <strong>higher</strong> than domestic price, producers export at Pw.
        Domestic price rises to Pw. Only consumers who can pay Pw buy the good.
      ''', DiagramBundleEnum.globalNetExporter),

      SlideContent.term('Gains from Trade', '''
        Benefits from engaging in international trade, shown by increases in consumer and producer surplus.
      '''),

      SlideContent.key('Benefits from Free Trade', '''
        <ul>
          <li>Lower prices</li>
          <li>Greater choice</li>
          <li>Increased competition</li>
          <li>Access to resources</li>
          <li>Economies of scale</li>
          <li>Access to larger markets</li>
          <li>Efficient resource allocation</li>
        </ul>
      '''),
    ],
  ),

  Slide(
    section: Subunit.benefitsTrade,
    title: 'Comparative Advantage',
    hl: true,
    contents: [
      SlideContent.term('Absolute Advantage', '''
        When a country can produce more of a good using fewer resources.
      '''),

      SlideContent.text('''
        In the example below:
        - France has an <strong>absolute advantage</strong> in wine.
        - Spain has an <strong>absolute advantage</strong> in cheese.
      '''),

      SlideContent.customWidget(
        _paintFranceSpainTable(
          ['135', '15', '105', '21'],

          bold: [true, false, false, true],
        ),
      ),

      SlideContent.diagram(
        DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods,
      ),
      SlideContent.tip('''
        When linear PPCs cross each country has an
        absolute advantage in one good. 
      
        '''),
      SlideContent.text('''
        <h3>Comparative Advantage</h3>
        <p>
        In the below table France has an absolute advantage in <strong>both</strong>
        goods.  
        However, as long as the two countries have different <strong>
        opportunity costs</strong> to produce each good, 
        it is still beneficial for each country to specialize and trade. This is explained by the 
        the theory of <strong>comparative advantage</strong>.
        </p>
        '''),
      SlideContent.term('Comparative Advantage', '''
        When a country can produce a good at a lower <strong>opportunity cost</strong> than another country.
      '''),
      SlideContent.diagram(DiagramBundleEnum.globalAbsoluteAdvantageBothGoods),
      SlideContent.customWidget(
        _paintFranceSpainTable(
          ['120', '18', '105', '9'],
          bold: [true, true, false, false],
        ),
      ),
      SlideContent.text('''
      <h3>Calculating Comparative Advantage</h3>
        <p>To work out comparative advantage, 
        you need to first work out the <strong>opportunity cost</strong> for each country
        to produce each good. This is done by calculating: </p> 
        <p><strong>What is given up / What is gained</strong></p>
        <p>If France used all its available labor
        to produce only cheese, it would <strong>not</strong> make 18 bottles of wine. 
         18 / 120 = it would cost France
         0.15 bottle of wine for each one kg of Cheese.</p>
         <p>The flip side is just the opposite, 
        France would miss out on 120kg of Cheese production if all its workers only made wine. 120 / 18
    means it costs France 6.67kg of Cheese for each bottle of wine it makes.</p>
         <p>It is handy to draw the opportunity costs in the table like below
         </p>
        '''),
      SlideContent.customWidget(
        _paintFranceSpainTable(
          ['120\n(0.15)', '18\n(6.67)', '105\n(0.09)', '9\n(11.67)'],
          bold: [false, true, true, false],
        ),
      ),
      SlideContent.diagram(DiagramBundleEnum.globalAbsoluteAdvantageBothGoods),
      SlideContent.text('''
<h3>Terms of Trade</h3>
       <ul>
       <li>
       France and Spain agree to specialize in their comparative advantage and trade. Now, an exchange 
       ratio needs to be agreed.
       <strong>An acceptable exchange will always a number between the two opportunity costs for each good.</strong></li>
       <li>For cheese, France is the <strong>buyer</strong> and Spain is the <strong>seller</strong>.
       France would not be willing to trade more than 0.15 bottles of wine for 1 kg of cheese - otherwise
       it is more worthwhile to just use one of its wine workers to make cheese instead. 
       Likewise, Spain would want more than 0.09 bottles of wine for each kg of cheese it sells, otherwise 
       it will just use one of its cheese workers to make wine instead.</li> 
       </li>
       <li>
       Let's say a trade of <strong>1kg of cheese for 0.12 bottles of wine</strong> is agreed.
       This exchange just needs to be flipped to get the opposite trade. 1 / 0.12 = 
        <strong>one bottle of wine trades for 8.33kg</strong> of Cheese. This exchange will always fit
        between the opportunity costs for the other good (e.g. 8.33 is greater than 6.67 and less than 11.67). 
       </li>
       </ul>
       <h3>Consuming outside of PPC</h3>
       
      <ul><li>In theory, France could trade <strong>all</strong> of its wine for cheese. France
      could now consume 150kg of cheese (18 bottles X 8.33kg).
      Likewise, Spain buy about 12 bottles of wine (105kg X 0.12 bottles) if it sold all of its cheese. 
      The <strong>increased consumption possibilities</strong> is shown by the dotted lines on the diagram.
        </ul>
       
        '''),
      SlideContent.diagram(
        DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption,
      ),
      SlideContent.text('''
       <p>It is more likely that Spain and France want
       to consume a mix of each goods. 
       Therefore, let's assume France keeps 10 bottles of wine
       and trades the other 8 bottles for cheese.
     8 bottles of wine at the trade ratio of 8.33kg of Cheese results in total imports of approx. 67 kg of Cheese.
     Spain imports 8 bottles of wine for 67kg of Cheese (120kg - 67kg) leaving 53kg of cheese remaining.
     
       
        </p>
        '''),
      SlideContent.customWidget(
        _paintFranceSpainTable(
          ['67', '10', '53', '8'],
          bold: [false, false, false, false],
          title:
              'Wine & Cheese Consumption\n'
              '(With Trade)',
        ),
      ),
      SlideContent.diagram(
        DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumptionMixed,
      ),
    ],
  ),
];

Widget _paintFranceSpainTable(
  List<String> values, {
  required List<bool> bold,
  String? title,
}) {
  return SimpleTable(
    title: title ?? 'Wine & Cheese Production\n(Per Worker Each Day)',
    headers: ['', 'Cheese (kg)', 'Wine (bottles)'],
    data: [
      ['France', values[0], values[1]],
      ['Spain', values[2], values[3]],
    ],
    cellStyles: [
      [
        TextStyle(color: Colors.deepOrange),
        TextStyle(
          color: Colors.deepOrange,
          fontWeight: bold[0] ? FontWeight.bold : null,
        ),
        TextStyle(
          color: Colors.deepOrange,
          fontWeight: bold[1] ? FontWeight.bold : null,
        ),
      ],
      [
        TextStyle(color: Colors.deepPurple),
        TextStyle(
          color: Colors.deepPurple,
          fontWeight: bold[2] ? FontWeight.bold : null,
        ),
        TextStyle(
          color: Colors.deepPurple,
          fontWeight: bold[3] ? FontWeight.bold : null,
        ),
      ],
    ],
  );
}
