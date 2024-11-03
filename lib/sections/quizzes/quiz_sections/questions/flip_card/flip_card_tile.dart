import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlipCardTile extends ConsumerStatefulWidget {
  const FlipCardTile({
    super.key,
  });

  @override
  ConsumerState<FlipCardTile> createState() => _FlipCardTileState();
}

class _FlipCardTileState extends ConsumerState<FlipCardTile> {
  bool _flip1 = false;
  bool _flip2 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Stack(
        children: [
          FlipAnimation(
              animate: _flip1,
              reset: false,
              flipFromHalfWay: false,
              animationCompleted: () {
                _flip2 = true;
                setState(() {});
              },
              child: const FlipContents(Colors.red)),
          FlipAnimation(
            animate: _flip2,
            reset: false,
            flipFromHalfWay: true,
            animationCompleted: () {},
            child: const FlipContents(Colors.blue),
          ),
          OutlinedButton(
              onPressed: () {
                _flip1 = true;
                setState(() {});
              },
              child: const Text('flip'))
        ],
      ),
    );
  }
}

class FlipContents extends ConsumerWidget {
  const FlipContents(this.color, {super.key});

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    return Container(
      width: size.width * 0.80,
      height: size.height * 0.80,
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
      child: Column(
        children: [
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(-1.0, 1.0),
              child: Text(
                '${quizState.selectedQuestions[quizState.currentQuestionIndex]}',
                textDirection:
                    TextDirection.ltr, // Ensure left-to-right text direction
              ),
            ),
          ),
          OutlinedButton(onPressed: () {}, child: const Text('flip'))
        ],
      ),
    );
  }
}
