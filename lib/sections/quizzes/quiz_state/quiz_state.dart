import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/audio_manager/audio_manager.dart';
import '../../../main.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_sections/questions/quiz_models/answer_model.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

class QuizState {
  final List<QuestionModel> selectedQuestions;
  final bool questionsAllSelected;
  final int numberOfQuestionsCorrect;
  final int numberOfQuestionsSelected;
  final int currentQuestionIndex;
  final bool quizIsCompleted;
  final bool flipForward;
  final bool flipReverse;
  final CardSide currentCardSide;
  final bool cardHasFlipped;

  QuizState({
    required this.selectedQuestions,
    required this.questionsAllSelected,
    required this.numberOfQuestionsCorrect,
    required this.numberOfQuestionsSelected,
    required this.currentQuestionIndex,
    required this.quizIsCompleted,
    required this.flipForward,
    required this.flipReverse,
    required this.currentCardSide,
    required this.cardHasFlipped,
  });

  QuizState copyWith({
    List<QuestionModel>? selectedQuestions,
    bool? questionsAllSelected,
    int? numberOfQuestionsCorrect,
    int? numberOfQuestionsSelected,
    int? currentQuestionIndex,
    bool? quizIsCompleted,
    bool? flipForward,
    bool? flipReverse,
    CardSide? currentCardSide,
    bool? cardHasFlipped,
  }) {
    return QuizState(
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
      numberOfQuestionsCorrect:
          numberOfQuestionsCorrect ?? this.numberOfQuestionsCorrect,
      numberOfQuestionsSelected:
          numberOfQuestionsSelected ?? this.numberOfQuestionsSelected,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      quizIsCompleted: quizIsCompleted ?? this.quizIsCompleted,
      flipForward: flipForward ?? this.flipForward,
      flipReverse: flipReverse ?? this.flipReverse,
      currentCardSide: currentCardSide ?? this.currentCardSide,
      cardHasFlipped: cardHasFlipped ?? this.cardHasFlipped,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(super._state);

  void setSelectedQuestions(List<QuestionModel> questions) {
    state = state.copyWith(selectedQuestions: questions);
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
      // showQuickPopup(context, const GifBox(filesUrl: 'assets/gifs/correct/'));
      getIt<AudioManager>().playSoundRandomly('correct');
    }
    if (question.answerStage == AnswerStage.incorrect) {
      getIt<AudioManager>().playSoundRandomly('incorrect');
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

  void updateQuestion(QuestionModel question) {
    List<QuestionModel> questions = state.selectedQuestions.toList();
    // Assuming 'questions' is a class-level variable or passed in another way.
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].id == question.id) {
        questions[i] =
            question; // Replace the existing question with the new one.
        break; // Exit the loop after replacing to avoid unnecessary iterations.
      }
    }
    state = state.copyWith(selectedQuestions: questions.toList());
  }

  void setNumberOfQuestionsSelected(int number) {
    state = state.copyWith(numberOfQuestionsSelected: number);
  }

  void setCurrentQuestionIndex(int index) {
    state = state.copyWith(currentQuestionIndex: index);
  }

  void setQuizIsCompleted(bool completed) {
    state = state.copyWith(quizIsCompleted: completed);
  }

  void flipCardForward(bool flip) {
    state = state.copyWith(flipForward: flip, flipReverse: !flip);
  }

  void flipCardReverse(bool flip) {
    state = state.copyWith(flipReverse: flip, flipForward: !flip);
  }

  void setCardSide(CardSide side) {
    state = state.copyWith(currentCardSide: side);
  }

  void setCardHasFlipped(bool flipped) {
    state = state.copyWith(cardHasFlipped: flipped);
  }

  void setResetQuestions() {
    state = state.copyWith(
      selectedQuestions: [],
      questionsAllSelected: false,
      numberOfQuestionsCorrect: 0,
      currentQuestionIndex: 0,
      quizIsCompleted: false,
      currentCardSide: CardSide.front,
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
      quizIsCompleted: false,
      flipForward: false,
      flipReverse: false,
      currentCardSide: CardSide.front,
      cardHasFlipped: false,
    ),
  ),
);
