import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';

import '../models/diagram_model.dart';

mixin DiagramIdentifierMixin {
  DiagramModel get model;
}

mixin DiagramIdentifierMixin2 {
  DiagramBundleEnum get bundle;
  LegendDisplay get legendDisplay;
}
