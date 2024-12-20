import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/utils/models/unit.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/utils/mixins/course_mixin.dart';
import '../../../../../app/utils/mixins/unit_mixin.dart';

import '../../../../../app/utils/models/course.dart';
import '../../../../diagrams/models/diagram_model.dart';
import '../../../quiz_enums/answer_stage.dart';
import '../../../quiz_enums/question_tags.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String? id;
  final QuestionType? questionType;
  final CourseMixin? course;
  final String? question;
  final List<DiagramModel>? diagrams;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final UnitMixin? unit;
  final UnitMixin? subunit;
  final FlipCardTag? flipCardTag;
  final bool? isHL;

  const QuestionModel({
    this.id,
    this.questionType,
    this.course,
    this.question,
    this.diagrams,
    this.answers,
    this.answerStage = AnswerStage.notSelected,
    this.explanation,
    this.unit,
    this.subunit,
    this.flipCardTag,
    this.isHL,
  });

  // More flexible copyWith
  QuestionModel copyWith({
    String? id,
    QuestionType? questionType,
    CourseMixin? course,
    String? question,
    List<DiagramModel>? diagrams,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    UnitMixin? unit,
    UnitMixin? subunit,
    String? explanation,
    FlipCardTag? flipCardTag,
    bool? isHL,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionType: questionType ?? this.questionType,
      course: course ?? this.course,
      question: question ?? this.question,
      diagrams: diagrams ?? this.diagrams,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      unit: unit ?? this.unit,
      subunit: subunit ?? this.subunit,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      isHL: isHL ?? this.isHL,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      kType: questionType?.name,
      kCourse: course?.name,
      kQuestion: question,
      kAnswers: answers?.map((e) => e.toMap()).toList(),
      kAnswerStage: answerStage.name, // Enum
      kExplanation: explanation,
      kDiagrams: diagrams?.map((e) => e.toMap()).toList(),
      kUnit: {unit?.index ?? "": unit?.name ?? ""},
      kSubunit: {subunit?.index ?? "": subunit?.name ?? ""},
      kFlipCardTag: flipCardTag?.name,
      kIsHL: isHL,
    };
  }

  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    List<AnswerModel> answers =
        (map[kAnswers] as List).map((e) => AnswerModel.fromMap(e)).toList();

    FlipCardTag tag = FlipCardTag.general;
    for (var m in map.entries) {
      if (m.key == kFlipCardTag) {
        for (var v in FlipCardTag.values) {
          if (m.value == v.name) {
            tag = v;
          }
        }
      }
    }

    return QuestionModel(
      id: id,
      questionType: QuestionTypeExtension.fromText(map[kType]),
      course: Course(name: map[kCourse], units: []),
      unit: Unit.fromFirebase(map),
      subunit: Unit.fromFirebase(map, subunit: true),
      question: map[kQuestion],
      answers: answers,
      answerStage: AnswerStage.notSelected,
      explanation: map[kExplanation],
      diagrams: DiagramModel.fromFirebaseList(map[kDiagrams] as List<dynamic>),
      flipCardTag: tag,
      isHL: map[kIsHL],
    );
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers ?? [])..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
