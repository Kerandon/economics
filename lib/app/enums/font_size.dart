enum FontSize { tiny, small, medium, big, large, huge }

extension FontSizeExtension on FontSize {
  double get multiplier {
    switch (this) {
      case FontSize.tiny:
        return 0.7;
      case FontSize.small:
        return 0.85;
      case FontSize.medium:
        return 1.0;
      case FontSize.big:
        return 1.2;
      case FontSize.large:
        return 1.5;
      case FontSize.huge:
        return 2.0;
    }
  }
}
