import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_dropdown_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_units_button.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';
class QuestionTypeButtons extends ConsumerWidget {
  const QuestionTypeButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    final selectionText = (c.questionTypes?.isNotEmpty ?? false)
        ? c.questionTypes!.map((e) => e.toText()).join(', ')
        : 'Select question types';


    return DropdownButtonHideUnderline(
      child: DropdownButton2<QuestionType>(
        customButton: CustomDropdownHeading(selectionText),
        onChanged: (_){},
        items: [
          ...QuestionType.values.map((e) => DropdownMenuItem(
              value: e,
              child: QuestionTypeCustomContents(e)))

        ],


        //   QuestionType.values.map((type) {
        //   final isSelected = c.questionTypes?.contains(type) ?? false;
        //   return DropdownMenuItem<QuestionType>(
        //     value: type,
        //     child: InkWell(
        //       onTap: () {
        //         // final types = c.questionTypes?.toList() ?? [];
        //         //
        //         // if (types.contains(type)) {
        //         //   types.remove(type);
        //         // } else {
        //         //   types.add(type);
        //         // }
        //         //
        //         // editNotifier.updateCurrentQuestion(
        //         //   c.copyWith(questionTypes: types),
        //         // );
        //       },
        //       child: CustomDropdownTile(
        //         text: type.toText(),
        //         isSelected: isSelected,
        //       ),
        //     ),
        //   );
        // }).toList(),
      ),
    );
  }
}

class QuestionTypeCustomContents extends ConsumerWidget {
  const QuestionTypeCustomContents(this.questionType, {super.key});

  final QuestionType questionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final isSelected = c.syllabuses?.contains(questionType) ?? false;
    return InkWell(
      onTap: () {

        editNotifier.updateCurrentQuestion(
          c.copyWith(

          ),
        );
      },
      child: CustomDropdownTile(
        text: questionType.toText(),
        isSelected: isSelected,
      ),
    );
  }
}
