import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_enums/question_type.dart';
import '../../quizzes/quiz_enums/topic_tag.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'number_of_answers_buttons.dart';

class QuestionTopicButtons extends ConsumerWidget {
  const QuestionTopicButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    // Get the current topic or default to the first one
    final currentTopic =
        editState.currentQuestion.topicTag ?? TopicTag.values.first;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: DropdownMenu<TopicTag>(
        width: size.width,
        initialSelection: currentTopic,
        onSelected: (TopicTag? newTopic) {
          if (newTopic != null) {
            List<AnswerModel> answers = [];
            if (newTopic == TopicTag.multipleChoiceQuestions) {
              answers = adjustAnswersLength(editState, 2);
            } else {
              answers = [editState.currentQuestion.answers!.first];
            }

            editNotifier.updateCurrentQuestion(
              editState.currentQuestion.copyWith(
                questionType: newTopic == TopicTag.multipleChoiceQuestions
                    ? QuestionType.multi
                    : QuestionType.flip,
                topicTag: newTopic,
                answers: answers,
              ),
            );
          }
        },
        dropdownMenuEntries: TopicTag.values.map<DropdownMenuEntry<TopicTag>>(
          (TopicTag topic) {
            return DropdownMenuEntry<TopicTag>(
              value: topic,
              label: topic
                  .toText(), // Assuming `toText()` converts TopicTag to a displayable string
            );
          },
        ).toList(),
      ),
    );
  }
}
