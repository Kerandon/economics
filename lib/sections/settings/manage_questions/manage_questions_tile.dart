import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/diagrams/utils/methods/get_diagrams_to_display.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/custom_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/flip_card_tag.dart';

import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_tag_box.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'methods/delete_question.dart';

class ManageQuestionsTile extends ConsumerWidget {
  const ManageQuestionsTile({super.key, required this.q});

  final QuestionModel q;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

    List<CustomPainter> diagrams = [];
    if (q.diagrams?.isNotEmpty ?? false) {
      diagrams = getDiagramsToDisplay(size, context, q.diagrams!).toList();
    }

    return ListTile(
      dense: true,
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
          HtmlWidget(
            q.question!,
            textStyle: listTileTheme.titleTextStyle
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
                  return Row(
                    children: [
                      if (editState.questionType == QuestionType.multi) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 1, bottom: 1, right: 8),
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
                      ],
                      Expanded(
                        flex: 50,
                        child: HtmlWidget(
                          a.answer,
                          textStyle: listTileTheme.subtitleTextStyle?.copyWith(
                            color: color,
                            fontWeight: a.isCorrect
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
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
          if (diagrams.isNotEmpty) ...[
            SizedBox(
              height: size.height * 0.10,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: diagrams.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: size.height * 0.10,
                      height: size.height * 0.10,
                      child: CustomPaint(painter: diagrams[index])),
                ),
              ),
            )
          ],
          if (q.flipCardTag != null && q.flipCardTag?.name != "") ...[
            CustomTagBox(text: q.flipCardTag?.toText() ?? ""),
          ],
          if (q.customTags != null && q.customTags!.isNotEmpty) ...[
            Wrap(
              children: q.customTags!
                  .map(
                    (e) => CustomTagBox(
                      text: e.toText(),
                    ),
                  )
                  .toList(),
            )
          ],
        ],
      ),
    );
  }
}
