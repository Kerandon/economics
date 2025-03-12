import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/methods/get_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/max_questions.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartNumberOfQuestionsButton extends ConsumerWidget {
  const StartNumberOfQuestionsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final p = getPref(startState);
    final c = p.question;
    final totalActualQuestions = c?.filteredQuestions?.toList() ?? 0;
    List<int> n = MaxQuestions.values.map((e) => e.toInt()).toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomDropdownHeading('Number of questions'),
        onChanged: (_) {},
        items: [
          ...n.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
