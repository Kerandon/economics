enum Level {
  sL,
  hL,
}

extension LevelExtension on Level {
  String get formattedName => name.toUpperCase();
}
