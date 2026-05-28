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
    SlideContent.text(
      '''
      <h2>Inflation Targeting</h2>
      <ul>
     <li>NZ first implemented in 1990 explicit target of 0-2%.</li>
     <li>Australia, UK, Canada followed soon after</li>
     <li>Pros: anchored inflation expectations, price stability, clear accountability.</li>
     <li>Limitations: cost unemployment to anchor expectations, not deal with structural issues.</li>
     </ul>
      '''
    ),

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
<ul>
<li>Money Supply = Currency (Cash) + Deposits (MS = C + D)</li>
<li>While fractional reserve banking can expand the money supply through lending, the central bank ultimately controls the money supply.</li>
</ul>

<h2>Nominal and Real Interest Rate</h2>
<ul>
<li>The interest rate is the <b>cost of borrowing</b> and the <b>reward for saving</b>.</li>
<li>Nominal interest rate (i) = real interest rate (r) + inflation (π), not adjusted for inflation.</li>
<li>Real interest rate (r) = nominal interest rate (i) − inflation (π): the real cost of borrowing and real reward for saving.</li>
<li>If the nominal interest rate is 5% and inflation is 3%, the real interest rate is 2% (r = 5 − 3).</li>
<li>If the real interest rate is 1% and inflation is 3%, the nominal interest rate is 4% (i = 1 + 3).</li>
<li>The money market uses nominal interest rates because central banks target a nominal policy rate (equilibrium interest rate).</li>
</ul>
'''),
    SlideContent.text(
      tags: [Tag.hl],
      '''
  <h2>Fractional Reserve Banking</h2>
  <ul>
    <li>Commercial Banks hold a percentage of deposits as <b>required reserves</b>; <b>excess reserves</b> are loaned out, creating new money.</li>
    <li>New loans deposited into the banking system are lent out again, multiplying the money supply.</li>
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
      DiagramEnum.macroKeynesianExpansionaryPolicy,
    ]),
    SlideContent.diagrams(description: 'Contractionary Monetary Policy', [
      DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      DiagramEnum.macroKeynesianContractionaryPolicy,
    ]),
    SlideContent.text('''
<h2>How Monetary Policy Works (Transmission Mechanism)</h2>
<ul>
  <li>Central bank identifies an inflationary / deflationary gap.</li>
  <li>Central bank buys / sells government bonds (OMO).</li>
  <li>Bank reserves change.</li>
  <li>Money supply changes, affecting interest rates.</li>
  <li>Changes in borrowing costs influence consumption and investment.</li>
  <li>Changes in asset prices affect consumption (wealth effect).</li>
  <li>Capital flows shift, affecting exchange rate and net exports.</li>
</ul>
'''),
    SlideContent.simpleTable(
      title: 'Transmission Mechanism of Monetary Policy - Four Channels',
      headers: [
        'Interest Rate Channel',
        'Wealth Channel',
        'Cashflow Channel',
        'Exchange Rate Channel',
      ],
      data: [
        [
          'Lower rates decreases borrowing costs, increasing C & I.',
          'Lower rates increases demand for assets, asset prices rise increasing (wealth effect).',
          'Lower rates mean less loan payments increasing disposable income/profits.',
          'Lower rates mean less financial capital inflow, exchange rate depreciates, NX increases. However, can be offset if inflation rises.',
        ],
      ],
    ),
    SlideContent.text('''
  <h2>Liquidity Trap</h2>
  <ul>
  <li>A liquidity trap can occur after a financial crisis or prolonged recession.</li>
  <li>Monetary policy becomes less effective because: interest rates are already near zero, banks are unwilling to lend due to weak confidence, households and firms prefer saving to spending, and there is a risk of a deflationary price spiral.</li>

  <li><b>Deflationary Price Spiral</b></li>
  <ul>
    <li>Falling prices reduce consumer spending as people delay purchases expecting lower future prices.</li>
    <li>Lower demand forces firms to cut prices further and reduce output.</li>
    <li>Wages may fall, reducing income and reinforcing lower consumption.</li>
    <li>This creates a self-reinforcing cycle of falling prices and falling demand.</li>
    </ul>
    </ul>
<h3>Real World Examples</h3>
    <li>Japan 1990s–2010s – prolonged liquidity trap with near zero interest rates, persistent deflation, and weak monetary transmission despite quantitative easing.</li>
    <li>United States 2008–2015 – post financial crisis liquidity trap, Federal Reserve used zero interest rates and large scale quantitative easing to stabilise demand.</li>
    <li>Eurozone 2013–2016 – low inflation and weak recovery led the European Central Bank to adopt negative interest rates and asset purchase programmes.</li>
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
