import 'package:economics_app/sections/quizzes/quiz_enums/tag.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/utils/models/syllabus_model.dart';
import '../../../../../app/utils/models/unit_model.dart';
import '../../../../diagrams/models/diagram_model.dart';
import '../../../quiz_enums/answer_stage.dart';
import '../../../quiz_enums/question_key.dart';
import '../../../quiz_enums/question_type.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String? id;
  final QuestionType? questionType;
  final SyllabusModel? syllabus;
  final String? question;
  final List<DiagramModel>? diagrams;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final List<UnitModel>? units;
  final List<UnitModel>? subunits;
  final List<Tag>? tags;

  const QuestionModel({
    this.id,
    this.questionType,
    this.syllabus,
    this.question,
    this.diagrams,
    this.answers,
    this.answerStage = AnswerStage.notSelected,
    this.explanation,
    this.units,
    this.subunits,
    this.tags,
  });

  QuestionModel copyWith({
    String? id,
    QuestionType? questionType,
    SyllabusModel? syllabus,
    String? question,
    List<DiagramModel>? diagrams,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    List<UnitModel>? units,
    List<UnitModel>? subunits,
    String? explanation,
    List<Tag>? tags,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionType: questionType ?? this.questionType,
      syllabus: syllabus ?? this.syllabus,
      question: question ?? this.question,
      diagrams: diagrams ?? this.diagrams,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      units: units ?? this.units,
      subunits: subunits ?? this.subunits,
      tags: tags ?? this.tags,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      QuestionKey.type.name: questionType?.name,
      QuestionKey.question.name: question,
      QuestionKey.syllabus.name: syllabus?.syllabus?.name,
      QuestionKey.units.name: units?.map((e) => {e.index : e.name}).toList(),
      QuestionKey.subunits.name: subunits?.map((e) => {e.index : e.name}).toList(),
      QuestionKey.answers.name: answers?.map((e) => e.toMap()).toList(),
      QuestionKey.explanation.name: explanation,
      QuestionKey.diagrams.name: diagrams?.map((e) => e.toMap()).toList(),
      QuestionKey.tags.name: tags?.map((e) => e.name).toList(),
    };
  }

  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    print('map l is ${map.length} ${map.keys} and ${map.values}');
    return QuestionModel(
      id: id,
      question: getQuestion(map),
      questionType: QuestionTypeExtension.getQuestionType(map),
      syllabus: SyllabusModel.fromFirebase(map),
      units: UnitModelExtension.fromFirebase(map),
      subunits: UnitModelExtension.fromFirebase(map, subunit: true),
      answers: AnswerModel.fromFirebase(map),
      answerStage: AnswerStage.notSelected,
      explanation: getExplanation(map),
      diagrams: DiagramModel.fromFirebaseList(map[QuestionKey.diagrams.name]),
     tags: TagFirebaseExtension.fromFirebase(map),
    );
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers ?? [])..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  // Static method to safely extract the question from a map
  static String? getQuestionFromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }

    final questionValue = map[QuestionKey.question.name];
    if (questionValue is String) {
      return questionValue;
    }

    return null;
  }

  static String? getQuestion(Map<String, dynamic>? map) {
    final key = QuestionKey.question.name;

    // Check if the map is null
    if (map == null) {
      return null;
    }

    // Extract the question field
    final questionValue = map[key];

    // Return the question if it's a valid String, otherwise return null
    return questionValue is String ? questionValue : null;
  }

  static String? getExplanation(Map<String, dynamic>? map) {
    final key = QuestionKey.explanation.name;

    // Check if the map is null
    if (map == null) {
      return null;
    }

    // Extract the explanation field
    final explanationValue = map[key];

    // Return the explanation if it's a valid String, otherwise return null
    return explanationValue is String ? explanationValue : null;
  }

  @override
  List<Object?> get props => [question];
}
