import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopOutAnimation extends StatefulWidget {
  const PopOutAnimation({
    super.key,
    required this.child,
    this.animate,
    this.startPos = 0.0,
    this.duration = kAnimationDuration,
    this.addPop = false,
    this.onAnimationEnd,
  });

  final Widget child;
  final bool? animate;
  final double startPos;
  final int duration;
  final bool addPop;
  final VoidCallback? onAnimationEnd;

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
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = TweenSequence<double>([
      if (!widget.addPop) ...[
        TweenSequenceItem(
          tween: Tween<double>(
            begin: widget.startPos,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 80,
        ),
      ],
      if (widget.addPop) ...[
        TweenSequenceItem(
          tween: Tween<double>(
            begin: widget.startPos,
            end: 1.1,
          ).chain(CurveTween(curve: Curves.bounceOut)),
          weight: 40,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.1,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.bounceIn)),
          weight: 80,
        ),
      ],
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.onAnimationEnd != null) {
        widget.onAnimationEnd!();
      }
    });

    if (widget.animate == null) {
      _controller.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PopOutAnimation oldWidget) {
    if (widget.animate != null && widget.animate!) {
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
      animation: _animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..scale(_animation.value),
          child: widget.child,
        );
      },
    );
  }
}
