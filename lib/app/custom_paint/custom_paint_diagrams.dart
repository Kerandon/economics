import 'package:economics_app/app/custom_paint/diagrams/circular_flow_closed.dart';
import 'package:economics_app/app/custom_paint/diagrams/classical_equilibrium.dart';
import 'package:flutter/material.dart';
import 'diagrams/ad.dart';
import 'diagrams/ad_increase.dart';
import 'diagrams/adsras.dart';
import 'diagrams/business_cycle.dart';
import 'diagrams/keynesian_adas.dart';

class CustomPaintDiagrams extends StatefulWidget {
  const CustomPaintDiagrams({Key? key}) : super(key: key);

  @override
  State<CustomPaintDiagrams> createState() => _CustomPaintGraphsState();
}

class _CustomPaintGraphsState extends State<CustomPaintDiagrams> {
  final List<CustomPainter> _diagrams = [
    CircularFlowClosed(),
    ClassicalEquilibrium(),
    BusinessCycle(),
    KeynesianADAS(),
    AD(),
    ADIncrease(),
    ClassicalADAS(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: _diagrams.map((e) => DiagramBox(customPainter: e)).toList());
  }
}

class DiagramBox extends StatelessWidget {
  const DiagramBox({
    super.key,
    required this.customPainter,
  });

  final CustomPainter customPainter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width,
      child: CustomPaint(
        painter: customPainter,
      ),
    );
  }
}
