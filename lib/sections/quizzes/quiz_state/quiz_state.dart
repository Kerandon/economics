import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/enums/sections.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_models/answer_model.dart';
import '../quiz_models/question_model.dart';

class QuizState {
  final List<QuestionModel> allQuestions;
  final List<QuestionModel> selectedQuestions;
  final bool questionsAllSelected;
  final bool questionsAllAnswered;
  final int numberOfQuestionsCorrect;
  final Map<Section, bool> selectedSections;
  final int numberOfQuestionsSelected;
  final int currentQuestionIndex;
  final bool showAnswersAsIGo;

  QuizState({
    required this.allQuestions,
    required this.selectedQuestions,
    required this.questionsAllSelected,
    required this.questionsAllAnswered,
    required this.numberOfQuestionsCorrect,
    required this.selectedSections,
    required this.numberOfQuestionsSelected,
    required this.currentQuestionIndex,
    required this.showAnswersAsIGo,
  });

  QuizState copyWith({
    List<QuestionModel>? allQuestions,
    List<QuestionModel>? selectedQuestions,
    bool? questionsAllSelected,
    bool? questionsAllAnswered,
    int? numberOfQuestionsCorrect,
    Map<Section, bool>? selectedSections,
    int? numberOfQuestionsSelected,
    int? currentQuestionIndex,
    bool? showAnswersAsIGo,
  }) {
    return QuizState(
      allQuestions: allQuestions ?? this.allQuestions,
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
      questionsAllAnswered: questionsAllAnswered ?? this.questionsAllAnswered,
      numberOfQuestionsCorrect:
          numberOfQuestionsCorrect ?? this.numberOfQuestionsCorrect,
      selectedSections: selectedSections ?? this.selectedSections,
      numberOfQuestionsSelected:
          numberOfQuestionsSelected ?? this.numberOfQuestionsSelected,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      showAnswersAsIGo: showAnswersAsIGo ?? this.showAnswersAsIGo,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(super._state);

  void setAllQuestions(List<QuestionModel> questions) {
    state = state.copyWith(allQuestions: questions);
  }

  void setSelectedQuestions(List<QuestionModel> questions) {
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

  void updateQuestionState(QuestionModel question) {
    List<QuestionModel> questions = state.selectedQuestions.toList();

    for (int i = 0; i < questions.length; i++) {
      if (questions[i] == question) {
        questions[i] = question;
      }
    }

    state = state.copyWith(selectedQuestions: questions);
  }

  void setShowAnswersAsIGo(bool checkAtEnd) {
    state = state.copyWith(showAnswersAsIGo: checkAtEnd);
  }

  void checkAnswer(QuestionModel question) {
    List<AnswerModel> answers = question.answers.toList();
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
    if (question.answers
        .any((answer) => answer.answerStage == AnswerStage.incorrect)) {
      question = question.copyWith(answerStage: AnswerStage.incorrect);
    } else {
      question = question.copyWith(answerStage: AnswerStage.correct);
    }

    updateQuestionState(question);
    //quizNotifier.updateQuestionState(question);
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

  void setResetQuestions() {
    state = state.copyWith(
      selectedQuestions: [],
      questionsAllSelected: false,
      questionsAllAnswered: false,
      numberOfQuestionsCorrect: 0,
      currentQuestionIndex: 0,
    );
  }

  void setSectionAsSelected(Section section, bool isSelected) {
    Map<Section, bool> sections = state.selectedSections;
    sections.update(section, (value) => isSelected);
    state = state.copyWith(selectedSections: sections);
  }

  void setNumberOfQuestionsSelected(int number) {
    state = state.copyWith(numberOfQuestionsSelected: number);
  }

  void setCurrentQuestionIndex(int index) {
    state = state.copyWith(currentQuestionIndex: index);
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(
    QuizState(
      allQuestions: [],
      selectedQuestions: [],
      questionsAllSelected: false,
      questionsAllAnswered: false,
      numberOfQuestionsCorrect: 0,
      selectedSections: {
        Section.intro: true,
        Section.micro: false,
        Section.macro: false,
        Section.global: false,
      },
      numberOfQuestionsSelected: 5,
      currentQuestionIndex: 0,
      showAnswersAsIGo: true,
    ),
  ),
);
