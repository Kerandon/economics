import 'package:economics_app/sections/diagrams/enums/diagrams_number.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/models/course_model.dart';
import '../quiz_enums/question_part_enum.dart';
import '../quiz_sections/questions/quiz_models/filter_model.dart';

class EditQuestionState {
  final List<CourseModel> courses;
  final List<QuestionModel> allQuestions;
  final DiagramsNumber diagramsNumber;
  final List<DiagramModel> selectedDiagrams;
  final QuestionModel currentQuestion;
  final QuestionPart questionPart;
  final FilterModel filterModel;


  EditQuestionState({
    required this.courses,
    required this.allQuestions,
    required this.diagramsNumber,
    required this.selectedDiagrams,
    required this.currentQuestion,
    required this.questionPart,
    required this.filterModel,
  });

  EditQuestionState copyWith({
    List<CourseModel>? courses,
    List<QuestionModel>? allQuestions,
    DiagramsNumber? diagramsNumber,
    List<DiagramModel>? selectedDiagrams,
    QuestionModel? currentQuestion,
    QuestionPart? questionPart,
    FilterModel? filterModel,
  }) {
    return EditQuestionState(
      courses: courses ?? this.courses,
      allQuestions: allQuestions ?? this.allQuestions,
      diagramsNumber: diagramsNumber ?? this.diagramsNumber,
      selectedDiagrams: selectedDiagrams ?? this.selectedDiagrams,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questionPart: questionPart ?? this.questionPart,
      filterModel: filterModel ?? this.filterModel,
    );
  }
}

class EditQuestionNotifier extends StateNotifier<EditQuestionState> {
  EditQuestionNotifier(super._state);

  void setAllQuestions(List<QuestionModel> allQuestions) {
    state = state.copyWith(allQuestions: allQuestions);
  }

  void setCourses(List<CourseModel> courses) {
    state = state.copyWith(courses: courses);
  }


  void setDiagramsNumber(BuildContext context, Size size,
      {required DiagramsNumber diagramsNumber}) {
    state = state.copyWith(diagramsNumber: diagramsNumber);
    final diagramsNum = diagramsNumber.toInt;
    final currentLengthList = state.selectedDiagrams.length;

    if (diagramsNum > currentLengthList) {
      final difference = diagramsNum - currentLengthList;

      final allDiagrams = DiagramModel.getAllDiagrams(size, context);

      final newEntries = List.generate(
        difference,
        (index) => allDiagrams.first,
      );
      state.selectedDiagrams.addAll(newEntries);
    }
    if (diagramsNum < currentLengthList) {
      state.selectedDiagrams.removeRange(diagramsNum, currentLengthList);
    }
  }

  void setDiagramsSelected(DiagramModel diagram, int index) {
    final currentList = state.selectedDiagrams.toList();
    if (index < currentList.length) {
      currentList[index] = diagram;
    }

    state = state.copyWith(selectedDiagrams: currentList);
  }

  void updateCurrentQuestion(QuestionModel question) {
    state = state.copyWith(currentQuestion: question);
    adjustNumberOfAnswers(question);
  }

  void updateFilter(FilterModel filter) {
    state = state.copyWith(filterModel: filter);
  }

  void setNumberOfAnswers(int number) {
    List<AnswerModel> answers =
        adjustNumberOfAnswers(state.currentQuestion, number: (number + 2));

    state = state.copyWith(
      currentQuestion: state.currentQuestion.copyWith(
        answers: answers,
      ),
    );
  }

  List<AnswerModel> adjustNumberOfAnswers(QuestionModel question,
      {int? number}) {
    List<AnswerModel> answers = question.answers?.toList() ?? [];

    if (question.questionType == QuestionType.flip) {
      // Flip question type should always have exactly 1 answer
      state = state.copyWith(
        currentQuestion: question.copyWith(
          answers: [
            AnswerModel(''),
          ],
        ),
      );
    } else if (question.questionType == QuestionType.multi) {
      if (question.answers!.length < 2) {
        int targetNumber = 0;
        answers.isEmpty ? targetNumber = 3 : targetNumber = 2;
        for (int i = 0; i < targetNumber; i++) {
          answers.add(AnswerModel(''));
        }
        answers.insert(
          0,
          AnswerModel('', isCorrect: true),
        );
        state = state.copyWith(
            currentQuestion: question.copyWith(answers: answers.toList()));
      } else {
        int n = number ?? question.answers?.length ?? 4;
        while (answers.length > n) {
          answers.removeLast();
        }
        while (answers.length < n) {
          answers.add(
            AnswerModel(''),
          );
        }
      }
    }

    return answers;
  }

  void setQuestionPartSelected(QuestionPart part) {
    state = state.copyWith(questionPart: part);
  }
}

final editQuestionProvider =
    StateNotifierProvider<EditQuestionNotifier, EditQuestionState>(
  (ref) => EditQuestionNotifier(
    EditQuestionState(
      courses: [],
      allQuestions: [],
      diagramsNumber: DiagramsNumber.zero,
      selectedDiagrams: [],
      currentQuestion: QuestionModel(),
      questionPart: QuestionPart.question,
      filterModel: FilterModel(),
    ),
  ),
);
