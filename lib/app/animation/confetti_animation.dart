import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfettiAnimation extends ConsumerStatefulWidget {
  const ConfettiAnimation({super.key, this.animate});

  final bool? animate;

  @override
  ConsumerState<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends ConsumerState<ConfettiAnimation> {
  late final ConfettiController _controller;

  @override
  void initState() {
    _controller = ConfettiController(
      duration: const Duration(milliseconds: 300),
    );
    if (widget.animate == null) {
      _controller.play();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ConfettiAnimation oldWidget) {
    if (widget.animate != null && widget.animate == true) {
      _controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment(0, -0.50),
          child: ConfettiWidget(
            canvas: size,
            colors: const [
              Colors.amberAccent,
              Colors.redAccent,
              Colors.pinkAccent,
            ],
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 10,
            maxBlastForce: 100,
            gravity: 0.60,
            minimumSize: const Size(15, 20),
            maximumSize: const Size(20, 25),
            shouldLoop: false,
            confettiController: _controller,
            createParticlePath: (s) => drawStar(s),
          ),
        ),
      ],
    );
  }
}

Path drawStar(Size size) {
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(
      halfWidth + externalRadius * cos(step),
      halfWidth + externalRadius * sin(step),
    );
    path.lineTo(
      halfWidth + internalRadius * cos(step + halfDegreesPerStep),
      halfWidth + internalRadius * sin(step + halfDegreesPerStep),
    );
  }
  path.close();
  return path;
}
