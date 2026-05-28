import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final economicActivitySlide = Slide(
  subunit: Subunit.economicActivity,
  contents: [
    SlideContent.diagrams(
      description: '''
        <ul>
        <li>Circular Flow of Income Model shows the flows (and interdependence) of factor incomes, resources and goods and services in an economy.</li>
        <li>A closed model economy includes only households and firms.</li>
        <li>It shows that 3 flows are equal in value and are the 3 measures of GDP: Factor Income (Y) = Aggregate Expenditure (E) = Value of Final Output (O).</li>
   </ul>
        ''',
      [DiagramEnum.macroCircularFlowTwoSectorEconomy],
    ),
    SlideContent.diagrams(
      description: '''
        <ul><li>An open Circular Flow of Income Model. Shows how the size of economic activity (real GDP) can be expanded or contracted via injections (J) and Leakages / Withdrawals (W).</li>
        <li>Factor Income (Y) = Aggregate Expenditure (E) = Value of Final Output (O).</li>
   </ul>
        ''',
      [DiagramEnum.macroCircularFlowOpenEconomy],
    ),
    SlideContent.simpleTable(
      title: 'Injections and Leakages',
      headers: ['Sector / Market', 'Injection', 'Leakage'],
      data: [
        ['Government', 'G = Government Spending', 'T = Taxes'],
        ['Financial Markets', 'I = Investment', 'S = Savings'],
        ['Foreign Sector', 'X = Exports', 'M = Imports'],
      ],
    ),
    SlideContent.text('''
<h1>GDP and GNI</h1>
<ul>
<li><strong>Gross Domestic Product (GDP)</strong> is the market value of all final goods and services produced within a country in a given time period.</li>

<li>Three ways to calculate GDP: income approach (sum of factor incomes), output approach (value of final output), and expenditure approach.</li>

<li><strong>Expenditure approach:</strong> GDP = C + I + G + (X - M)</li>

<li><strong>Gross National Income (GNI)</strong> is the total factor income earned by the residents of a country in one year, regardless of where the income is earned.</li>

<li><strong>GNI</strong> = GDP + Income Earned From Abroad - Income Sent Abroad (Net Factor Income From Abroad, NFIA)</li>
</ul>
'''),
    SlideContent.text('''
    <h3>GDP Deflator</h3>
    <ul><li><strong>GDP Deflator = (Nominal GDP / Deflator) X 100</strong></li>
    <li>Nominal GDP is measured in <strong>current prices</strong>; real GDP uses base year prices and is measured in <strong>constant prices.</strong></li>
    <li>Nominal GDP is \$350bn and the price deflator is 160. Real GDP = (350 / 160) X 100 = \$218.75bn</li>
    </ul>
    <h3>Per Capita</h3>
     <ul><li><strong>GDP Deflator = (Nominal GDP / Deflator) X 100</strong></li>
    <li>Nominal GDP is measured in <strong>current prices</strong>; real GDP uses base year prices and is measured in <strong>constant prices.</strong></li>
    <li>Nominal GDP is \$350bn and the price deflator is 160. Real GDP = (350 / 160) X 100 = \$218.75bn</li>
    '''),
    SlideContent.text('''
<h3>Purchasing Power Parities (PPP)</h3>
<li>GDP can be compared using market exchange rates (US\$) or PPP-adjusted exchange rates (PPP\$).</li>
<ul>
<li><strong>PPP</strong> = Value of Basket of Goods in Currency A / Value of Basket of Goods in Currency B.</li>
<li>PPP measures the actual purchasing power of currencies by accounting for differences in price levels between countries.</li>
<li>For developing countries GDP at PPP\$ usually > GDP at market exchange rates (\$) because of the low cost of services due to low wage costs (a haircut cannot be traded across borders).</li>
<li>PPP therefore provides a more accurate comparison of living standards and real output between countries.</li>
</ul>
'''),

    SlideContent.simpleTable(
      title: 'Calculations from a table',
      headers: ['Item', 'Value'],
      data: [
        ['Consumption', '\$100bn'],
        ['Private Investment', '\$30bn'],
        ['Government Expenditure', '\$60bn'],
        ['Export Revenue', '\$30bn'],
        ['Import Expenditure', '\$40'],
        ['Factor Income From Abroad', '\$10'],
        ['Factor Income Sent Abroad', '\$5'],
        ['GDP Deflator', '125'],
        ['Population', '125m'],
      ],
    ),
    SlideContent.text('''
      <ul>
      <li><strong>Nominal GDP = C + I + G + (X - M)</strong>; 100 + 30 + 60 + 30 - 40 = \$180bn </li>
      <li><strong>Real GDP = (Nominal GDP / GDP Deflator) x 100</strong>; (180 / 125) X 100 =  \$144bn</li>
      <li><strong>Real GDP per capita = Real GDP / Population</strong>; 144 x 1000 (convert to millions) / 125 = \$1152 per person </li>
      </ul>
      '''),
    SlideContent.simpleTable(
      title: '<h2>Business Cycle</h2>',
      headers: ['Economic State', 'GDP', 'Unemployment', 'Inflation'],
      data: [
        [
          'Full Employment',
          'Real GDP = Potential GDP',
          'U = NRU',
          'Low and stable',
        ],
        ['Inflationary Gap', 'Real GDP > Potential GDP', 'U < NRU', 'High'],
        [
          'Deflationary Gap',
          'Real GDP < Potential GDP',
          'U > NRU (cyclical unemployment)',
          'Low',
        ],
      ],
    ),
    SlideContent.diagrams(
      description: '''
        <ul><li>Shows the fluctuations in economic activity over-time.</li></ul>
        ''',
      [DiagramEnum.macroBusinessCycleNRU],
    ),
    SlideContent.diagrams(
      description: '''
      <h3>Macroeconomic goals and the business cycle.</h3>
        <ul><li>Stabilize Business Cycle fluctuations using demand-side policies (LEFT).</li>
        <li>Increase long-term economic growth using supply-side policies (RIGHT).</li>
        </ul>
        ''',
      [
        DiagramEnum.macroBusinessCycleStabilizationPolicies,
        DiagramEnum.macroBusinessCycleIncreaseInPotentialGDP,
      ],
    ),

    // SlideContent.simpleTable(
    //   headers: [],
    //   data: [
    //     [
    //       'Human Development Index (HDI)',
    //       '1. GNI per Capita \$PPP, 2. Life Expectancy At Birth, 3. Education - Mean Years of Schooling',
    //     ],
    //   ],
    // ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.economicActivity)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.economicActivity)
          .toList(),
    ),
  ],
);
