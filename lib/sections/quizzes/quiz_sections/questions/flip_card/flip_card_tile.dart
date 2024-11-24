import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../quiz_state/quiz_state.dart';

class FlipCardTile extends StatefulWidget {
  const FlipCardTile({
    super.key,
  });

  @override
  State<FlipCardTile> createState() => _FlipCardTileState();
}

class _FlipCardTileState extends State<FlipCardTile> {
  bool _flip1 = false;
  bool _flip2 = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.75,
      child: Stack(
        children: [
          FlipAnimation(
            animate: _flip2,
            reset: false,
            flipFromHalfWay: true,
            animationCompleted: () {},
            child: FlipContents(
              color: Colors.blue,
              flip: () {},
            ),
          ),
          FlipAnimation(
            animate: _flip1,
            reset: false,
            flipFromHalfWay: false,
            animationCompleted: () {
              _flip2 = true;
              setState(() {});
            },
            child: FlipContents(
              color: Colors.red,
              flip: () {
                _flip1 = true;
                setState(
                  () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FlipContents extends ConsumerWidget {
  const FlipContents({required this.flip, required this.color, super.key});

  final Color color;
  final VoidCallback flip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(kBackgroundOpacity),
        ),
        color: color,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: HtmlWidget(
            '${quizState.selectedQuestions[quizState.currentQuestionIndex]}',
          ),
        ),
      ),
    );
  }
}
