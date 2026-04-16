import '../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart' show SlideContent;
import '../../../../../models/term.dart';
import '../../../../real_world_examples/real_world_examples.dart';
import '../../../../terms/terms.dart';

final discussImportanceOfInelasticPEDForFirmsAndGovernment = Slide(
  subunit: Subunit.elasticityDemand,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the importance of PED for the decision-making of firms and government.',
  contents: [
    SlideContent.econTerms([
      EconTerm.priceElasticityOfDemand,
      EconTerm.priceElasticDemand,
      EconTerm.priceInelasticDemand,
    ]),
    SlideContent.text(
      '''
<h3>Firms</h3>
<ul>
<li><b>Revenue maximization:</b> beneficial for firms to have knowledge of <b>PED</b> of their products. Raising prices increases <b>TR</b> when <b>PED < 1</b>; cutting prices when <b>PED > 1</b>.</li>
<li><b>Price discrimination:</b> e.g., Disneyland Shanghai charges more on weekend tickets; airlines charge more for last-minute bookings; students get cheaper cinema tickets.</li>
<li><b>Limitations:</b> difficult to measure: firms have imperfect information about <b>PED</b>; firms may have other objectives than revenue max. (profit maximisation where <b>MC = MR</b>, <b>CSR</b>).</li>
<li><b>Market structure:</b> price changes must consider competition (e.g. price wars in oligopoly).</li>
</ul>

<h3>Government</h3>
<ul>
<li><b>Indirect taxes & subsidies:</b> governments use <b>PED</b> knowledge helpful to make policy decisions.</li>
<li><b>Revenue:</b> to raise tax revenue effectively, indirect tax on goods with <b>PED < 1</b>.</li>
<li><b>Externalities:</b> PED helps determine effectiveness of <b>Pigouvian taxes</b> on demerit goods.</li>
<li><b>Limitations:</b> imperfect information about PED.</li>
</ul>
      ''',
    ),
    SlideContent.diagrams([
      DiagramEnum.microDemandElasticRevenue,
      DiagramEnum.microDemandInelasticRevenue,
    ]),
    SlideContent.realWorldExamples([
      RealWorldExamples.cigaretteTaxRevenue,
      RealWorldExamples.airlinesPriceDiscrimination,
      RealWorldExamples.disneylandPricing,
    ]),
  ],
);
