import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';

import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final marketFailurePublicGoodsSlide = Slide(
  subunit: Subunit.marketFailurePublicGoods,
  contents: [
    SlideContent.text('''
  <h1>Public Goods</h1>
  <ul><li><b>Non-excludable</b> and <b>non-rivalrous</b></li>
  <li>Because non-excludable, private firms cannot charge a price to make a profit, leading to the <b>free-rider problem</b>.</li></ul>
'''),
    SlideContent.simpleTable(
      title: 'Merit Goods vs. Public Goods',
      headers: ['Merit Good', 'Public Good'],
      data: [
        [
          'Excludable & rivalrous (rejectable)',
          'Non-excludable & non-rivalrous (generally non-rejectable)',
        ],
        [
          'Under-consumed due to unaffordability, information failure',
          'Free rider problem causes complete market failure',
        ],
        [
          'Underconsumption in private market corrected via subsidies, some government provision, or education',
          'Funded by taxpayers via direct government provision or contracting to private firms',
        ],
        [
          'Vaccinations, education, healthcare',
          'Street lighting, fire services, national defence, public parks',
        ],
      ],
    ),
    SlideContent.text('''
  <h2>Government Policies to Supply Public Goods</h2>
  <ul>
    <li>Unlike merit goods, the private market will not provide public goods at all, leading to <b>complete market failure</b>.</li>
    <li>Therefore, the government must step in to supply them.</li>
    <li>As there is no effective market demand, the government will undertake a <b>cost-benefit analysis</b> to estimate where MSB = MSC. They will then provide the goods via:
      <ol>
        <li><b>Direct provision</b></li>
        <li><b>Contracting out</b> to the private sector</li>
      </ol>
    </li>
    <li>A risk of direct government provision is due to lack of competitive pressures it is less competitive and less efficient. An alternative option is contracting out.</li>
  </ul>
'''),
    SlideContent.simpleTable(
      title: 'Evaluation of Contracting Out to the Private Sector',
      headers: ['Advantages', 'Disadvantages'],
      data: [
        ['Competitive tendering', 'Overcharge government'],
        [
          'Specialized skills of private sector',
          'Less accountability, requires monitoring',
        ],
        ['Innovative and efficient', '\'Cozy-relationships\' and corruption'],
      ],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.marketFailurePublicGoods)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.marketFailurePublicGoods)
          .toList(),
    ),
  ],
);
