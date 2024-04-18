import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_enums/answer_stage.dart';
import '../quiz_models/answer_model.dart';
import '../quiz_models/question_model.dart';

class QuizState {
  final List<QuestionModel> allQuestions;
  final List<QuestionModel> currentQuestions;
  final bool questionsAllSelected;
  final bool questionsAllAnswered;
  final bool resetQuestions;
  final int numberOfQuestionsCorrect;

  QuizState({
    required this.allQuestions,
    required this.currentQuestions,
    required this.questionsAllSelected,
    required this.questionsAllAnswered,
    required this.resetQuestions,
    required this.numberOfQuestionsCorrect,
  });

  QuizState copyWith({
    List<QuestionModel>? allQuestions,
    List<QuestionModel>? currentQuestions,
    bool? questionsAllSelected,
    bool? questionsAllAnswered,
    bool? resetQuestions,
    int? numberOfQuestionsCorrect,
  }) {
    return QuizState(
      allQuestions: allQuestions ?? this.allQuestions,
      currentQuestions: currentQuestions ?? this.currentQuestions,
      questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
      questionsAllAnswered: questionsAllAnswered ?? this.questionsAllAnswered,
      resetQuestions: resetQuestions ?? this.resetQuestions,
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

    state = state.copyWith(currentQuestions: uniqueQuestionsList);
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
    List<QuestionModel> updatedCurrentQuestions = state.currentQuestions;
    final questionIndex = updatedCurrentQuestions.indexOf(question);
    updatedCurrentQuestions.removeAt(questionIndex);
    updatedCurrentQuestions.insert(questionIndex, updatedQuestion);

    state = state.copyWith(currentQuestions: updatedCurrentQuestions);

    /// Check if all questions are selected (enable the user to check the answer).
    if (state.currentQuestions
        .every((element) => element.answerStage == AnswerStage.selected)) {
      state = state.copyWith(questionsAllSelected: true);
    }
  }

  void checkAllAnswers() {
    List<QuestionModel> updatedQuestions = [];

    for (var question in state.currentQuestions) {
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
        currentQuestions: updatedQuestions,
        numberOfQuestionsCorrect: numberOfCorrect);
  }

  void setQuestionsAllSelected(bool selected) {
    state = state.copyWith(questionsAllSelected: selected);
  }

  void setQuestionsAllAnswered(bool selected) {
    state = state.copyWith(questionsAllAnswered: selected);
  }

  void setResetQuestions(bool reset) {
    if (reset) {
      state = state.copyWith(
        resetQuestions: true,
        currentQuestions: [],
        questionsAllSelected: false,
        questionsAllAnswered: false,
      );
    } else {
      state = state.copyWith(resetQuestions: false);
    }
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(
    QuizState(
      allQuestions: [],
      currentQuestions: [],
      questionsAllSelected: false,
      questionsAllAnswered: false,
      resetQuestions: false,
      numberOfQuestionsCorrect: 0,
    ),
  ),
);
