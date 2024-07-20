import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSlider extends ConsumerWidget {
  const CustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);

    const sliderHeight = 8.0;
    final numberOfQuestionsAnswered = quizState.selectedQuestions
        .where((element) =>
            element.answerStage == AnswerStage.correct ||
            element.answerStage == AnswerStage.incorrect)
        .length;

    double value = 0.0;
    if (quizState.selectedQuestions.isNotEmpty) {
      value = numberOfQuestionsAnswered / quizState.selectedQuestions.length;
    }

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: sliderHeight,
      width: size.width * 0.70,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(138)),
        child: Transform.scale(
          scaleX: 1,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: sliderHeight,
              thumbShape: SliderComponentShape.noThumb,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              trackShape: const RectangularSliderTrackShape(),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
            ),
            child: Slider(
              thumbColor: Colors.transparent,
              value: value,
              onChanged: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}
