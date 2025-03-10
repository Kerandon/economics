import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../settings/manage_questions/add_question_page.dart';
import '../../../settings/methods/delete_question.dart';

class EditQuestionButton extends ConsumerWidget {
  const EditQuestionButton({
    super.key,
    required this.question,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'delete') {
          deleteQuestion(
            context,
            question,
          );
        } else if (value == 'edit') {
          editNotifier.setEditExistingQuestion(true);
          WidgetsBinding.instance.addPostFrameCallback((t){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddQuestionPage()),
            );
          });

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
    );
  }
}
