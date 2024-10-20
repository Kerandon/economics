import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlipCardTile extends ConsumerWidget {
  const FlipCardTile({
    super.key,
  });

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
        color: Colors.red,
      ),
      child: Center(
          child: Text(
              '${quizState.selectedQuestions[quizState.currentQuestionIndex]}')),
    );
  }
}
