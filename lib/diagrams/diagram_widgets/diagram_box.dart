import 'package:flutter/material.dart';

import '../models/diagram_model.dart';

class DiagramBox extends StatelessWidget {
  const DiagramBox({
    super.key,
    required this.selectedDiagram,
    required this.dimensions,
  });

  final DiagramModel? selectedDiagram;
  final double dimensions;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          width: size.width * dimensions,
          height: size.width * dimensions,
          child: CustomPaint(
            painter: selectedDiagram?.painter,
          ),
        ),
      ),
    );
  }
}

