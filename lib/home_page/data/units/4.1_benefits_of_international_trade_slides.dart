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
          <h2>The World Market</h2>
      Global demand for a good is simply the sum of all the country's demand, and global supply the sum of all country's supply 
      of a good, which sets the world price of the good. 
            ''', DiagramBundleEnum.globalWorldPriceStandAlone),
      SlideContent.tip('''
        If the domestic market was closed-off from international (known as an autarky), the 
price of the good would be set by domestic supply and demand.
However, virtually all countries trade internationally and therefore 
the price of the good is actually set by the world price. 
        '''),
      SlideContent.textWithDiagram('''
      <h2>Domestic Market</h2>
The global market sets the price for the <strong>domestic market</strong>.

The world price is the same as world supply and drawn as perfectly elastic (horizontal line) because
the model assumes the domestic market is small compared to the world market and cannot influence the price.
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
