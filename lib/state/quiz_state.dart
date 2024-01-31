import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/utils/enums/answer_stage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/answer_model.dart';

class QuizState {
  final List<QuestionModel> currentQuestions;

  QuizState({required this.currentQuestions});

  QuizState copyWith({List<QuestionModel>? currentQuestions}) {
    return QuizState(
        currentQuestions: currentQuestions ?? this.currentQuestions);
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(state) : super(state);

  void setCurrentQuestions(List<QuestionModel> questions) {
    state = state.copyWith(currentQuestions: questions);
  }

  void setQuestionAsSelected(QuestionModel question, AnswerModel answer) {
    if (question.answerStage == AnswerStage.notAnswered ||
        question.answerStage == AnswerStage.selected) {
      List<QuestionModel> allCurrentQuestions = state.currentQuestions;
      QuestionModel q = question;
      List<AnswerModel> answersList = q.answers.toList();

      List<AnswerModel> resetAnswerList = [];
      if (question.answerStage == AnswerStage.selected) {
        for (var a in answersList) {
          resetAnswerList.add(a.copyWith(answerStage: AnswerStage.notAnswered));
        }
      } else {
        resetAnswerList = question.answers.toList();
        q = q.copyWith(answerStage: AnswerStage.selected);
      }

      AnswerModel a = resetAnswerList
          .firstWhere((element) => element.answer == answer.answer);
      final answerUpdated = a.copyWith(answerStage: AnswerStage.selected);

      final index = resetAnswerList.indexOf(a);
      resetAnswerList
        ..removeAt(index)
        ..insert(index, answerUpdated);

      // Update the QuestionModel with the updated answersList
      QuestionModel updatedQuestion = q.copyWith(answers: resetAnswerList);

      final questionIndex = allCurrentQuestions.indexOf(question);
      allCurrentQuestions
        ..removeAt(questionIndex)
        ..insert(questionIndex, updatedQuestion);

      // Update the state with the modified allCurrentQuestions
      state = state.copyWith(currentQuestions: allCurrentQuestions);
    }
  }

  void checkQuestion(QuestionModel question) {
    AnswerModel a = question.answers
        .firstWhere((element) => element.answerStage == AnswerStage.selected);
    if (a.isCorrect) {
      question = question.copyWith(answerStage: AnswerStage.correct);
    } else {
      question = question.copyWith(answerStage: AnswerStage.incorrect);
    }

    List<QuestionModel> allQuestions = state.currentQuestions;
    final index = allQuestions.indexOf(question);
    allQuestions
      ..removeAt(index)
      ..insert(index, question);

    state = state.copyWith(currentQuestions: allQuestions);
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(
    QuizState(
      currentQuestions: [],
    ),
  ),
);
