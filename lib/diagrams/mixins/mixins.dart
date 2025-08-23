import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/enums/legend_display.dart';

import '../models/diagram_model.dart';

mixin DiagramIdentifierMixin {
  DiagramModel get model;
}

mixin DiagramIdentifierMixin2 {
  DiagramBundleEnum get diagramBundleEnum;
  LegendDisplay get legendDisplay;
}

