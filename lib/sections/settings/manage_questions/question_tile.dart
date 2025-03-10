import 'package:economics_app/app/custom_widgets/building_helper.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/settings/methods/delete_question_from_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'add_question_page.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({
    super.key,
    required this.q,
  });

  final QuestionModel q;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      title: HtmlWidget(q.question ?? ''),
      trailing: SizedBox(
        width: size.width * 0.10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton(
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text('Edit'),
                  onTap: () {
                    editNotifier
                      ..updateCurrentQuestion(q)
                      ..setNumberOfMultiAnswers(q, q.answers?.length ?? 4)
                      ..setEditExistingQuestion(true);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddQuestionPage(),
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Text('Delete'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BuilderHelper(
                          future: deleteQuestionFromFirebase(q.id!),
                          onComplete: (v) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManageQuestionsPage()));
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...q.answers?.map((a) => Row(
                        children: [
                          HtmlWidget(a.answer),
                          Text('    Correct: ${a.isCorrect.toString()}'),
                        ],
                      )) ??
                  [],
              SizedBox(
                height: 8,
              ),
              Text('Question id ${q.id}'),
              Text('Units are ${q.units?.map((e) => e.name)}'),
              Text('Subunits are ${q.subunits?.map((e) => e.name)}'),
              Text('Tags are ${q.tags?.map((e) => e.name)}')
            ],
          ),
        )
      ],
    );
  }
}
