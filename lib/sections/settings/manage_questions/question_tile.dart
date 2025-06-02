import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/building_helper.dart';
import 'package:economics_app/app/enums/syllabus_enum.dart';
import 'package:economics_app/sections/diagrams/diagram_widgets/custom_diagram_builder.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
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
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HtmlWidget(q.question ?? ''),
          CustomDiagramBuilder(diagrams: q.diagrams?.toList())
        ],
      ),
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
                      //.setNumberOfMultiAnswers(q, q.answers?.length ?? 4)
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
              ...q.answers?.map(
                    (a) => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: HtmlWidget(a.answer)),
                            if (q.questionTypes?[0] == QuestionType.multi) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * kPageIndentHorizontal,
                                ),
                                child: Text(
                                  a.isCorrect == true ? 'Correct' : 'Incorrect',
                                ),
                              ),
                            ],
                          ],
                        ),
                        CustomDiagramBuilder(diagrams: a.diagrams?.toList()),
                      ],
                    ),
                  ) ??
                  [],
              SizedBox(
                height: 8,
              ),
              Text('ID: ${q.id}'),
              Text('SYLLABUS: ${q.syllabuses?[0].syllabus?.toText()}'),
              Text(
                  'UNIT: ${q.units?.map((e) => e.name).join(", ") ?? ""}, ${q.subunits?.map((e) => e.name).join(", ") ?? ""}'),
              Text('TAGS ${q.tags?.map((e) => e.name).join(", ") ?? ""}'),
            ],
          ),
        )
      ],
    );
  }
}
