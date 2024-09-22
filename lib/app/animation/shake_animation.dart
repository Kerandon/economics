import 'dart:math' as math;

import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  const ShakeAnimation(
      {super.key, required this.child, this.animate = false, this.onComplete});

  final Widget child;
  final bool animate;
  final VoidCallback? onComplete;

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shakeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(
          milliseconds: kAnimationDuration,
        ),
        vsync: this)
      ..addListener(() {
        if (_controller.value != 0) {
          widget.onComplete?.call();
        }
      });
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 0.002)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.002, end: -0.001)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween<double>(begin: -0.001, end: 0.0)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 30),
    ]).animate(_controller);
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.01), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.01, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShakeAnimation oldWidget) {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_shakeAnimation.value * math.pi)
                ..scale(_scaleAnimation.value),
              child: widget.child,
            ));
  }
}
