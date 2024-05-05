import 'dart:math';

import 'package:economics_app/app/animation/confetti_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopOutAnimation extends StatefulWidget {
  const PopOutAnimation({super.key, required this.child,
    this.animate});

  final Widget child;
  final bool? animate;

  @override
  State<PopOutAnimation> createState() => _PopOutAnimationState();
}

class _PopOutAnimationState extends State<PopOutAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.1)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 80),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.1, end: 1.0)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 30),
      // TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.0), weight: 40),
    ]).animate(_controller);
    if(widget.animate == null){
      _controller.forward();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PopOutAnimation oldWidget) {
    if(widget.animate != null && widget.animate!){
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
    print(_controller.value);
    return AnimatedBuilder(
        animation: _animation, builder: (context, child) {
          return
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..scale(_animation.value),
              child: widget.child);

        });
  }
}
