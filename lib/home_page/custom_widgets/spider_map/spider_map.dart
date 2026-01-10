import 'dart:math';
import 'package:flutter/material.dart';

import 'block_points_painter.dart';

class SpiderMap extends StatelessWidget {
  final String centerText;
  final List<String> points;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double baseRadius;

  const SpiderMap({
    super.key,
    required this.centerText,
    required this.points,
    this.primaryColor,
    this.secondaryColor,
    this.baseRadius = 180.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color centerCol =
        primaryColor ?? Theme.of(context).colorScheme.primary;
    final Color pointCol =
        secondaryColor ?? Theme.of(context).colorScheme.scrim;
    // LayoutBuilder makes it safe for mobile screens (prevents overflow)
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate a square size that fits the width but maxes out at 400
        final size = min(constraints.maxWidth, 600.0);

        // Scale the radius down if the screen is tiny
        final scaleFactor = size / 400.0;
        final effectiveRadius = baseRadius * scaleFactor;

        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: BlockPointsPainter(
                centerText: centerText,
                points: points,
                centerColor: centerCol,
                pointColor: pointCol,
                radius: effectiveRadius,
              ),
            ),
          ),
        );
      },
    );
  }
}
