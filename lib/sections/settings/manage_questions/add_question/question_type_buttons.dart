import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../quizzes/quiz_enums/question_type.dart';
import '../../../quizzes/quiz_enums/topic_tag.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

class QuestionTypeButtons extends ConsumerWidget {
  const QuestionTypeButtons({
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
          flex: 1,
          child: AutoSizeText('Question Topic'),
        ),
        Expanded(
          flex: 6,
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
                      editNotifier.updateCurrentQuestion(
                        editState.currentQuestion.copyWith(
                          questionType: e == TopicTag.multipleChoiceQuestions
                              ? QuestionType.multi
                              : QuestionType.flip,
                          topicTag: e,
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
