import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/settings/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quizzes/quiz_state/edit_question_state.dart';

class TopicTagButton extends ConsumerWidget {
  const TopicTagButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: CustomDropdownHeading(c.topicTag?.toText() ?? 'Select topic') ,
          onChanged: (value) {
            editNotifier
                .updateCurrentQuestion(editState.currentQuestion.copyWith(
              topicTag: value,
              questionType: value == TopicTag.multipleChoiceQuestion
                  ? QuestionType.multi
                  : QuestionType.flip,
            ));
          },
          items: [
            ...TopicTag.values.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.toText()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
