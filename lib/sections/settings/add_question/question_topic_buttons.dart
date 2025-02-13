import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../enums/column_width.dart';
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
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: CustomColumnWidth.one.getAddDiagramButtonsWidth(),
          child: AutoSizeText('Question Topic'),
        ),
        Expanded(
          flex: CustomColumnWidth.two.getAddDiagramButtonsWidth(),
          child: Wrap(
              alignment: WrapAlignment.start,
              spacing: size.width * kWrapSpacing,
              children: TopicTag.values.map(
                (e) {
                  final topic = editState.currentQuestion.topicTag ??
                      TopicTag.values.first;
                  bool isSelected = false;
                  if (topic == e) {
                    isSelected = true;
                  }
                  final onSurfaceColor =
                      isSelected ? Colors.white : theme.colorScheme.onSurface;
                  return ChoiceChip(
                    checkmarkColor: onSurfaceColor,
                    selectedColor: theme.colorScheme.primary,
                    onSelected: (_) {
                      List<AnswerModel> answers = [];
                      if (e == TopicTag.multipleChoiceQuestions) {
                        answers = adjustAnswersLength(editState, 2);
                      } else {
                        answers = [editState.currentQuestion.answers!.first];
                      }

                      editNotifier.updateCurrentQuestion(
                        editState.currentQuestion.copyWith(
                          questionType: e == TopicTag.multipleChoiceQuestions
                              ? QuestionType.multi
                              : QuestionType.flip,
                          topicTag: e,
                          answers: answers,
                        ),
                      );
                    },
                    label: Text(
                      e.toText(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: onSurfaceColor,
                      ),
                    ),
                    selected: isSelected,
                  );
                },
              ).toList()),
        )
      ],
    );
  }
}
