import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../quiz_sections/questions/quiz_models/question_model.dart';
import '../quiz_state/edit_question_state.dart';

void filterSelectedQuestion({
  required EditQuestionState editState,
  required EditQuestionNotifier editNotifier,
  required GlobalKey<FormBuilderState> formKey,
}) {
  final state = formKey.currentState;
  state?.saveAndValidate();
  List<QuestionModel> filteredQuestions = editState.allQuestions.toList();
  final unit = editState.unit;
  final subunit = editState.subunit;

  for (var q in editState.allQuestions) {
    if (q.course != editState.course) {
      filteredQuestions.remove(q);
    }
    if (q.unit != unit) {
      filteredQuestions.remove(q);
    }
    if (q.subunit != subunit) {
      filteredQuestions.remove(q);
    }
  }
  WidgetsBinding.instance.addPostFrameCallback((t) {
    editNotifier.setFilteredQuestions(filteredQuestions);
  });
}
