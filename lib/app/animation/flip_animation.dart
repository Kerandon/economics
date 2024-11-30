import 'dart:math';
import 'package:flutter/material.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation(
      {required this.child,
      required this.animate,
      required this.reset,
      required this.animationHalfCompleted,
      required this.animationCompleted,
      super.key});

  final Widget child;
  final bool animate;
  final bool reset;
  final VoidCallback animationHalfCompleted;
  final VoidCallback animationCompleted;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _halfFlipCallSent = false;

  @override
  initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..addListener(() {
        if (_animationController.value == 1.0) {
          widget.animationCompleted.call();
        }
      });
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  didUpdateWidget(covariant oldWidget) {
    if (widget.reset) {
      _animationController.reset();
    }

    if (widget.animate) {
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        bool mirrorFlip = false;

        if (_animationController.value < 0.50) {
          _halfFlipCallSent = false;
        }
        // print(' ${_animationController.value} call sent $_halfFlipCallSent');
        if (_animationController.value >= 0.50) {
          WidgetsBinding.instance.addPostFrameCallback((t) {
            if (_halfFlipCallSent == false) {
              widget.animationHalfCompleted.call();
              _halfFlipCallSent = true;
            }
          });
          mirrorFlip = true;
        }

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..rotateY((_animationController.value * pi) / 1)
            ..rotateY(mirrorFlip ? pi : 0),
          child: widget.child,
        );
      },
    );
  }
}
