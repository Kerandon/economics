import 'package:economics_app/app/enums/course_enum.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/utils/models/course_model.dart';
import '../../../../../app/utils/models/unit_model.dart';
import '../../../../diagrams/models/diagram_model.dart';
import '../../../quiz_enums/answer_stage.dart';
import '../../../quiz_enums/custom_tag.dart';
import '../../../quiz_enums/question_key.dart';
import '../../../quiz_enums/question_type.dart';
import '../../../quiz_enums/topic_tag.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String? id;
  final QuestionType? questionType;
  final CourseModel? course;
  final String? question;
  final List<DiagramModel>? diagrams;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final UnitModel? unit;
  final UnitModel? subunit;
  final TopicTag? topicTag;
  final bool? hl;
  final List<CustomTag>? customTags;

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
    this.topicTag,
    this.hl,
    this.customTags,
  });

  // More flexible copyWith
  QuestionModel copyWith({
    String? id,
    QuestionType? questionType,
    CourseModel? course,
    String? question,
    List<DiagramModel>? diagrams,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    UnitModel? unit,
    UnitModel? subunit,
    String? explanation,
    TopicTag? topicTag,
    bool? hl,
    List<CustomTag>? customTags,
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
      topicTag: topicTag ?? this.topicTag,
      hl: hl ?? this.hl,
      customTags: customTags ?? this.customTags,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      QuestionKey.type.name: questionType?.name,
      QuestionKey.topic.name: topicTag?.toFireBase(),
      QuestionKey.course.name: course?.course?.name,
      QuestionKey.unit.name: {unit?.index ?? "": unit?.name ?? ""},
      QuestionKey.subunit.name: {subunit?.index ?? "": subunit?.name ?? ""},
      QuestionKey.question.name: question,
      QuestionKey.diagrams.name: diagrams?.map((e) => e.toMap()).toList(),
      QuestionKey.answers.name: answers?.map((e) => e.toMap()).toList(),
      QuestionKey.answerStage.name: answerStage.name, // Enum
      QuestionKey.explanation.name: explanation,
      QuestionKey.hL.name: hl,
      QuestionKey.customTags.name: customTags?.toFirebase(),
    };
  }

  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    return QuestionModel(
      id: id,
      question: map[QuestionKey.question.name],
      questionType: map.containsKey(QuestionKey.type.name)
          ? QuestionTypeExtension.fromText(map[QuestionKey.type.name])
          : null,
      topicTag: TopicTagFirebase.fromFirebase(map),
      course: CourseModel(
          course: CourseEnumExtension.fromText(map[QuestionKey.course.name]),
          units: []),
      unit: UnitModel.fromFirebase(map),
      subunit: UnitModel.fromFirebase(map, subunit: true),
      answers: AnswerModel.fromMapList(map)?.toList(),
      answerStage: AnswerStage.notSelected,
      explanation: map.containsKey(QuestionKey.explanation.name)
          ? map[QuestionKey.explanation.name]
          : null,
      diagrams: DiagramModel.fromFirebaseList(map[QuestionKey.diagrams.name]),
      hl: map.containsKey(QuestionKey.hL.name)
          ? map[QuestionKey.hL.name]
          : null,
      customTags: CustomTagFirebaseExtension.fromFirebaseList(
          map[QuestionKey.customTags.name]),
    );
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers ?? [])..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
