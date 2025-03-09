import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/sections/diagrams/enums/diagrams_number.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/models/syllabus_model.dart';
import '../quiz_enums/question_part_enum.dart';

class EditQuestionState {
  final List<SyllabusModel> syllabuses;
  final List<QuestionModel> allQuestions;
  final DiagramsNumber diagramsNumber;
  final List<DiagramModel> selectedDiagrams;
  final QuestionModel currentQuestion;
  final QuestionPart questionPart;
  // final FilterModel filterModel;
  final int numberOfMultiAnswers;

  EditQuestionState({
    required this.syllabuses,
    required this.allQuestions,
    required this.diagramsNumber,
    required this.selectedDiagrams,
    required this.currentQuestion,
    required this.questionPart,
    // required this.filterModel,
    required this.numberOfMultiAnswers,
  });

  EditQuestionState copyWith({
    List<SyllabusModel>? syllabuses,
    List<QuestionModel>? allQuestions,
    DiagramsNumber? diagramsNumber,
    List<DiagramModel>? selectedDiagrams,
    QuestionModel? currentQuestion,
    QuestionPart? questionPart,
    // FilterModel? filterModel,
    int? numberOfMultiAnswers,
  }) {
    return EditQuestionState(
      syllabuses: syllabuses ?? this.syllabuses,
      allQuestions: allQuestions ?? this.allQuestions,
      diagramsNumber: diagramsNumber ?? this.diagramsNumber,
      selectedDiagrams: selectedDiagrams ?? this.selectedDiagrams,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questionPart: questionPart ?? this.questionPart,
      // filterModel: filterModel ?? this.filterModel,
      numberOfMultiAnswers: numberOfMultiAnswers ?? this.numberOfMultiAnswers,
    );
  }
}

class EditQuestionNotifier extends StateNotifier<EditQuestionState> {
  EditQuestionNotifier(super._state);

  void setAllQuestions(List<QuestionModel> allQuestions) {
    state = state.copyWith(allQuestions: allQuestions.toList());

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
    final answers = adjustNumberOfAnswers(question, state.numberOfMultiAnswers);
    state =
        state.copyWith(currentQuestion: question.copyWith(answers: answers.toList()));
  }

  // void updateFilter(FilterModel filter) {
  //   state = state.copyWith(filterModel: filter);
  // }

  void setNumberOfMultiAnswers(QuestionModel question, int num) {

    final a = adjustNumberOfAnswers(question, num);

    state = state.copyWith(
        numberOfMultiAnswers: num,
        currentQuestion: state.currentQuestion.copyWith(answers: a.toList())
        );
  }

  List<AnswerModel> adjustNumberOfAnswers(QuestionModel question, int num) {
    final c = question;
    List<AnswerModel> answers = c.answers?.toList() ?? [];
    if (c.questionType == QuestionType.flip) {

    answers = [AnswerModel('')];
    } else if (c.questionType == QuestionType.multi) {
      if (answers.length > num) {
        // Trim the list to match the required number
        answers = answers.sublist(0, num);
      } else if (answers.length < num) {
        // Add default answers until the list matches the required number
        while (answers.length < num) {
          answers.add(AnswerModel(''));
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
      syllabuses: allSyllabuses.toList(),
      allQuestions: [],
      diagramsNumber: DiagramsNumber.zero,
      selectedDiagrams: [],
      currentQuestion: QuestionModel(),
      questionPart: QuestionPart.question,
      // filterModel: FilterModel(),
      numberOfMultiAnswers: 4,
    ),
  ),
);
