import 'diagram_bundle_enum.dart';

enum LegendDisplay {
  shading,
  letters,
}

extension DiagramBundleEnumExt on DiagramBundleEnum {
  /// Return a "configured" version of this enum with a display mode
  DiagramBundleConfig letters() => DiagramBundleConfig(this, LegendDisplay.letters);
  DiagramBundleConfig shading() => DiagramBundleConfig(this, LegendDisplay.shading);
}

/// Small wrapper class to hold enum + display mode
class DiagramBundleConfig {
  final DiagramBundleEnum enumValue;
  final LegendDisplay displayMode;

  DiagramBundleConfig(this.enumValue, this.displayMode);
}
