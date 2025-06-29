import 'dart:io';

import 'package:economics_app/sections/quizzes/quiz_enums/tag.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/utils/models/syllabus_model.dart';
import '../../../../../app/utils/models/unit_model.dart';
import '../../../../diagrams/models/diagram_model.dart';
import '../../../quiz_enums/answer_stage.dart';
import '../../../quiz_enums/question_key.dart';
import '../../../quiz_enums/question_type.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String? id;
  final List<QuestionType>? questionTypes;
  final List<SyllabusModel>? syllabuses;
  final String? question;
  final List<DiagramModel>? diagrams;
  final List<String>? images;
  final List<XFile?>? xFileImages;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final List<UnitModel>? units;
  final List<UnitModel>? subunits;
  final List<Tag>? tags;
  final List<QuestionModel>? filteredQuestions;
  final int? numberOfQuestions;
  final bool? showAnswersAtEnd;

  const QuestionModel({
    this.id,
    this.questionTypes,
    this.syllabuses,
    this.question,
    this.diagrams,
    this.images,
    this.xFileImages,
    this.answers,
    this.answerStage = AnswerStage.notSelected,
    this.explanation,
    this.units,
    this.subunits,
    this.tags,
    this.filteredQuestions,
    this.numberOfQuestions,
    this.showAnswersAtEnd,
  });

  QuestionModel copyWith({
    String? id,
    List<QuestionType>? questionTypes,
    List<SyllabusModel>? syllabuses,
    String? question,
    List<DiagramModel>? diagrams,
    List<String>? images,
    List<XFile?>? xFileImages,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    List<UnitModel>? units,
    List<UnitModel>? subunits,
    String? explanation,
    List<Tag>? tags,
    List<QuestionModel>? filteredQuestions,
    int? numberOfQuestions,
    bool? showAnswersAtEnd,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionTypes: questionTypes ?? this.questionTypes,
      syllabuses: syllabuses ?? this.syllabuses,
      question: question ?? this.question,
      diagrams: diagrams ?? this.diagrams,
      images: images ?? this.images,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      units: units ?? this.units,
      subunits: subunits ?? this.subunits,
      tags: tags ?? this.tags,
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      showAnswersAtEnd: showAnswersAtEnd ?? this.showAnswersAtEnd,
    );
  }

  Map<String, dynamic> toMap() {
    String safeIndex(dynamic index) {
      if (index == null) return '0';
      final s = index.toString().trim();
      return s.isEmpty ? '0' : s;
    }

    return {
      QuestionKey.type.name: questionTypes?.isNotEmpty == true
          ? questionTypes![0].name
          : null,
      QuestionKey.question.name: question,
      QuestionKey.syllabus.name: syllabuses?.isNotEmpty == true
          ? syllabuses![0].syllabus?.name
          : null,
      if (units?.isNotEmpty == true)
        QuestionKey.units.name: {
          for (var e in units!) safeIndex(e.index): e.name
        },
      if (subunits?.isNotEmpty == true)
        QuestionKey.subunits.name: {
          for (var e in subunits!) safeIndex(e.index): e.name
        },
      if (answers?.isNotEmpty == true)
        QuestionKey.answers.name: answers!.map((e) => e.toMap()).toList(),
      if (explanation?.isNotEmpty == true)
        QuestionKey.explanation.name: explanation,
      if (diagrams?.isNotEmpty == true)
        QuestionKey.diagrams.name: diagrams!.map((e) => e.toMap()).toList(),
      if (tags?.isNotEmpty == true)
        QuestionKey.tags.name: tags!.map((e) => e.name).toList(),
    };
  }


  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    return QuestionModel(
      id: id,
      question: getQuestion(map),
      questionTypes: [
        QuestionTypeExtension.getQuestionType(map) ?? QuestionType.multi
      ],
      syllabuses: SyllabusModel.fromFirebase(map),
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

void sendXFileToFirebaseStorage(XFile? xFile) {
  if (xFile != null) {
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef =
        storageRef.child('uploads/${xFile.name}'); // optional: add folder path
        fileRef.putFile(File(xFile.path));
  }
}
