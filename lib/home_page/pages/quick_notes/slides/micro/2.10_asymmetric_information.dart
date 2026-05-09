import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';

import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final marketFailureAsymmetricInformation = Slide(
  subunit: Subunit.marketFailureAsymmetricInformation,
  contents: [
    SlideContent.text('''
  <h2>Asymmetric Information</h2>
  <ul>
    <li>Occurs when one party in a transaction has <b>more or better information</b> than the other, leading to market failure.</li>
  </ul>
  <h3>Two Main Types:</h3>
  <ul>
    <li><b>Adverse Selection (Before Transaction):<i>Examples: Used car sales (lemons), high-risk buyers dominating health insurance.</i></li>
    <br>
    <li><b>Moral Hazard (After Transaction):<i>Examples: Driving recklessly because you have car insurance, or banks making highly risky loans expecting government bailouts.</i></li>
  </ul>
'''),
    SlideContent.text('''
  <h2>Solutions to Adverse Selection</h2>
  <ul>
    <li><b>Private Sector Solutions:</b>
      <ul>
        <li><b>Screening:</b> Gathering info to assess risk (e.g., health or background checks).</li>
        <li><b>Signaling:</b> Demonstrating quality to buyers (e.g., warranties, hygiene ratings).</li>
      </ul>
    </li>
    <li><b>Government Policies:</b>
      <ul>
        <li><b>Laws & Regulation:</b> Consumer protection (e.g., health & safety, refund periods).</li>
        <li><b>Provision of Info:</b> Mandatory disclosure (e.g., nutritional and warning labels).</li>
        <li><b>Licensure:</b> Required certification for professions (e.g., doctors, electricians).</li>
      </ul>
    </li>
  </ul>
'''),
    SlideContent.text('''
  <h2>Policies for Moral Hazard</h2>
  <ul>
    <li><b>Deductibles:</b> For insurance, customers must first pay a fixed amount before the insurer pays out.</li>
    <li><b>Mandating Information:</b> Requiring clear provision of information regarding risks and penalties.</li>
    <li><b>Government Regulation:</b> Interventions specifically in the finance sector, such as:
      <ul>
        <li>Stronger penalties and strict enforcement.</li>
        <li>Capital requirements and regular stress tests for banks.</li>
      </ul>
    </li>
  </ul>
'''),
    SlideContent.econTerms(
      EconTerm.values
          .where(
            (term) =>
                term.subunit == Subunit.marketFailureAsymmetricInformation,
          )
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where(
            (term) =>
                term.subunit == Subunit.marketFailureAsymmetricInformation,
          )
          .toList(),
    ),
  ],
);
