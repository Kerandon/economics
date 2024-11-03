import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_state/edit_question_state.dart';

class NumberOfQuestionsButtons extends ConsumerWidget {
  const NumberOfQuestionsButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return ListTile(
      title: Text('Number of questions'),
      trailing: Wrap(
          alignment: WrapAlignment.center,
          spacing: size.width * kWrapSpacing,
          children: kNumberOfQuestions.map((e) {
        String text = e.toString();
        if (e == -1) {
          text = 'All';
        }
        return CustomChipButton(
            text: text,
            isSelected: e == editState.numberOfQuestions,
            onPressed: () {
              editNotifier.setNumberOfQuestions(e);
            });
      }).toList()),
    );
  }
}
