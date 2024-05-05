import 'package:economics_app/app/custom_paint/diagrams/classical_adas.dart';
import 'package:flutter/material.dart';
import 'diagrams/aggregate_demand.dart';

class CustomPaintDiagrams extends StatefulWidget {
  const CustomPaintDiagrams({Key? key}) : super(key: key);

  @override
  State<CustomPaintDiagrams> createState() => _CustomPaintGraphsState();
}

class _CustomPaintGraphsState extends State<CustomPaintDiagrams> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClassicalADAS(),
    );
  }
}
