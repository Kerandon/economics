import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainLimitationsOfComparativeAdvantage10MarkHL = Slide(
  subunit: Subunit.benefitsTrade,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Countries often specialize and trade according to the theory of comparative advantage. Explain the limitations of this approach.',
  contents: [
    SlideContent.text('''
      <p>The theory of comparative advantage demonstrates how countries benefit from trade by specializing in goods they can produce at a lower opportunity cost. While the theory underpins understanding of international trade, it has several important limitations.</p>

      <p>Firstly, it relies on unrealistic assumptions. It assumes goods are homogeneous, whereas in reality products are differentiated and consumer preferences are important (e.g., Italian clothing, German cars, New Zealand dairy).</p>

      <p>The model also assumes factors of production are perfectly mobile within countries but immobile between countries. In reality, labor and capital do move internationally through migration and foreign direct investment.</p>

      <p>It further assumes fixed technology and full employment of resources, which does not reflect real-world economies.</p>

      <p>In addition, it ignores transport costs and externalities such as environmental pollution associated with production and trade.</p>

      <p>Many real-world economies also impose trade barriers and participate in trade blocs, which distort free trade and are not accounted for in the model.</p>

      <p>A further limitation is that comparative advantage may encourage over-specialization, limiting necessary structural change and diversification (e.g., over-reliance on primary sectors in ELDCs).</p>

      <p>Finally, in reality, global trade is influenced by other factors not in the model: economies of scale, historical relationships, geographic location, and political factors.</p>
      '''),
    SlideContent.diagrams([DiagramEnum.globalComparativeAdvantage]),
    SlideContent.text('''
    <h3>Summary of limitations:</h3>
<ul>
  <li>Assumes perfect factor mobility within countries but immobility between countries</li>
  <li>Assumes full employment of resources</li>
  <li>Assumes technology and resources do not change over time</li>
  <li>Ignores trade barriers and trade blocs</li>
  <li>Products differ in quality</li>
  <li>Ignores transport costs and externalities</li>
  <li>Ignores overspecialization which hinders structural change for ELDCs</li>
  <li>“Rich-man theory” that benefits MNCs and exploits ELDCs</li>
  <li>Ignores economies of scale, preferences, and political factors</li>
</ul>
'''),

    SlideContent.econTerms([EconTerm.comparativeAdvantage]),
  ],
);
