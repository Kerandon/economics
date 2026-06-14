import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final demandSideMonetarySlide = Slide(
  subunit: Subunit.demandManagementMonetary,
  contents: [
    SlideContent.text('''
  <h2>Goals of Monetary Policy</h2>
  <ul>
    <li>Low and stable inflation (inflation targeting).</li>
    <li>Low unemployment.</li>
    <li>Reduced business cycle fluctuations.</li>
    <li>Stable economic environment for long-term growth.</li>
    <li>External balance.</li>
  </ul>
'''),
    SlideContent.text('''
      <h2>Inflation Targeting</h2>
      <ul>
     <li>NZ first implemented in 1990 explicit target of 0-2%.</li>
     <li>Australia, UK, Canada followed soon after</li>
     <li>Pros: anchored inflation expectations, price stability, clear accountability.</li>
     <li>Limitations: cost unemployment to anchor expectations, not deal with structural issues.</li>
     </ul>
      '''),

    SlideContent.text('''
<h2>Central Bank</h2>
<ul>
<li>Conducts monetary policy</li>
<li>Banker to the government</li>
<li>Lender of last resort (provides emergency liquidity to banks)</li>
<li>Regulator of commercial banks</li>
</ul>
'''),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'Central Banks Around the World and Target Rates',
      headers: ['Country / Region', 'Central Bank', 'Target / Policy Rate'],
      data: [
        ['United States', 'Federal Reserve (Fed)', 'Federal Funds Rate'],
        [
          'Euro Area',
          'European Central Bank (ECB)',
          'Main Refinancing Operations (MRO) Rate',
        ],
        ['Japan', 'Bank of Japan (BOJ)', 'Short-Term Policy Interest Rate'],
        ['China', 'People’s Bank of China (PBOC)', 'Loan Prime Rate (LPR)'],
        [
          'New Zealand',
          'Reserve Bank of New Zealand (RBNZ)',
          'Official Cash Rate (OCR)',
        ],
        ['United Kingdom', 'Bank of England (BoE)', 'Bank Rate'],
      ],
    ),
    SlideContent.text('''
<h2>Money Supply</h2>

<p>Money Supply = Currency in circulation + Bank deposits (MS = C + D)</p>
<h3>Functions of money</h3>
<ul>
<li>Medium of Exchange</li>
<li>Unit of Account</li>
<li>Store of Value</li>
</ul>

<h2>Nominal and Real Interest Rate</h2>
<ul>
<li><b>Interest rate</b>: <b>cost of borrowing</b> or <b>reward for saving</b>.</li>
<li>Real interest rate (r) = nominal interest rate (i) − inflation (π)</li>
<li>If the nominal interest rate is 5% and inflation is 3%, the real interest rate is 2% (r = 5 − 3).</li>
<li>Central banks target a nominal interest rate (the money market is a short-term market).</li>
</ul>
'''),
    SlideContent.text(
      tags: [Tag.hl],
      '''
  <h2>Fractional Reserve Banking</h2>
'<p>Creates new money in the economy through credit creation when banks lend a portion of deposits.</p>'
  <ul>
    <li>Commercial Banks hold a percentage of deposits as <b>required reserves</b>; <b>excess reserves</b> are loaned out, creating new money.</li>
   '<li>A new loan can be deposited back in the banking system. Banks can again lend a % of this new deposit (money multiplier effect).</li>'
    <li><b>Money Multiplier</b> = 1 / Minimum Reserve Requirement (MRR).</li>
    <li><b>Example (Deposit \$1000, MRR 20%):</b>
      <ul>
        <li>Required Reserves: \$200; Excess Reserves: \$800.</li>
        <li>Multiplier: 1 / 0.20 = 5.</li>
        <li>Potential New Money: \$800 × 5 = \$4000.</li>
      </ul>
    </li>
  </ul>
''',
    ),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'Money Multiplier Process (20% MRR)',
      headers: [
        'Round',
        'New Deposit (\$)',
        'Required Reserves (20%)',
        'New Loan Created (\$)',
        'Change in Total Money Supply (\$)',
      ],
      data: [
        ['Initial Deposit', '1000', '200', '800', '800'],
        ['Second Round', '800', '160', '640', '1440'],
        ['Third Round', '640', '128', '512', '1952'],
        ['Fourth Round', '512', '102.4', '409.6', '2361.6'],
        ['Maximum Potential', '-', '-', '-', '4000'],
      ],
    ),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'Monetary Policy Tools To Change the Money Supply',
      headers: [
        'Monetary Policy Tool',
        'Expansionary Monetary Policy',
        'Contractionary Monetary Policy',
      ],
      data: [
        [
          'Open Market Operations (OMO)',
          'Buy bonds in the open market increasing excess reserves',
          'Sell bonds in the open market decreasing excess reserves',
        ],
        [
          'Minimum Reserve Requirement (MRR)',
          'Lower MRR (money multiplier increases)',
          'Raise MRR (money multiplier falls)',
        ],
        [
          'Minimum Lending Rate (MLR)',
          'Lower MLR (only for emergency lending)',
          'Raise MLR',
        ],
        [
          'Quantitative Easing (QE)',
          'Especially during a deep recession / financial crisis, large scale purchase of securities and other financial assets',
          'QE tapering (slow rate of purchases), sell back assets (quantitative tightening)',
        ],
      ],
    ),

    SlideContent.diagrams(
      description:
          'The money market determines the equilibrium interest rate. Money supply is perfectly inelastic as it is set by the central bank. Money demand is downward sloping because money is held for liquidity (transactions and safety) but earns no interest. As interest rates rise, the opportunity cost of holding money increases since funds could earn returns in bonds or savings accounts.',
      [DiagramEnum.macroMoneyMarket],
    ),
    SlideContent.diagrams(description: 'Expansionary Monetary Policy', [
      DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy,
      DiagramEnum.macroKeynesianExpansionaryPolicyDeepRecession,
    ]),
    SlideContent.diagrams(description: 'Contractionary Monetary Policy', [
      DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      DiagramEnum.macroKeynesianContractionaryPolicy,
    ]),
    SlideContent.simpleTable(
      title: 'Transmission Mechanism of Monetary Policy',
      headers: [
        'Interest Rate Channel',
        'Wealth Channel',
        'Cashflow Channel',
        'Exchange Rate Channel',
      ],
      data: [
        [
          'Lower interest rates reduce borrowing costs, increasing consumption (C) and investment (I).',
          'Asset prices rise, increasing household wealth and encouraging spending (wealth effect).',
          'Lower interest rates reduce debt-servicing costs, increasing disposable income and profits.',
          'Lower interest rates reduce capital inflows, causing currency depreciation and increasing net exports (NX).',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title: 'Monetary Policy Impact on Net Exports',
      headers: [
        'Expansionary Monetary Policy',
        'Contractionary Monetary Policy',
      ],
      data: [
        ['Interest rates fall', 'Interest rates rise'],
        [
          'Financial capital outflows, currency depreciation, NX increase',
          'Financial capital inflows, currency appreciation, NX falls',
        ],
        [
          'But…risk of high inflation can cause loss of international competitiveness',
          '', // Empty string to balance the row
        ],
      ],
    ),
    SlideContent.text('''
<h2>Liquidity Trap</h2>

<ul>
  <li>Often follows a financial crisis. Monetary policy less effective:</li>
    <ul>
      <li>Interest rates already close to zero.</li>
      <li>Banks reluctant to lend due to weak confidence.</li>
      <li>Households and firms prefer saving to spending and investment.</li>
      <li>Risk of a deflationary price spiral.</li>
    </ul>
  </li>

  <li><b>Deflationary Price Spiral</b>
    <ul>
      <li><b>Deferred consumption</b> - expectation of lower prices</li>
      <li>Reduced AD forces firms to cut prices.</li>
    </ul>
  </li>
</ul>
'''),
    SlideContent.simpleTable(
      title: 'Evaluation of Monetary Policy',
      headers: ['Strengths', 'Limitations'],
      data: [
        [
          'Flexible: Adjusted incrementally and reversible.',
          'Ineffective in a deep recession (liquidity trap).',
        ],
        [
          'Shorter time lags (decision/implementation).',
          'Potential conflict with uncoordinated fiscal policy.',
        ],
        [
          'No political bias.',
          'May cause exchange rate depreciation and inflation.',
        ],
        [
          'Does not increase national debt.',
          'Effectiveness is often limited to the short run.',
        ],
        [
          'No crowding out.',
          'Not directly solve structural issues/supply-shocks.',
        ],
      ],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.demandManagementMonetary)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.demandManagementMonetary)
          .toList(),
    ),
  ],
);
