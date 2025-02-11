import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/methods/get_current_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSlider extends ConsumerStatefulWidget {
  const CustomSlider({
    super.key,
  });

  @override
  ConsumerState<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends ConsumerState<CustomSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double beginValue = 0.0, endValue = 0.0;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quizState = ref.watch(quizProvider);
    final startState = ref.watch(startQuizProvider);
    final showAnswersAtEnd =
        getCurrentPref(startState).showAnswersAtEnd ?? false;
    int numberAnsweredOrSelected = 0;

    if (showAnswersAtEnd && !quizState.quizIsCompleted) {
      numberAnsweredOrSelected = quizState.selectedQuestions
          .where((element) => element.answerStage == AnswerStage.selected)
          .length;
    } else {
      numberAnsweredOrSelected = quizState.selectedQuestions
          .where((element) =>
              element.answerStage == AnswerStage.correct ||
              element.answerStage == AnswerStage.incorrect)
          .length;
    }

    double percentComplete = 0.0;

    if (quizState.selectedQuestions.isNotEmpty) {
      percentComplete =
          numberAnsweredOrSelected / quizState.selectedQuestions.length;
    }

    endValue = percentComplete;
    if (endValue == 0) {
      beginValue = 0;
    }
    final animation = Tween<double>(begin: beginValue, end: endValue).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc));

    _controller.reset();
    _controller.forward();
    beginValue = endValue;

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 8,
            child: SizedBox(
              height: 12,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(kRadius),
                  child: LinearProgressIndicator(
                    minHeight: size.height * 0.003,
                    value: animation.value,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.01),
            child: Center(
              child: Text(
                  '${quizState.currentQuestionIndex + 1} of ${quizState.selectedQuestions.length}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
