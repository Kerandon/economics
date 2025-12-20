import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get asymmetricInfoSlides => [
  Slide(
    subunit: Subunit.marketFailureAsymmetric,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Adverse selection',
        'One party in an economic transaction has more information than they other which they can usually use to their advantage, leading to market inefficiencies.'
            'E.g., buyers of health insurance do not disclose an illness, or sellers of second-hand cars sell a “lemon.”',
      ),

      SlideContent.term(
        'Asymmetric information',
        'When buyers and sellers do not have equal access to information about a product or service.',
      ),

      SlideContent.term(
        'Screening',
        'When the less-informed party gathers information to reduce asymmetric information, '
            'e.g., researching customer ratings or requiring a health check.',
      ),

      SlideContent.term(
        'Signaling',
        'When the more informed party provides information to convince (\'signal to\') the other about the quality of a good or service '
            'E.g., offering warranties or a restaurant displaying hygiene checks.',
      ),

      SlideContent.term(
        'Moral hazard',
        'When one party takes more risk because they do not bear the full negative consequences of their actions, leading to market inefficiencies.'
            'E.g., large banks undertake risky investments because they expect the government to bail them out.',
      ),
    ],
  ),
  Slide(
    subunit: Subunit.marketFailureAsymmetric,
    title: 'Market failure - Asymmetric information (A02)',
    contents: [
      SlideContent.text('''
  <p>The assumption of perfect information for buyers and sellers is unrealistic. Limited information, high costs of accessing information, intellectual property barriers, or misinformation can lead to a misallocation of resources and market failure.</p>

  <ul>
    <li>Consumers may overconsume demerit goods (e.g., e-cigarettes) due to lack of information on health risks.</li>
    <li>Consumers may underconsume goods with positive externalities (e.g., vaccinations) due to misinformation or lack of awareness about social benefits.</li>
  </ul>

  <p><strong>Asymmetric information</strong> is a type of market failure that occurs when one party (buyer or seller) has more or better information than the other.</p>

  <p>The two main types are:</p>
  <ul>
    <li><strong>Adverse selection</strong></li>
    <li><strong>Moral hazard</strong></li>
  </ul>
  '''),
      SlideContent.customWidget(
        SimpleTable(
          headers: ['Adverse Selection', 'Moral Hazard'],
          data: [
            [
              'One party (buyer or seller) has better information than the other before a transaction.',
              'One party takes greater risks because they do not bear the full consequences.',
            ],
            [
              'Information failure occurs <strong>before</strong> the transaction.',
              'Information failure occurs <strong>after</strong> the transaction.',
            ],
            [
              'Seller of a used car hides faults or defects from the buyer.',
              'Banks take excessive risks because they expect government bailouts.',
            ],
            [
              'Buyer of health insurance hides a pre-existing illness.',
              'Drivers behave less safely once they have car insurance.',
            ],
          ],
        ),
      ),
    ],
  ),
  Slide(
    title: 'Responses to Asymmetric Information',
    subunit: Subunit.marketFailureAsymmetric,
    contents: [
      SlideContent.text('<h2>Adverse Selection Responses</h2>'),
      SlideContent.text('''
      <h3>Private responses</h3>
      <ul>
        <li><strong>Signalling</strong> – sellers provide information to reduce information gaps, e.g. qualifications, warranties, customer testimonials.</li>
        <li><strong>Screening</strong> – buyers or firms gather information to reduce uncertainty, e.g. insurance companies require medical checks, buyers research reviews.</li>
      </ul> 
      <h3>Government responses</h3>
      <ul>
        <li><strong>Provision of information</strong> – nutritional labels, safety warnings, public awareness campaigns.</li>
        <li><strong>Regulations</strong> – health and safety standards, consumer protection laws.</li>
        <li><strong>Licensure</strong> – requiring certain professions (e.g., doctors, electricians) to hold qualifications to protect consumers.</li>
      </ul>
      '''),
      SlideContent.text('''
      
      
<h2>Moral Hazard Responses</h2>
<ul>
  <li>
    <strong>Government regulation of the financial sector:</strong>
    <ul>
      <li>Tighter rules on risky banking activities</li>
      <li>Banks must maintain sufficient capital</li>
      <li>Stress tests and stronger enforcement</li>
    </ul>
  </li>
  <li>
    <strong>Mandating information:</strong> Require transparency, e.g., on policy for buyers of insurance.
  </li>
  <li>
    <strong>Insurance deductibles:</strong> Policyholders pay a portion of costs first, reducing excessive risk-taking.
  </li>
</ul>

'''),
    ],
  ),
];
