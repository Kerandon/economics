import 'package:economics_app/sections/quizzes/custom_widgets/filter_contents.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizFilterButton extends ConsumerWidget {
  const QuizFilterButton({this.showExtraButtons = true, super.key});

  final bool showExtraButtons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => FilterContents(
                showExtraButtons: showExtraButtons,
              ),
            );
          },
        ),
        Text(
          editState.filteredQuestions.length.toString(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
