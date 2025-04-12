import 'dart:ui';

double getSizeScaleRatio(Size painterSize, Size appSize) {
  final widthRatio = painterSize.width / appSize.width;
  final heightRatio = painterSize.height / appSize.height;

  // Use the smaller of the two to avoid overflow
  return widthRatio < heightRatio ? widthRatio : heightRatio;
}