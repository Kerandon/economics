import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/enums/skill.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get measuringEconomicActivitySlides => [
  Slide(
    subunit: Subunit.measuringEconomicActivity,
    title: 'Circular Flow Of Income Model',
    skills: [Skill.a02, Skill.a04],
    contents: [
      SlideContent.text('''
      The Circular Flow Of Income Model is a visual representation of a simple economy.
      The most basic model is a Two-Sector model, where the economy only has consumers and
      firms.
      <p>
      There is equivalence of flow: Factor income (Y) = Consumer Expenditure (E) = Value of Output (O)
      </p>
      <p>
 Y E O are three ways to calculate GDP.
      </p>

      '''),
      SlideContent.diagrams([DiagramEnum.macroCircularFlowTwoSectorEconomy]),
      SlideContent.text('''
A more realistic model is an open-model which adds Government, Financial Markets and Foreign sector.
<p>These create injections and leakages which can contract of expand the size of economic activity.
      '''),
      SlideContent.diagrams([DiagramEnum.macroCircularFlowOpenEconomy]),
    ],
  ),
  Slide(
    subunit: Subunit.measuringEconomicActivity,
    title: 'GDP and GNI',
    contents: [
      SlideContent.text('''
      <strong>Gross Domestic Product (GDP) is the total value of all final goods and services produced in a country in one year<strong>
     <p>GDP includes the production of all goods and services produced in a country - no matter whether produced by domestic or foreign firms'.</p>
      
      <p>A similar measure to GDP is GNI - the difference between the two is: GDP is about location of production; while GNI is concerned with residency of income</p>
      
      <p><strong>Gross National Income (GNI) is the total factor income earned by residents no matter where they live.<strong></p>
      <p>GNI = GDP + Income earned abroad by residents - income sent abroad by foreigners</p>. This can be simplified to:
      <p>GNI = GDP + Net Factor Income From Abroad (NFIA).</p>
      
      '''),
      SlideContent.simpleTable(
        title: 'Included in GDP or GNI of Australia?',
        headers: ['Scenario', 'GDP', 'GNI'],
        data: [
          // 1. Produced in Aus (GDP), but profits go back to China (Not GNI)
          ['Chinese firm in Australia produces \$10m value of cars', 'Y', 'N'],
          [
            'Australian Consulting firm based in the UK earns \$2m in profits',
            'N',
            'Y',
          ],
          // 2. Produced in Aus (GDP) by an Aus firm (GNI). Exports don't subtract from GNI!
          [
            'Australian Firm produces \$2m of wine in Australia it exports',
            'Y',
            'Y',
          ],

          // 3. Produced in NZ (Not GDP), but income goes to Aus resident (GNI)
          [
            'Australian resident earns \$120,000 in wages in New Zealand',
            'N',
            'Y',
          ],

          // 4. Services produced in Aus (GDP), income earned by Aus businesses (GNI)
          [
            'American tourists spend \$5,000 on hotels services while travelling in Australia',
            'Y',
            'N',
          ],
        ],
      ),
      SlideContent.text('''
      To calculate GDP you add up total spending by C + I + G + X - M
      '''),
      SlideContent.text('''
      To calculate GDP using the expenditure approach, you add up total spending: <b>C + I + G + (X - M)</b>.<br><br>
      To transition from GDP to GNI, you must account for income flowing in and out of the country.
    '''),
      SlideContent.simpleTable(
        headers: ['Item', 'Value (\$ Billions)'],
        data: [
          ['Consumption Spending (C)', '80'],
          ['Investment Spending (I)', '25'],
          ['Government Spending (G)', '30'],
          ['Exports (X)', '15'],
          ['Imports (M)', '20'],
          ['Income earned from abroad', '10'],
          ['Income sent abroad', '15'],
        ],
      ),
    ],
  ),
];
