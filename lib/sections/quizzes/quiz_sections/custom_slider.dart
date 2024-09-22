import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
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
    final quizState = ref.watch(quizProvider);

    final numberOfQuestionsAnswered = quizState.selectedQuestions
        .where((element) =>
            element.answerStage == AnswerStage.correct ||
            element.answerStage == AnswerStage.incorrect)
        .length;

    double percentComplete = 0.0;

    if (quizState.selectedQuestions.isNotEmpty) {
      percentComplete =
          numberOfQuestionsAnswered / quizState.selectedQuestions.length;
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
    return SizedBox(
      height: 8,
      width: size.width * 0.70,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => ClipRRect(
          borderRadius: BorderRadius.circular(kRadius),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey.shade300,
            color: Theme.of(context).colorScheme.primary,
            minHeight: size.height * 0.001,
            value: animation.value,
          ),
        ),
      ),
    );
  }
}
