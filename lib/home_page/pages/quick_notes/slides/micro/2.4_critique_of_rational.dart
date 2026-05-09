import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../real_world_examples/real_world_examples.dart';
import '../../../terms/terms.dart';

final critiqueOfMaximizing = Slide(
  subunit: Subunit.critiqueBehaviour,
  tags: [Tag.hl],
  contents: [
    SlideContent.text('''
  <ul>
    <li><b>Rational Choice Theory:</b> three assumptions:
      <ul>
        <li>Consumer rationality</li>
        <li>Perfect information</li>
        <li>Utility maximization</li>
      </ul>
    </li>
    <li><b>Behavioral Economics:</b> An alternative view that:
      <ul>
        <li>Challenges traditional assumptions using psychology.</li>
        <li>Utilizes <b>choice architecture</b> and <b>nudges</b> to influence decisions.</li>
      </ul>
    </li>
  </ul>
  '''),
    SlideContent.simpleTable(
      title: 'Evaluation of Behavioral-Based Policies',
      headers: ['Advantages', 'Limitations'],
      data: [
        ['Simple / low cost', 'Ethical concerns / manipulation of choice'],
        ['Freedom of choice', 'Less transparent than taxes  / regulation'],
        [
          'Better reflects real human behavior',
          'Less effective than regulation',
        ],
        ['Complement other policies (e.g. nudges support taxes)', ''],
      ],
    ),
    SlideContent.text('''
              <p>Firms are assumed to be rational actors and aim to maximize profit (MC=MR). However, firms may have alternative goals.</p>
<ul>
  <li><b>Corporate Social Responsibility (CSR):</b></li>
  <li><b>Market share:</b> (firm sales revenue ÷ total industry sales revenue)</li>
  <li><b>Growth:</b> (maximize number of units sold)</li>
  <li><b>Revenue maximization:</b> (TR is maximized, MR = 0)</li>
  <li><b>Satisficing</b></li>
</ul>
      '''),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.critiqueBehaviour)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.critiqueBehaviour)
          .toList(),
    ),
  ],
);
