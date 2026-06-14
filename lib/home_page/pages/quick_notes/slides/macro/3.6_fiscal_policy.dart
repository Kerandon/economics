import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final demandSideFiscalSlide = Slide(
  subunit: Subunit.demandManagementFiscal,
  contents: [
    SlideContent.text('''
<h2>Demand-Side Fiscal Policy</h2>
<p>Demand-side fiscal policy: government spending (ΔG) and taxation (ΔT) to influence aggregate demand (AD) and stabilize the business cycle.</p>
<ul>
  <li><b>Government Budget</b>: planned government revenues and expenditures over 1 year</li>
    <ul>
      <li><b>Budget surplus</b>: T > G</li>
      <li><b>Budget deficit</b>: T < G</li>
    </ul>
  </li>
  <li><b>Government Debt</b>total government borrowing over time (sum of past deficits and surpluses)</li>
  <li><b>Sources of Government Revenue</b>
    <ul>
      <li>Taxes.</li>
      <li>Government-run services.</li>
      <li>Sale of state-owned enterprises (SOEs).</li>
    </ul>
  </li>

  <li><b>Types of Government Expenditure</b>
    <ul>
      <li><b>Current expenditure</b> – wages and salaries of public sector employees.</li>
      <li><b>Capital expenditure</b> – investment in infrastructure and public assets.</li>
      <li><b>Transfer payments</b> – welfare benefits, pensions, and unemployment benefits (not included in G).</li>
    </ul>
  </li>

  <li><b>Transfer Payments</b>
    <ul>
      <li>Redistribution of income from government to households to improve equity. Increases consumption indirectly by raising disposable income (Yd).</li>
      <li>Disposable Income (Yd) = Income − Taxes + Transfer Payments.</li>
    </ul>
  </li>
</ul>
'''),
    SlideContent.text('''
<h2>Goals of Fiscal Policy</h2>

<ul>
  <li>Low and stable inflation.</li>
  <li>Low unemployment.</li>
  <li>Promote a stable economic environment for long-term economic growth.</li>
  <li>Reduce fluctuations in the business cycle.</li>
  <li>Achieve a more equitable distribution of income.</li>
  <li>Maintain external balance.</li>
</ul>
'''),
    SlideContent.simpleTable(
      title: 'Expansionary and Contractionary Fiscal Policies',
      headers: ['Expansionary Fiscal Policy', 'Contractionary Fiscal Policy'],
      data: [
        [
          'Increase AD to close a recessionary gap:',
          'Decrease AD to close an inflationary gap:',
        ],
        ['Lower personal income taxes', 'Increase personal income taxes'],
        ['Lower corporate income taxes', 'Increase corporate income taxes'],
        ['Increase government spending', 'Lower government spending'],
      ],
    ),
    SlideContent.diagrams(
      description:
          '<b>Expansionary Fiscal Policy (LEFT)</b> and <b>Contractionary Fiscal Policy (RIGHT)</b>',
      [
        DiagramEnum.macroKeynesianExpansionaryPolicy,
        DiagramEnum.macroKeynesianContractionaryPolicy,
      ],
    ),
    SlideContent.diagrams(
      description:
          '<b>Automatic Stabilizers</b> stabilize business cycle: Inflationary gap: progressive taxes dampen national income. Deflationary gap: transfer payments support incomes.',
      [DiagramEnum.macroBusinessCycleStabilizationPolicies],
    ),
    SlideContent.text('''
<h2>Government Spending Effective During Deep Recession</h2>
<ul>
<li>Direct impact of government spending in a <b>liquidity trap</b></li>
  <li>Government spending can <b>crowd in</b> private investment (improve infrastructure, increase national income).</li>
  <li>Most effective during deep recession with <b>spare capacity</b>: minimal risk of high inflation.</li>
  <li><b>Multiplier effect</b> means total impact much bigger than initial injection</li>
</ul>
'''),
    SlideContent.simpleTable(
      title: 'Fiscal Policy Evaluation',
      headers: ['Strengths', 'Constraints'],
      data: [
        [
          '''Targeted:
<ul>
  <li>key sectors (e.g. green energy, high-tech manufacturing)</li>
  <li>social groups to improve equity</li>
  <li>regions in deep recession</li>
</ul>''',
          'Time lags (administrative and implementation delays)',
        ],
        [
          'Direct impact of government spending (effective in liquidity trap)',
          'Political constraints',
        ],
        [
          'Effective in deep recession (multiplier effect / crowding-in)',
          'Unsustainable public debt',
        ],
        [
          'Supply-side effects: spending on merit goods / infrastructure, tax cuts for business invest in capital',
          'Tax cuts less direct than government spending',
        ],
        [
          '', // Empty string to balance the row
          'Low flexibility once implemented',
        ],
        [
          '', // Empty string to balance the row
          'Demand-pull inflation near full employment',
        ],
        [
          '', // Empty string to balance the row
          'Wasteful spending',
        ],
        [
          '', // Empty string to balance the row
          'Crowding out of private sector investment',
        ],
      ],
    ),

    SlideContent.text(
      tags: [Tag.hl],
      '''
      <h3>Crowding Out</h3>
      <p>Increase government deficit spending, causes interest rates to rise, leading to lower private firm investment due to the higher cost of borrowing.</p>
      <p>The crowding-out effect is stronger near full employment because government borrowing competes directly with private sector investment.</p>
      ''',
    ),
    SlideContent.diagrams(
      tags: [Tag.hl],
      description:
          '<b>Crowding out</b>: higher government spending increases demand for loanable funds leading to a higher real interest rate, which decreases private investment by firms.',
      [
        DiagramEnum.macroLoanableFundsDemandIncrease,
        DiagramEnum.macroCrowdingOutADAS,
      ],
    ),
    //     SlideContent.text(
    //       tags: [Tag.supplement],
    //       '''
    // <h2>Loanable Funds Market</h2>
    // <ul>
    //   <li>The loanable funds market represents the supply and demand for savings and borrowing in an economy.</li>
    //   <li>Main demanders for loanable funds are government (selling bonds) and firms (sell corporate bonds/borrow from banks). The main savers are households and foreign capital inflows.</li>
    //   <li>Uses the real interest rate because savers and borrowers consider inflation-adjusted returns and costs (Fisher effect).</li>
    // </ul>
    // ''',
    //     ),
    // SlideContent.diagrams(
    //   tags: [Tag.supplement],
    //   description:
    //       'Crowding out can be explained two ways (both lead to a higher real interest rate). Higher government spending increases demand for loanable funds as the government borrows by issuing bonds. Alternatively, budget deficits reduce public savings, lowering the supply of loanable funds.',
    //   [
    //     DiagramEnum.macroLoanableFundsDemandIncrease,
    //     DiagramEnum.macroLoanableFundsSupplyDecrease,
    //   ],
    // ),
    // SlideContent.diagrams(
    //   tags: [Tag.supplement],
    //   description:
    //       '<b>The Fisher Effect</b>: an increase of inflation by 1% would increase nominal interest rate by 1%, leaving real interest rate unchanged.',
    //   [DiagramEnum.macroLoanableFundsFisherEffect],
    // ),
    SlideContent.text(
      '<b>Resource crowding out</b>: another form of crowding is out is increased government demand for limited factors of production (such as labor) increases input prices (wages) for private sector. E.g: Russian government\'s higher military recruitment increases wage costs for private sector.',
    ),
    SlideContent.text('''
<h2>MPC and Keynesian Spending Multiplier (k)</h2>

<ul>
  <li><b>Marginal Propensity to Consume (MPC)</b>: proportion of additional income spent on domestic goods.</li>
  <li><b>MPC + MPS + MPT + MPM = 1</b></li>
</ul>
'''),
    SlideContent.simpleTable(
      headers: ['', ''],
      // ✅ Changed to 2 headers to match the 2 columns of data
      data: [
        ['Marginal Propensity to Consume (MPC)', 'MPC = ΔC ÷ ΔY'],
        ['Marginal Propensity to Save (MPS)', 'MPS = ΔS ÷ ΔY'],
        ['Marginal Propensity to Tax (MPT)', 'MPT = ΔT ÷ ΔY'],
        ['Marginal Propensity to Import (MPM)', 'MPM = ΔM ÷ ΔY'],
      ],
    ),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'Calculating Marginal Propensity to Consume (MPC)',
      headers: ['Income (Y)', 'Consumption (C)', 'MPC (ΔC / ΔY)'],
      data: [
        ['\$1000', '\$600', '-'],
        ['\$1500', '\$900', '300 / 500 = 0.60'],
      ],
    ),
    SlideContent.text(
      tags: [Tag.hl],
      '''
<h2>Keynesian Multiplier</h2>
<ul>
<li><b>k = 1 ÷ (1 − MPC)</b></li>
<li><b>k = 1 ÷ (MPS + MPT + MPM)</b></li>
</ul>
<p>An injection of new spending (such as government spending) leads to a larger change in real GDP due to the multiplier effect, where one person's spending becomes another person's income.</p>
 <ul>
<li>k = ∆Real GDP ÷ initial spending injection</li>
<li>∆Real GDP = k × spending injection</li>
</ul>
''',
    ),
    SlideContent.diagrams(
      description:
          'Autonomous spending injection of \$30m leads to \$50m in induced spending: 2.67 (k) = \$80m (∆real GDP) / \$30m (injection)',
      tags: [Tag.hl],
      [DiagramEnum.macroKeynesianMultiplier],
    ),
    SlideContent.text(
      tags: [Tag.hl],
      '''
<h2>Keynesian Multiplier Calculations</h2>

  <li>Government wants to increase real GDP by \$150bn. MPC = 0.75.</li>
  <li>k = 1 ÷ (1 − 0.75) = 4</li>
  <li>ΔReal GDP = k × injection</li>
  <li>150 = 4 × injection</li>
  <li>Injection = \$37.5bn</li>

  <br>

  <li>Investment falls by \$30m. MPS = 0.20, MPT = 0.25, MPM = 0.15.</li>
  <li>k = 1 ÷ (0.20 + 0.25 + 0.15) = 1 ÷ 0.60 = 1.67</li>
  <li>ΔReal GDP = −\$30m × 1.67 = −\$50m</li>
</ul>
''',
    ),
    SlideContent.text(
      tags: [Tag.supplement],
      '''
<h2>Tax Multiplier vs Government Spending</h2>

<ul>
  <li><b>Main point: Tax cuts are less effective than government spending.</b></li>

  <li>Government spending directly injects the full amount into the circular flow in the first round.</li>

  <li><b>Tax multiplier formula:</b> k = −MPC ÷ (1 − MPC)</li>
  <li><b>Spending multiplier formula:</b> k = 1 ÷ (1 − MPC)</li>

  <br>

  <li><b>Example (MPC = 0.50, \$40bn change):</b></li>
  <li>Tax multiplier = −0.50 ÷ (1 − 0.50) = −1</li>
  <li>Change in GDP = −1 × (−\$40bn) = +\$40bn</li>

  <li>Spending multiplier = 1 ÷ (1 − 0.50) = 2</li>
  <li>Change in GDP = 2 × \$40bn = \$80bn</li>

  
</ul>
''',
    ),

    SlideContent.simpleTable(
      title: 'Monetary Policy Vs. Fiscal Policy',
      headers: ['Monetary Policy', 'Fiscal Policy'],
      data: [
        // --- PROS ---
        ['**Pros:**', '**Pros:**'],
        ['Flexible', 'Direct impact of government spending'],
        ['Incremental', 'Effective in liquidity trap'],
        ['Reversible', 'Targeted (sectors, groups, regions)'],
        ['No government debt', 'Supply-side effects'],
        ['No political bias', 'Automatic stabilizers'],
        ['Smaller decision time lag', ''],
        ['Automatic stabilizers', ''],
        // Note: Usually considered Fiscal, kept as per your text
        ['Supply-side effects', ''],

        // --- CONS ---
        ['**Cons:**', '**Cons:**'],
        ['Liquidity trap limits effectiveness', 'Sustainable debt risk'],
        ['Money neutrality in long run', 'Inflationary pressure (demand-pull)'],
        ['Does not address structural issues', 'Crowding out'],
        ['', 'Waste and inefficiency'],
        ['', 'Not always targeted effectively'],
      ],
    ),

    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.demandManagementFiscal)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.demandManagementFiscal)
          .toList(),
    ),
  ],
);
