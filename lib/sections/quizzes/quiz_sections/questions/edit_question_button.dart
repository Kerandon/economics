import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';

import '../../../settings/add_question/add_question_page.dart';
import '../../../settings/methods/delete_question.dart';

class EditQuestionButton extends StatelessWidget {
  const EditQuestionButton({
    super.key,
    required this.question,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'delete') {
          deleteQuestion(
            context,
            question,
          );
        } else if (value == 'edit') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddQuestionPage(editQuestion: true,)),
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
    );
  }
}
