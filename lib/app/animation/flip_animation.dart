import 'dart:math';
import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

enum FlipDirection { forward, reverse }

enum CardSide { front, back }

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({
    required this.child,
    required this.animate,
    this.reverse = false,
    this.isAnimating,
    required this.animationHalfCompleted,
    required this.animationCompleted,
    super.key,
  });

  final Widget child;
  final bool animate;
  final bool reverse;
  final Function(bool)? isAnimating;
  final Function(CardSide) animationHalfCompleted;
  final Function(FlipDirection) animationCompleted;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;
  bool _cardSideOnFrontCallSent = false, _cardSideOnBackCallSent = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: kAnimationDuration),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInSine, // Customize the curve here
    );

    _animationController.addListener(() {
      if (_animationController.value == 1.0) {
        widget.animationCompleted.call(FlipDirection.forward);
      }
      if (_animationController.value == 0.0) {
        widget.animationCompleted.call(FlipDirection.reverse);
      }
      if (_animationController.isAnimating) {
        widget.isAnimating?.call(true);
      } else {
        widget.isAnimating?.call(false);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlipAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate) {
      if (widget.reverse) {
        _animationController.animateBack(0);
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        bool mirrorFlip = false;

        if (_curvedAnimation.value >= 0.50) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_cardSideOnBackCallSent) {
              widget.animationHalfCompleted.call(CardSide.back);
              _cardSideOnBackCallSent = true;
              _cardSideOnFrontCallSent = false;
            }
          });
          mirrorFlip = true;
        }
        if (_curvedAnimation.value <= 0.50) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_cardSideOnFrontCallSent) {
              widget.animationHalfCompleted.call(CardSide.front);
              _cardSideOnFrontCallSent = true;
              _cardSideOnBackCallSent = false;
            }
          });
        }

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0003)
            ..rotateX(((_curvedAnimation.value * pi) / 1))
            ..rotateX(mirrorFlip ? pi : 0),
          child: widget.child,
        );
      },
    );
  }
}
