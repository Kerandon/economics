import '../../diagrams/enums/diagram_bundle_enum.dart';

enum Tool { diagrams, calculations }

extension ToolExtension on Tool {
  String get title {
    switch (this) {
      case Tool.diagrams:
        return 'Diagrams';
      case Tool.calculations:
        return 'Calculations';
    }
  }

  String? get imageUrl {
    switch (this) {
      case Tool.diagrams:
        return null; // replace with your actual image path
      case Tool.calculations:
        return 'assets/images/calculations.jpg'; // replace with your actual image path
    }
  }

  DiagramBundleEnum? get diagram {
    switch (this) {
      case Tool.diagrams:
        return DiagramBundleEnum
            .microDemandPriceChange; // replace with your actual image path
      case Tool.calculations:
        return null; // replace with your actual image path
    }
  }
}
