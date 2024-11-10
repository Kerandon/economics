import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../quiz_sections/questions/quiz_models/question_model.dart';
import '../quiz_state/edit_question_state.dart';
import '../quiz_state/quiz_state.dart';

List<QuestionModel> filterSelectedQuestion({
  required EditQuestionState editState,
  required EditQuestionNotifier editNotifier,
  required QuizNotifier quizNotifier,
  required GlobalKey<FormBuilderState> formKey,
}) {
  final state = formKey.currentState;
  state?.saveAndValidate();
  List<QuestionModel> selectedQuestions = editState.allQuestions.toList();
  final unit = editState.unit;
  final subunit = editState.subunit;

  for (var q in editState.allQuestions) {
    if (q.course != editState.course) {
      selectedQuestions.remove(q);
    }
    if (q.unit != unit) {
      selectedQuestions.remove(q);
    }
    if (q.subunit != subunit) {
      selectedQuestions.remove(q);
    }
  }
  return selectedQuestions.toList();
}
