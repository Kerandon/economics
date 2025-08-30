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
        The exchange of goods and services across national borders. 
        '''),
      SlideContent.term('Free Trade', '''
      International trade without government restrictions on exports and imports such as tariffs.
        '''),
    ],
  ),
  Slide(
    section: Subunit.benefitsTrade,
    title: 'Gains from Trade',
    contents: [
      SlideContent.textWithDiagram('''
        The world price & supply curve is drawn as perfectly elastic
            determined by the intersection of global supply and demand. 
            This model assumes that world market is so large compared to the domestic market, 
            that the domestic market is a <strong>price taker</strong> and cannot affect the world price.
            This means that the domestic market can import as much as it needs if it pays the world price.
            Or the domestic market could export as much as it is able to at the world price.
            ''', DiagramBundleEnum.globalWorldPriceStandAlone),
      SlideContent.textWithDiagram('''
          If the domestic price is <strong>higher</strong> than the world price, the domestic market will 
          import the good at the lower world price. 
          Only domestic producers which are more competitive (cheaper) than the world price will continue to sell 
          in the domestic market.
          ''', DiagramBundleEnum.globalNetImporter),
      SlideContent.textWithDiagram('''
                 
If the domestic price is <strong>lower</strong> than the world price, domestic producers will
choose to export the good at the higher world price. Domestic producers will increase the domestic price to match 
the world price, and only domestic consumers who are willing and able to buy at the higher price will continue to 
buy the good.
''', DiagramBundleEnum.globalNetExporter),
      SlideContent.term('Gains from Trade', '''
      Economic benefits gained from engaging in international trading. 
      Includes the net gains in consumer and producer surplus.
      '''),
      SlideContent.key('Benefits from Free Trade', '''
      <ul>
  <li>Increased competition</li>
  <li>Lower prices</li>
  <li>Greater choice</li>
  <li>Acquisition of resources</li>
  <li>More foreign exchange earnings</li>
  <li>Access to larger markets</li>
  <li>Economies of scale</li>
  <li>More efficient resource allocation</li>
  <li>More efficient production</li>
</ul>

      '''),
    ],
  ),
  Slide(
    section: Subunit.benefitsTrade,
    title: 'Comparative Advantage',
    hl: true,
    contents: [
      SlideContent.term(
        '''
        Absolute Advantage
      ''',
        '''is when a country can produce the more of a good using fewer resources.

      ''',
      ),
      SlideContent.text('''
        As the below table shows, France has an <strong>absolute advantage</strong>
        in the production of wine while Spain has an <strong>absolute advantage</strong>
        in the production of beer. 
        '''),
      SlideContent.customWidget(
        SimpleTable(
          title: 'Wine & Cheese Production\n(Per Worker Each Day)',
          headers: ['', 'Cheese (kg)', 'Wine (bottles)'],
          data: [
            ['France', '120', '16'],
            ['Spain', '140', '12'],
          ],
          cellStyles: [
            [
              TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.deepOrange),
              TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ],
            [
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.deepPurple),
            ],
          ],
        ),
      ),

      SlideContent.diagram(
        DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods,
      ),

      SlideContent.term(
        '''
        Comparative Advantage
      ''',
        '''is when a country can produce the more of a good using fewer resources.

      ''',
      ),
    ],
  ),
];
