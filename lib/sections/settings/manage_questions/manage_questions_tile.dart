import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'methods/delete_question.dart';

class ManageQuestionsTile extends ConsumerWidget {
  const ManageQuestionsTile({super.key, required this.q});

  final QuestionModel q;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;
    final editState = ref.watch(editQuestionProvider);
    return ListTile(
      visualDensity: VisualDensity.compact,
      minVerticalPadding: 0,
      dense: true,
      titleAlignment: ListTileTitleAlignment.top,
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          if (value == 'delete') {
            deleteQuestion(context, q);
          } else if (value == 'edit') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddQuestionForm(
                  question: q,
                  questionType: editState.questionType,
                ),
              ),
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            q.question!,
            style: listTileTheme.titleTextStyle
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...q.answers!.map(
                (a) {
                  final color = a.isCorrect
                      ? colorScheme.primary
                      : listTileTheme.titleTextStyle?.color;
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.002),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.005,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (q.answers!.indexOf(a) + 1).toAlphabet(),
                            style: listTileTheme.leadingAndTrailingTextStyle
                                ?.copyWith(
                              color: color,
                              fontWeight: a.isCorrect
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02,
                            ),
                            child: Text(
                              a.answer,
                              style: listTileTheme.subtitleTextStyle?.copyWith(
                                color: color,
                                fontWeight: a.isCorrect
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        if (a.isCorrect) ...[
                          Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          if (q.explanation != null && q.explanation != "") ...[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Explanation: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .primaryColor, // Use the primary color.// Adjust size as needed.
                    ),
                  ),
                  TextSpan(
                    text: q.explanation!,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
