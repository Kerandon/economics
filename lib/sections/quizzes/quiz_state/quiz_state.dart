import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/audio_manager.dart';
import '../custom_widgets/gif_box.dart';
import '../methods/show_quick_pop_box.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_sections/questions/quiz_models/answer_model.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

class QuizState {
  final List<QuestionModel> selectedQuestions;
  final bool questionsAllSelected;
  final int numberOfQuestionsCorrect;
  final int numberOfQuestionsSelected;
  final int currentQuestionIndex;

  QuizState({
    required this.selectedQuestions,
    required this.questionsAllSelected,
    required this.numberOfQuestionsCorrect,
    required this.numberOfQuestionsSelected,
    required this.currentQuestionIndex,
  });

  QuizState copyWith({
    List<QuestionModel>? selectedQuestions,
    bool? questionsAllSelected,
    int? numberOfQuestionsCorrect,
    int? numberOfQuestionsSelected,
    int? currentQuestionIndex,
  }) {
    return QuizState(
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
      numberOfQuestionsCorrect:
          numberOfQuestionsCorrect ?? this.numberOfQuestionsCorrect,
      numberOfQuestionsSelected:
          numberOfQuestionsSelected ?? this.numberOfQuestionsSelected,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(super._state);

  void setSelectedQuestions(List<QuestionModel> questions) {
    Set<QuestionModel> uniqueQuestions = questions.toSet();

    List<QuestionModel> uniqueQuestionsList = uniqueQuestions.toList();

    state = state.copyWith(selectedQuestions: uniqueQuestionsList..shuffle());
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
    List<AnswerModel> updatedAnswers = updatedQuestion.answers!;

    for (var a in question.answers!) {
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

  void checkAnswer(
      {required BuildContext context, required QuestionModel question}) {
    if (question.answerStage == AnswerStage.selected) {}

    List<AnswerModel> answers = question.answers!.toList();
    for (int i = 0; i < answers.length; i++) {
      if (answers[i].answerStage == AnswerStage.selected) {
        if (answers[i].isCorrect) {
          answers[i] = answers[i].copyWith(answerStage: AnswerStage.correct);
        } else {
          answers[i] = answers[i].copyWith(answerStage: AnswerStage.incorrect);
        }
      } else {
        if (answers[i].isCorrect) {
          answers[i] = answers[i].copyWith(answerStage: AnswerStage.incorrect);
        }
      }
    }
    question = question.copyWith(answers: answers);
    if (question.answers!
        .any((answer) => answer.answerStage == AnswerStage.incorrect)) {
      question = question.copyWith(answerStage: AnswerStage.incorrect);
    } else {
      question = question.copyWith(answerStage: AnswerStage.correct);
    }

    /// Update state
    List<QuestionModel> questions = state.selectedQuestions.toList();

    for (int i = 0; i < questions.length; i++) {
      if (questions[i].question == question.question) {
        questions[i] = question;
      }
    }

    state = state.copyWith(selectedQuestions: questions);
    if (question.answerStage == AnswerStage.correct) {
      showQuickPopup(context, const GifBox(filesUrl: 'assets/gifs/correct/'));
      AudioManager.playRandomAudio('assets/audio/correct/');
    }
    if (question.answerStage == AnswerStage.incorrect) {
      AudioManager.playRandomAudio('assets/audio/incorrect/');
    }
  }

  void checkAllAnswers() {
    List<QuestionModel> updatedQuestions = [];

    for (var question in state.selectedQuestions) {
      List<AnswerModel> updatedAnswers = [];
      for (var answer in question.answers!) {
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
        selectedQuestions: updatedQuestions,
        numberOfQuestionsCorrect: numberOfCorrect);
  }

  void setNumberOfQuestionsSelected(int number) {
    state = state.copyWith(numberOfQuestionsSelected: number);
  }

  void setCurrentQuestionIndex(int index) {
    state = state.copyWith(currentQuestionIndex: index);
  }

  void setResetQuestions() {
    state = state.copyWith(
      selectedQuestions: [],
      questionsAllSelected: false,
      numberOfQuestionsCorrect: 0,
      currentQuestionIndex: 0,
    );
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(
    QuizState(
      selectedQuestions: [],
      questionsAllSelected: false,
      numberOfQuestionsCorrect: 0,
      numberOfQuestionsSelected: 5,
      currentQuestionIndex: 0,
    ),
  ),
);
