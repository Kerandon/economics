import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/models/syllabus_model.dart';

class EditQuestionState {
  final List<SyllabusModel> syllabuses;
  final List<QuestionModel> allQuestions;
  final List<QuestionModel> temporaryQuestions;
  final List<DiagramModel> selectedDiagrams;
  final QuestionModel currentQuestion;
  final bool editExistingQuestion;

  EditQuestionState({
    required this.syllabuses,
    required this.allQuestions,
    required this.temporaryQuestions,
    required this.selectedDiagrams,
    required this.currentQuestion,
    required this.editExistingQuestion,
  });

  EditQuestionState copyWith({
    List<SyllabusModel>? syllabuses,
    List<QuestionModel>? allQuestions,
    List<QuestionModel>? temporaryQuestions,
    List<DiagramModel>? selectedDiagrams,
    QuestionModel? currentQuestion,
    bool? editExistingQuestion,
  }) {
    return EditQuestionState(
      syllabuses: syllabuses ?? this.syllabuses,
      allQuestions: allQuestions ?? this.allQuestions,
      temporaryQuestions: temporaryQuestions ?? this.temporaryQuestions,
      selectedDiagrams: selectedDiagrams ?? this.selectedDiagrams,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      editExistingQuestion: editExistingQuestion ?? this.editExistingQuestion,
    );
  }
}

class EditQuestionNotifier extends StateNotifier<EditQuestionState> {
  EditQuestionNotifier(super._state);

  void setAllQuestions(List<QuestionModel> allQuestions) {
    state = state.copyWith(allQuestions: allQuestions.toList());
  }

  void setTemporaryQuestions(List<QuestionModel> questions) {
    state = state.copyWith(temporaryQuestions: questions.toList());
  }

  void setDiagramsSelected(DiagramModel diagram, int index) {
    final currentList = state.selectedDiagrams.toList();
    if (index < currentList.length) {
      currentList[index] = diagram;
    }

    state = state.copyWith(selectedDiagrams: currentList);
  }

  void updateCurrentQuestion(QuestionModel question) {



    final answers = setAnswers(question);
    state = state.copyWith(
      currentQuestion: question.copyWith(
        answers: answers.toList(),
      ),
    );
  }

  List<AnswerModel> setAnswers(QuestionModel question) {
    List<AnswerModel> answers = question.answers?.toList() ?? [];
    if(question.questionTypes?.isNotEmpty == true) {
      if (question.questionTypes?[0] == QuestionType.flip) {
        answers = [
          if (question.answers?.isNotEmpty ?? false) ...[
            question.answers!.first.copyWith(isCorrect: true)
          ],
          if(question.answers?.isEmpty == true)...[
            AnswerModel('', isCorrect: true)
          ]
        ];
      } else if (question.questionTypes?[0] == QuestionType.multi) {
        if (answers.length < 4) {
          // Add default answers until the list matches the required number
          while (answers.length < 4) {
            answers.add(AnswerModel(''));
          }
        }
      }
    }
    return answers;
  }

  void setEditExistingQuestion(bool edit) {
    state = state.copyWith(editExistingQuestion: edit);
  }
}

final editQuestionProvider =
    StateNotifierProvider<EditQuestionNotifier, EditQuestionState>(
  (ref) => EditQuestionNotifier(
    EditQuestionState(
      syllabuses: allSyllabuses.toList(),
      allQuestions: [],
      temporaryQuestions: [],
      selectedDiagrams: [],
      currentQuestion: QuestionModel(),
      editExistingQuestion: false,
    ),
  ),
);
