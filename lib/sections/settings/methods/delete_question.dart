import 'package:economics_app/sections/quizzes/quiz_init_page.dart';
import 'package:flutter/material.dart';

import '../../../../app/custom_widgets/building_helper.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/custom_widgets/custom_pop_up.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'delete_question_from_firebase.dart';

void deleteQuestion(BuildContext context, QuestionModel q) {
  showDialog(
    context: context,
    builder: (context) => CustomPopup(actionButtons: [
      CustomChipButton(
          text: 'Confirm',
          onPressed: () {
            Navigator.of(context).pop();
            WidgetsBinding.instance.addPostFrameCallback((t) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BuilderHelper(
                    future: deleteQuestionFromFirebase(q.id!),
                    onComplete: (value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const QuizInitPage(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Question deleted'),
                        ),
                      );
                    },
                  ),
                ),
              );
            });
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
