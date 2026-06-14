import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final supplySidePoliciesSlide = Slide(
  subunit: Subunit.supplySidePolicies,
  contents: [
    SlideContent.text('''
        <p><b>Supply-side policies</b>aim to increase the productive capacity of the economy (increase LRAS). Includes <b>market-based</b> and <b>interventionist policies</b>.</p>
<h2>Goals of Supply-Side Policies</h2>

<ul>
  <li>Improve <b>international competitiveness</b> (low inflation).</li>
  <li>Increase <b>competition and efficiency</b>.</li>
  <li>Enhance <b>labour market flexibility</b>.</li>
  <li>Create <b>incentives</b> (to invest and innovate).</li>
  <li>Expand <b>productive capacity</b>.</li>
</ul>
'''),
    SlideContent.diagrams(
      description:
          'An important goal of supply-side policies is to increase LRAS to reduce inflationary-pressures in the long-run.',
      [DiagramEnum.macroSupplySidePoliciesLowInflation],
    ),

    SlideContent.simpleTable(
      title: 'Supply-Side Policies',
      headers: ['Market-Based', 'Interventionist'],
      data: [
        [
          '''<b>1. Competition (efficiency)</b>
<ul>
  <li>Privatization</li>
  <li>Deregulation</li>
  <li>Contracting out to the private sector</li>
  <li>Anti-monopoly regulation</li>
  <li>Trade liberalization</li>
</ul>''',
          '<b>1. Investment in education and training</b>',
        ],
        [
          '''<b>2. Labor-market reforms (LMR) (↑ flexible, ↓ rigidities)</b>
<ul>
  <li>Abolish minimum wage legislation</li>
  <li>Weakening the power of labor (trade) unions</li>
  <li>Reduce generous unemployment benefits</li>
  <li>Reduce labor laws and regulations</li>
</ul>''',
          '<b>2. Improve quality and access to healthcare services</b>',
        ],
        [
          '''<b>3. Incentive-related (↑ hard work, ↑ investment)</b>
<ul>
  <li>Lower personal income tax</li>
  <li>Lower corporate income tax</li>
  <li>Lower capital gains tax</li>
</ul>''',
          '<b>3. Research and development (R&D)</b>',
        ],
        [
          '', // Empty string to balance the row
          '<b>4. Provision of infrastructure</b>',
        ],
        [
          '', // Empty string to balance the row
          '<b>5. Industrial policies, support infant industries</b>',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title: 'Supply-Side Policies Evaluation',
      headers: ['Market-Based', 'Interventionist'],
      data: [
        // --- PROS ---
        ['**Pros:**', '**Pros:**'],
        [
          'Efficient resource allocation, competition, export competitiveness (via efficiency)',
          'Target support for strategic industry, export competitiveness (via subsidies)',
        ],
        [
          'Lower NRU via less labor market rigidities',
          'Lower NRU via education / skills training',
        ],
        ['Reduce long-term inflation', 'Reduce long-term inflation'],
        ['No government debt', 'Improved equity (human capital investment)'],

        // --- CONS ---
        ['**Cons:**', '**Cons:**'],
        ['Time lag', 'Time lag'],
        ['Income inequality', 'Government debt (spending)'],
        ['Less protection for low skilled workers', 'Wasteful spending'],
        [
          'Negative externalities (less regulations)',
          'Firms reliant on support',
        ],
        ['Tax cuts (may) worsen debt', 'Inflationary in short-run'],
        [
          'Vested interests resist',
          '', // ✅ Empty string to balance the final row
        ],
      ],
    ),
    SlideContent.diagrams(
      description:
          'A risk of interventionist policies is an increased in government spending can result in demand-pull inflation in the short-run.',
      [DiagramEnum.macroClassicalDemandPullInflation],
    ),
    SlideContent.simpleTable(
      title: 'Policy Overlaps: Demand-Side and Supply-Side Goals',
      headers: [
        'Policy Tool',
        'Demand-Side Impact (↑ AD)',
        'Supply-Side Impact (↑ LRAS)',
      ],
      data: [
        [
          '**Cuts in corporate taxes**\n(Market-based)',
          'Increases investment (I) as firms retain more profit.',
          'Increases incentives for firms to expand, produce, and innovate.',
        ],
        [
          '**Lower interest rates**\n(Monetary / Market-based)',
          'Increases consumption (C) and investment (I) due to cheaper borrowing costs.',
          'Increases capital formation (new machinery/factories), expanding productive capacity.',
        ],
        [
          '**Government spending on education and health**\n(Interventionist)',
          'Directly increases government spending (G) in the circular flow.',
          'Improves human capital, leading to higher labor productivity.',
        ],
        [
          '**Government spending on infrastructure**\n(Interventionist)',
          'Directly increases government spending (G) in the circular flow.',
          'Improves physical capital, increasing efficiency and lowering transport costs.',
        ],
      ],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.supplySidePolicies)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.supplySidePolicies)
          .toList(),
    ),
  ],
);
