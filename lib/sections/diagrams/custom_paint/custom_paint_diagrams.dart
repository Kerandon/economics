import 'package:flutter/material.dart';

class CustomPaintDiagrams extends StatefulWidget {
  const CustomPaintDiagrams({super.key});

  @override
  State<CustomPaintDiagrams> createState() => _CustomPaintGraphsState();
}

class _CustomPaintGraphsState extends State<CustomPaintDiagrams> {
  final List<CustomPainter> _diagrams = [];

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
      height: size.height,
      child: CustomPaint(
        painter: customPainter,
      ),
    );
  }
}
