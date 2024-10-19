import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_change_button.dart';

class QuestionNavigationButtons extends ConsumerWidget {
  const QuestionNavigationButtons({
    super.key,
    required this.pageController,
    required this.disableButtonLeft,
    required this.disableButtonRight,
  });

  final PageController pageController;
  final bool disableButtonLeft;
  final bool disableButtonRight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    return SizedBox(
      width: size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPageChangeButton(
            onPressed: () {
              pageController.animateToPage(quizState.currentQuestionIndex - 1,
                  duration: const Duration(milliseconds: kPageChangeAnimation),
                  curve: Curves.easeInOutCirc);
            },
            iconData: Icons.arrow_back_outlined,
            disable: disableButtonLeft,
          ),
          SizedBox(
            width: size.width * 0.65,
          ),
          CustomPageChangeButton(
            onPressed: () {
              pageController.animateToPage(
                quizState.currentQuestionIndex + 1,
                duration: const Duration(milliseconds: kPageChangeAnimation),
                curve: Curves.easeInOutCirc,
              );
            },
            iconData: Icons.arrow_forward_outlined,
            disable: disableButtonRight,
          ),
        ],
      ),
    );
  }
}
