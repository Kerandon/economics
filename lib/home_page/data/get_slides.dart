import 'package:economics_app/home_page/models/custom_slide.dart';

import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/enums/unit_type.dart';

List<CustomSlide2> get slides2 => [
  CustomSlide2(
    section: Subunit.demand,
    title: 'Demand 2',
    contents: [
      CustomSlideContent(tip: 'tip example'),
      CustomSlideContent(term: 'term example'),
      CustomSlideContent(alert: 'alert example'),
      CustomSlideContent(content: 'content blah blah 1 '),
      CustomSlideContent(
        diagramBundleEnums: [
          DiagramBundleEnum.microDemandIndividualVsMarketDemand,
        ],
      ),
    ],
  ),
];
