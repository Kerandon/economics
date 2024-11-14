import 'dart:math' as math;

import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class RotateAroundAnimation extends StatefulWidget {
  const RotateAroundAnimation({
    super.key,
    required this.child,
    this.beginValue = 0.20,
    this.duration = kAnimationDuration,
    this.disable = false,
  });

  final Widget child;
  final double beginValue;
  final int duration;
  final bool disable;

  @override
  State<RotateAroundAnimation> createState() => _RotateAroundAnimationState();
}

class _RotateAroundAnimationState extends State<RotateAroundAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    _animation = Tween<double>(begin: widget.beginValue, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));

    if (mounted && !widget.disable) {
      _controller.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.disable
        ? widget.child
        : AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(
                  ((_animation.value) * math.pi),
                ),
              child: widget.child,
            ),
          );
  }
}
