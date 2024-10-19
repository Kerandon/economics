import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../quiz_enums/answer_stage.dart';

import '../quiz_sections/questions/quiz_models/answer_model.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

class QuizState {
  final QuestionType questionType;
  final CourseMixin course;
  final UnitMixin unit;
  final UnitMixin subunit;
  final List<QuestionModel> allQuestions;
  final List<QuestionModel> selectedQuestions;
  final bool questionsAllSelected;
  final int numberOfQuestionsCorrect;
  final int numberOfQuestionsSelected;
  final int currentQuestionIndex;
  final bool showAnswersAsIGo;

  QuizState({
    required this.course,
    required this.questionType,
    required this.unit,
    required this.subunit,
    required this.allQuestions,
    required this.selectedQuestions,
    required this.questionsAllSelected,
    required this.numberOfQuestionsCorrect,
    required this.numberOfQuestionsSelected,
    required this.currentQuestionIndex,
    required this.showAnswersAsIGo,
  });

  QuizState copyWith({
    QuestionType? questionType,
    CourseMixin? course,
    UnitMixin? unit,
    UnitMixin? subunit,
    List<QuestionModel>? allQuestions,
    List<QuestionModel>? selectedQuestions,
    bool? questionsAllSelected,
    int? numberOfQuestionsCorrect,
    int? numberOfQuestionsSelected,
    int? currentQuestionIndex,
    bool? showAnswersAsIGo,
  }) {
    return QuizState(
        course: course ?? this.course,
        questionType: questionType ?? this.questionType,
        unit: unit ?? this.unit,
        subunit: subunit ?? this.subunit,
        allQuestions: allQuestions ?? this.allQuestions,
        selectedQuestions: selectedQuestions ?? this.selectedQuestions,
        questionsAllSelected: questionsAllSelected ?? this.questionsAllSelected,
        numberOfQuestionsCorrect:
            numberOfQuestionsCorrect ?? this.numberOfQuestionsCorrect,
        numberOfQuestionsSelected:
            numberOfQuestionsSelected ?? this.numberOfQuestionsSelected,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        showAnswersAsIGo: showAnswersAsIGo ?? this.showAnswersAsIGo);
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(super._state);

  void setQuestionType(QuestionType type) {
    state = state.copyWith(questionType: type);
  }

  void setCourse(CourseMixin course) {
    UnitMixin? u, s;
    if (course.units.isNotEmpty) {
      u = course.units.first;
    }
    if (course.units.first.subunits.isNotEmpty) {
      s = course.units.first.subunits.first;
    }

    state = state.copyWith(
      course: course as Course,
      unit: u,
      subunit: s,
    );
  }

  void setUnit(UnitMixin unit) {
    state = state.copyWith(unit: unit);
  }

  void setSubunit(UnitMixin unit) {
    state = state.copyWith(subunit: unit);
  }

  void setAllQuestions(List<QuestionModel> questions) {
    Set<QuestionModel> uniqueQuestions = questions.toSet();

    List<QuestionModel> uniqueQuestionsList = uniqueQuestions.toList();

    state = state.copyWith(allQuestions: uniqueQuestionsList);
  }

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

  void setShowAnswersAsIGo(bool checkAtEnd) {
    state = state.copyWith(showAnswersAsIGo: checkAtEnd);
  }

  void checkAnswer(QuestionModel question) {
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

  // void setSectionAsSelected(IBSection section) {
  //   List<IBSection> sections = state.selectedSections;
  //   if (sections.contains(section)) {
  //     sections.remove(section);
  //   } else {
  //     sections.add(section);
  //   }
  //   state = state.copyWith(selectedSections: sections);
  // }

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
      course: Course(name: '', units: []),
      questionType: QuestionType.multi,
      unit: Unit(name: "", subunits: []),
      subunit: Unit(name: ""),
      allQuestions: [],
      selectedQuestions: [],
      questionsAllSelected: false,
      numberOfQuestionsCorrect: 0,
      numberOfQuestionsSelected: 5,
      currentQuestionIndex: 0,
      showAnswersAsIGo: true,
    ),
  ),
);
