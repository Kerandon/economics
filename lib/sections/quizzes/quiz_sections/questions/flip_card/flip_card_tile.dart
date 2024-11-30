import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/configs/constants.dart';
import '../../../quiz_state/quiz_state.dart';

class FlipCardTile extends ConsumerWidget {
  const FlipCardTile(this.question, {super.key});

  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    return SizedBox(
      width: size.width * 0.90,
      height: size.height * 0.75,
      child: Stack(
        children: [
          FlipAnimation(
            animate: quizState.flipForward,
            reset: false,
            animationHalfCompleted: () {
              quizNotifier.setCardHasHalfFlipped(true);
            },
            animationCompleted: () {
              quizNotifier.setCardHasFlipped(true);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kRadius),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(kBackgroundOpacity),
                ),
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(kBackgroundOpacity),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    quizState.cardHasHalfFlipped
                        ? question.answers!.first.answer
                        : '${question.question}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
