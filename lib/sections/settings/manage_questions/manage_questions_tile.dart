import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_form.dart';
import 'package:flutter/material.dart';

import '../../../app/custom_widgets/building_helper.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/custom_pop_up.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'methods/delete_question_from_firebase.dart';

class ManageQuestionsTile extends StatelessWidget {
  const ManageQuestionsTile({super.key, required this.q});

  final QuestionModel q;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

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
                builder: (context) => AddQuestionForm(question: q),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...q.answers!.map(
            (a) {
              final color = a.isCorrect
                  ? colorScheme.primary
                  : listTileTheme.titleTextStyle?.color;
              return Row(
                children: [
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      (q.answers!.indexOf(a) + 1).toAlphabet(),
                      style:
                          listTileTheme.leadingAndTrailingTextStyle?.copyWith(
                        color: color,
                        fontWeight:
                            a.isCorrect ? FontWeight.bold : FontWeight.normal,
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
                          fontWeight:
                              a.isCorrect ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (a.isCorrect) ...[
                    Icon(
                      Icons.check_circle_outline,
                      size: 12,
                      color: colorScheme.primary,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

void deleteQuestion(BuildContext context, QuestionModel q) {
  showDialog(
    context: context,
    builder: (context) => CustomPopup(actionButtons: [
      CustomChipButton(
          text: 'Confirm',
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BuilderHelper(
                  future: deleteQuestionFromFirebase(q.id!),
                  onComplete: () {
                    WidgetsBinding.instance.addPostFrameCallback((t) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Question deleted'),
                        ),
                      );
                    });
                  },
                ),
              ),
            );
          }),
      CustomChipButton(
        outlinedStyle: true,
        text: 'Cancel',
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ], title: 'Are you sure you want to delete this question?'),
  );
}
