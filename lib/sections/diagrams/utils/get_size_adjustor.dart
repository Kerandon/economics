import 'package:flutter/material.dart';

import '../models/size_adjuster.dart';

SizeAdjustor getSizeAdjustor({required Size size, required Size sizeApp}) {
  final w = size.width / sizeApp.width;
  final h = size.height / sizeApp.height;
  return SizeAdjustor(width: w, height: h);
}
