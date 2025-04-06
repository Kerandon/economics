import 'package:economics_app/sections/diagrams/diagram_widgets/custom_diagram_builder.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../quizzes/quiz_enums/question_key.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import 'add_diagram_to_question_dialog.dart';

class QuestionButton extends ConsumerWidget {
  const QuestionButton({
    super.key,
    this.initialValue,
  });

  final String? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                initialValue: initialValue,
                label: 'Question',
                name: QuestionKey.question.name,
                onChanged: (value) {
                  editNotifier.updateCurrentQuestion(
                    c.copyWith(question: value),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddDiagramToQuestionDialog(),
                    );
                  },
                  icon: Icon(
                    Icons.insert_chart_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Add image'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.image_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
        CustomDiagramBuilder(
          diagrams: c.diagrams?.toList(),
        ),
      ],
    );
  }
}
