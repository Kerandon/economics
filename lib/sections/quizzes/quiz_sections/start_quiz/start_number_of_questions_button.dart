import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/methods/get_pref.dart';
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
    final total = c?.filteredQuestions?.length ?? 0;
// Get all numbers in kMax that are less than or equal to total
    List<int> current =
        kMaxNumberOfQuestions.where((int num) => num <= total).toList();

// Ensure `total` is included in the list if needed
    if (total > kMaxNumberOfQuestions.last ||
        (!current.contains(total) && total > 0)) {
      current.add(total);
      current.sort();
    }


    String heading = current.isEmpty
        ? 'No questions available'
        : c?.numberOfQuestions.toString() ?? '';

    if (current.length == 1 && current.first == 0) {
      current.clear();
    }


// Handle preference updates
    if (current.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (c?.numberOfQuestions == null) {
          startNotifier.updateUserPref(
            p.copyWith(
              question: c?.copyWith(
                numberOfQuestions: current.first,
              ),
            ),
          );
        } else if (c!.numberOfQuestions! > current.last) {
          startNotifier.updateUserPref(
            p.copyWith(
              question: c.copyWith(
                numberOfQuestions: current.last,
              ),
            ),
          );
        }
      });
      if (c?.numberOfQuestions == 0) {
        WidgetsBinding.instance.addPostFrameCallback((t) {
          startNotifier.updateUserPref(
            p.copyWith(
              question: c?.copyWith(
                numberOfQuestions: current.first,
              ),
            ),
          );
        });
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (t) {
          startNotifier.updateUserPref(
            p.copyWith(
              question: c?.copyWith(
                numberOfQuestions: 0,
              ),
            ),
          );
        },
      );
    }
    if(heading == '0'){
      heading = '';
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomDropdownHeading(heading),
        onChanged: (e) {
          startNotifier.updateUserPref(
            p.copyWith(
              question: c?.copyWith(
                numberOfQuestions: e,
              ),
            ),
          );
        },
        items: [
          if (current.isNotEmpty)
            ...current.map(
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
