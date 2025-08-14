import 'package:flutter/material.dart';
import 'enums/slide_direction.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation(
      {required this.child,
      required this.direction,
      this.animate = false,
      this.animateOnStart = false,
      this.animationDuration = 900,
      this.reset,
      this.onAnimationComplete,
      this.animationDelay = 0,
      super.key});

  final Widget child;
  final SlideDirection direction;
  final bool animate;
  final bool animateOnStart;
  final bool? reset;
  final VoidCallback? onAnimationComplete;
  final int animationDuration;
  final int animationDelay;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration), vsync: this)
      ..addListener(() {
        if (_animationController.isCompleted) {
          widget.onAnimationComplete?.call();
        }
      });
    if (widget.animateOnStart) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  didUpdateWidget(covariant oldWidget) {
    if (widget.reset == true) {
      _animationController.reset();
    }

    if (widget.animate) {
      if (widget.animationDelay > 0) {
        Future.delayed(Duration(milliseconds: widget.animationDelay), () {
          if (mounted) {
            _animationController.forward();
          }
        });
      } else {
        _animationController.forward();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final Animation<Offset> animation;
    Tween<Offset> tween;

    switch (widget.direction) {
      case SlideDirection.leftAway:
        tween = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(-0.80, 0));
        break;
      case SlideDirection.rightAway:
        tween = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(0.80, 0));
        break;
      case SlideDirection.leftIn:
        tween = Tween<Offset>(
            begin: const Offset(-0.80, 0), end: const Offset(0, 0));
        break;
      case SlideDirection.rightIn:
        tween = Tween<Offset>(
            begin: const Offset(0.80, 0), end: const Offset(0, 0));
        break;
      case SlideDirection.upIn:
        tween = Tween<Offset>(
            begin: const Offset(
              0,
              0.80,
            ),
            end: const Offset(0, 0));
        break;
      case SlideDirection.none:
        tween = Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, 0),
        );
        break;
    }

    animation = tween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    return SlideTransition(
      position: animation,
      child: widget.child,
    );
  }
}
