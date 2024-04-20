import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_enums/answer_stage.dart';
import '../quiz_models/answer_model.dart';
import '../quiz_models/question_model.dart';

class QuizState {
  final List<QuestionModel> allQuestions;
  final List<QuestionModel> selectedQuestions;
  final bool questionsAllSelected;
  final bool questionsAllAnswered;
  final bool questionsAreSet;
  final int numberOfQuestionsCorrect;

  QuizState({
    required this.allQuestions,
    required this.selectedQuestions,
    required this.questionsAllSelected,
    required this.questionsAllAnswered,
    required this.questionsAreSet,
    required this.numberOfQuestionsCorrect,
  });

  QuizState copyWith({
    List<QuestionModel>? allQuestions,
    List<QuestionModel>? selectedQuestions,
    bool? questionsAllSelected,
    bool? questionsAllAnswered,
    bool? questionsAreSet,
    int? numberOfQuestionsCorrect,
  }) {
    return QuizState(
      allQuestions: allQuestions ?? this.allQuestions,
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
      questionsAllAnswered: questionsAllAnswered ?? this.questionsAllAnswered,
      questionsAreSet: questionsAreSet ?? this.questionsAreSet,
      numberOfQuestionsCorrect:
          numberOfQuestionsCorrect ?? this.numberOfQuestionsCorrect,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(state) : super(state);

  void setAllQuestions(List<QuestionModel> questions) {
    state = state.copyWith(allQuestions: questions);
  }

  void setCurrentQuestions(List<QuestionModel> questions) {
    // Convert the list to a set to remove duplicates
    Set<QuestionModel> uniqueQuestions = questions.toSet();

    // Convert the set back to a list
    List<QuestionModel> uniqueQuestionsList = uniqueQuestions.toList();

    state = state.copyWith(selectedQuestions: uniqueQuestionsList);
  }

  void setQuestionAsSelected(QuestionModel question, AnswerModel answer) {
    /// Create a question variable that can be updated
    QuestionModel updatedQuestion = question;

    /// Change [AnswerStage] to [selected] (if not yet).
    if (updatedQuestion.answerStage == AnswerStage.notSelected) {
      updatedQuestion =
          updatedQuestion.copyWith(answerStage: AnswerStage.selected);
    }

    /// Create an [AnswerModel] variable
    List<AnswerModel> updatedAnswers = updatedQuestion.answers;

    for (var a in question.answers) {
      if (a.answerStage == AnswerStage.selected && a != answer) {
        final i = updatedAnswers.indexOf(a);
        updatedAnswers.removeAt(i);
        updatedAnswers.insert(
            i, a.copyWith(answerStage: AnswerStage.notSelected));
      }
    }

    for (var a in updatedAnswers) {
      if (a == answer) {
        final i = updatedAnswers.indexOf(a);
        updatedAnswers.removeAt(i);
        updatedAnswers.insert(i, a.copyWith(answerStage: AnswerStage.selected));
      }
    }

    updatedQuestion = updatedQuestion.copyWith(answers: updatedAnswers);
    List<QuestionModel> updatedCurrentQuestions = state.selectedQuestions;
    final questionIndex = updatedCurrentQuestions.indexOf(question);
    updatedCurrentQuestions.removeAt(questionIndex);
    updatedCurrentQuestions.insert(questionIndex, updatedQuestion);

    state = state.copyWith(selectedQuestions: updatedCurrentQuestions);

    /// Check if all questions are selected (enable the user to check the answer).
    if (state.selectedQuestions
        .every((element) => element.answerStage == AnswerStage.selected)) {
      state = state.copyWith(questionsAllSelected: true);
    }
  }

  void checkAllAnswers() {
    List<QuestionModel> updatedQuestions = [];

    for (var question in state.selectedQuestions) {
      List<AnswerModel> updatedAnswers = [];
      for (var answer in question.answers) {
        AnswerModel updatedAnswer = answer;
        if (answer.answerStage == AnswerStage.selected) {
          if (answer.isCorrect) {
            updatedAnswer =
                updatedAnswer.copyWith(answerStage: AnswerStage.correct);
          } else {
            updatedAnswer =
                updatedAnswer.copyWith(answerStage: AnswerStage.incorrect);
          }
        }
        updatedAnswers.add(updatedAnswer);
      }
      final questionIsCorrectlyAnswered = updatedAnswers
          .any((answer) => answer.answerStage == AnswerStage.correct);
      QuestionModel updatedQuestion = question.copyWith(
          answerStage: questionIsCorrectlyAnswered
              ? AnswerStage.correct
              : AnswerStage.incorrect,
          answers: updatedAnswers);
      updatedQuestions.add(updatedQuestion);
    }

    /// Calculate number of correctly answered questions
    int numberOfCorrect = 0;
    for (var question in updatedQuestions) {
      if (question.answerStage == AnswerStage.correct) {
        numberOfCorrect++;
      }
    }

    state = state.copyWith(
        questionsAllAnswered: true,
        selectedQuestions: updatedQuestions,
        numberOfQuestionsCorrect: numberOfCorrect);
  }

  void setQuestionsAllSelected(bool selected) {
    state = state.copyWith(questionsAllSelected: selected);
  }

  void setQuestionsAllAnswered(bool selected) {
    state = state.copyWith(questionsAllAnswered: selected);
  }

  void setResetQuestions() {
    state = state.copyWith(
      selectedQuestions: [],
      questionsAllSelected: false,
      questionsAllAnswered: false,
      numberOfQuestionsCorrect: 0,
    );
  }


  void setQuestionsAreSet(bool set){
    state = state.copyWith(questionsAreSet: set);
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(
    QuizState(
      allQuestions: [],
      selectedQuestions: [],
      questionsAllSelected: false,
      questionsAllAnswered: false,
      questionsAreSet: false,
      numberOfQuestionsCorrect: 0,
    ),
  ),
);
