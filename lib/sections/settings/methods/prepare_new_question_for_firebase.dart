// import 'package:economics_app/app/enums/firebase_status.dart';
// import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
// import 'package:economics_app/sections/settings/manage_questions/methods/send_new_question_to_firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import '../../../../app/configs/constants.dart';
// import '../../../../app/custom_widgets/building_helper.dart';
// import '../../../quizzes/quiz_enums/question_key.dart';
// import '../../../quizzes/quiz_enums/topic_tag.dart';
// import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
// import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
// import '../../../quizzes/quiz_state/edit_question_state.dart';
// import '../add_question/add_question_page.dart';
//
//
// Future<void> prepareNewQuestionForFirebase({
//   required BuildContext context,
//   required GlobalKey<FormBuilderState> formKey,
//   required EditQuestionState editState,
// }) async {
//   final fields = formKey.currentState!.fields;
//   final question = fields[QuestionKey.question.name]?.value;
//   final TopicTag flipCardTag = editState.topicTag;
//   List<AnswerModel> answers = [];
//   String? explanation;
//
//   bool? isHL;
//   final course = editState.course;
//   final unit = editState.unit;
//   final subunit = editState.subunit;
//   answers.add(
//     AnswerModel(fields[QuestionKey.correct.name]?.value, isCorrect: true),
//   );
//   if (true) {
//     answers.add(
//       AnswerModel(fields[QuestionKey.incorrect.name]?.value),
//     );
//     answers.add(
//       AnswerModel(fields[QuestionKey.incorrect.name]?.value),
//     );
//     answers.add(
//       AnswerModel(fields[QuestionKey.incorrect.name]?.value),
//     );
//     explanation = fields[QuestionKey.explanation.name]?.value;
//   }
//   List<DiagramModel>? diagrams;
//   if (editState.selectedDiagrams.isNotEmpty) {
//     diagrams = editState.selectedDiagrams.toList();
//   }
//
//   final q = QuestionModel(
//     course: course,
//     unit: unit,
//     subunit: subunit,
//     question: question,
//     diagrams: diagrams,
//     answers: answers,
//     explanation: explanation,
//     topicTag: flipCardTag,
//     hl: isHL,
//     customTags: editState.customTags,
//   );
//
//   final future = sendNewQuestionToFirebase(question: q);
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => BuilderHelper(
//         future: future,
//         onComplete: (value) {
//           // Check if the widget is still mounted before navigating
//           if (context.mounted) {
//             // Wrap the navigation code inside the post-frame callback
//             String text = 'Question added successfully';
//             if (value == FirebaseStatus.error) {
//               text = kErrorMessage;
//             }
//             // Ensure we are using a valid context for navigation
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => const AddQuestionPage(),
//               ),
//             );
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(text)),
//             );
//             // Show the snack bar
//           }
//         },
//       ),
//     ),
//   );
// }
