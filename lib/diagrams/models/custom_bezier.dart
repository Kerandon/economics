import 'dart:ui';

class CustomBezier {
  final Offset control;
  final Offset endPoint;

  CustomBezier({
    Offset? control,
    required this.endPoint,
  }) : control = control ?? endPoint;
}
