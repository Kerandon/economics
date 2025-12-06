import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';

import '../models/diagram_model.dart';

mixin DiagramIdentifierMixin {
  DiagramModel get model;
}

mixin DiagramIdentifierMixin2 {
  DiagramEnum get bundle;
}

mixin DiagramIdentifierMixin3 {
  DiagramEnum get diagram;
}
