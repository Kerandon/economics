import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get publicGoodsSlides => [
  Slide(
    subunit: Subunit.marketFailurePublicGoods,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Public goods',
        'A good that is <strong>non-rivalrous</strong> and <strong>non-excludable</strong>, such as national defence, street lighting, or flood protection. '
            'Due to the <strong>free-rider problem</strong>, the government supplies them through taxation '
            '(either by direct provision or by contracting out).',
      ),

      SlideContent.term(
        'Free-rider problem',
        'When consumers can benefit from a good without paying for it (because it is non-excludable), the private sector does not supply due to being unable to generate profit.',
      ),

      SlideContent.term(
        'Non-rejectable',
        'Consumers cannot refuse the benefits of a good once it is provided. E.g., a city builds flood defences, residents automatically '
            'receive protection and must pay via taxation.',
      ),

      SlideContent.term(
        'Competitive tendering',
        'When the government invites private firms to bid for a contract to supply a good or service, selecting the proposal that offers the best value.',
      ),

      SlideContent.term(
        'Cost-benefit analysis',
        'A method for evaluating the social costs and benefits of a project using surveys, forecasts, and data analysis.',
      ),

      SlideContent.term(
        'Contracting out',
        'When the government hires private firms to provide goods or services on its behalf, funding with public funds.',
      ),
    ],
  ),
  Slide(
    subunit: Subunit.marketFailurePublicGoods,
    title: 'Public Goods (A02)',
    contents: [
      // SlideContent.customWidget(
      //   SimpleTable(
      //     headers: ['Merit Good', 'Public Good'],
      //     data: [
      //       ['Excludable & rival', 'Non-excludable & non-rival'],
      //       ['Rejectable', 'Generally non-rejectable'],
      //       [
      //         'Underconsumed due to information failure, too costly or unavailable',
      //         'Complete market failure due to free-rider problem',
      //       ],
      //       [
      //         'Provided by private sector for a price. Subsidies, some provision, education',
      //         'Funded by taxpayers via direct provision or contracting out',
      //       ],
      //       [
      //         'Healthcare, education, vaccinations',
      //         'Fire service, flood protection, national defence',
      //       ],
      //     ],
      //   ),
      // ),
    ],
  ),
  Slide(
    hl: true,
    skills: [],
    subunit: Subunit.marketFailurePublicGoods,
    title: 'Government intervention in response to public goods',
    contents: [
      SlideContent.text('''
  <h3>Cost-benefit analysis</h3>
  <ul>
    <li>Private sector is unwilling to provide the good due to the free-rider problem.</li>
    <li>The government must provide and fund the good using taxpayer revenue.</li>
    <li>Because consumers do not reveal their true demand, the government conducts a 
        <strong>cost-benefit analysis</strong> using surveys and data analysis.</li>
    <li>The socially efficient quantity occurs where MSB = MSC.</li>
    <li>Cost-benefit analysis can be inaccurate, time-consuming, and costly.</li>
  </ul>

  <h3>Government supply & Contracting Out</h3>
  <p>Once a cost-benefit analysis has been completed, the government can supply the good in two ways:</p>
  <ul>
    <li>Direct provision by the government</li>
    <li>Contracting out to the private sector</li>
  </ul>
  '''),
      // SlideContent.customWidget(
      //   SimpleTable(
      //     title: 'Contracting Out Evaluation',
      //     headers: ['Advantages', 'Limitations'],
      //     data: [
      //       ['Competitive tendering', 'Requires monitoring'],
      //       [
      //         'Use specialize knowledge & skills of private sector',
      //         'Overcharge',
      //       ],
      //       ['More innovative & efficient', 'Cozy-relationships & corruption'],
      //     ],
      //   ),
      // ),
    ],
  ),
  Slide(
    subunit: Subunit.marketFailurePublicGoods,
    title: 'Public Goods Diagram (Supplement)',
    contents: [
      SlideContent.diagrams([DiagramEnum.microPublicGoods]),
    ],
  ),
];

enum Syllabus { lawOfDemand }
