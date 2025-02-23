import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/settings/add_question/add_explanation_box.dart';
import 'package:economics_app/sections/settings/add_question/add_question_button.dart';
import 'package:economics_app/sections/settings/add_question/custom_tags_buttons.dart';
import 'package:economics_app/sections/settings/add_question/hl_button.dart';
import 'package:economics_app/sections/settings/add_question/question_topic_buttons.dart';
import 'package:economics_app/sections/settings/add_question/questions_and_answers.dart';
import 'package:economics_app/sections/settings/add_question/subunit_buttons.dart';
import 'package:economics_app/sections/settings/add_question/unit_buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/enums/course_enum.dart';

import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_sections/questions/edit_question_button.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'course_buttons.dart';
import 'number_of_answers_buttons.dart';

class AddQuestionPage extends ConsumerStatefulWidget {
  const AddQuestionPage({this.editQuestion
   = false, super.key});

  final bool editQuestion;

  @override
  ConsumerState<AddQuestionPage> createState() => _AddQuestionPage2State();
}

class _AddQuestionPage2State extends ConsumerState<AddQuestionPage> {
  late final Future<List<QuestionModel>> _questionsFuture;

  bool _initNumberOfAnswers = false;
  bool _questionsHaveBeenSet = false;

  @override
  void initState() {
    _questionsFuture = getQuestionsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    if (!_initNumberOfAnswers) {
      _initNumberOfAnswers = true;
      List<AnswerModel> answers = [];
      for (int i = 0; i < editState.numberOfAnswers; i++) {
        answers.add(AnswerModel(
          "",
          isCorrect: i == 0,
        ));
      }
      WidgetsBinding.instance.addPostFrameCallback((t) {
        List<AnswerModel> answers = [];
        if (editState.topicTag == TopicTag.multipleChoiceQuestions) {
          answers = adjustAnswersLength(editState, 2);
        } else {
          answers = [
            editState.currentQuestion.answers?.first ?? AnswerModel("")
          ];
        }

        editNotifier.updateCurrentQuestion(
          editState.currentQuestion.copyWith(
            questionType:
                editState.currentQuestion.questionType ?? QuestionType.multi,
            topicTag: editState.currentQuestion.topicTag ??
                TopicTag.multipleChoiceQuestions,
            course: editState.currentQuestion.course ?? editState.courses.first,
            unit: editState.currentQuestion.unit ??
                editState.courses.first.units.first,
            subunit: editState.currentQuestion.subunit ??
                editState.courses.first.units.first.subunits.first,
            answers: answers,
          ),
        );
      });
    }

    final isMulti =
        editState.currentQuestion.questionType == QuestionType.multi;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!_questionsHaveBeenSet) {
                _questionsHaveBeenSet = true;

                WidgetsBinding.instance.addPostFrameCallback((t) {
                  editNotifier
                      .setAllQuestions(snapshot.data as List<QuestionModel>);
                });
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * kPageIndentHorizontal,
                    vertical: size.height * kPageIndentVertical,
                  ),
                  child: Column(
                    children: [
                      QuestionTopicButtons(),
                      CustomDivider(),
                      CourseButtons(),
                      CustomDivider(),
                      UnitButtons(),
                      CustomDivider(),
                      SubunitButtons(),
                      CustomDivider(),
                      if (editState.currentQuestion.course?.course ==
                          CourseEnum.ib) ...[
                        HLButton(),
                        CustomDivider(),
                      ],
                      if (isMulti) ...[
                        NumberOfAnswersButtons(),
                        CustomDivider(),
                      ],
                      QuestionsAndAnswers(),
                      if (isMulti) ...[
                        AddExplanationBox(),
                      ],
                      CustomTagsButtons(),
                      AddQuestionButton(),
                      CustomDivider(),
                      ViewQuestionsList(),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ViewQuestionsList extends ConsumerWidget {
  const ViewQuestionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final editState = ref.watch(editQuestionProvider);
    final q = editState.currentQuestion;

    List<QuestionModel> filteredQuestions = editState.allQuestions.toList();

   filteredQuestions.retainWhere((e) =>
   e.course == q.course
   );

   filteredQuestions.sort((a,b) => a.question!.compareTo(b.question!));

    return Column(
   children: [
     ...List.generate(
         filteredQuestions.length,
             (index) => Column(
           children: [
             ListTile(
               title: Row(
                 children: [
                   Expanded(
                     child: HtmlWidget(filteredQuestions[index].question??"")
                   ),
                   Expanded(
                       child: HtmlWidget(filteredQuestions[index].answers?.first.answer ?? "")
                   ),
                 ],
               ),
               trailing: EditQuestionButton(
                 question: filteredQuestions[index],
               ),
               subtitle: Row(
                 children: [
                   Text(filteredQuestions[index].unit?.name??"",
                   style: Theme.of(context).textTheme.labelSmall,
                   ),
                   Text(filteredQuestions[index].subunit?.name??"",
                     style: Theme.of(context).textTheme.labelSmall,
                   )
                 ],
               ),
             ),
             CustomDivider(),
           ],
         ))
   ],
    );
  }
}
