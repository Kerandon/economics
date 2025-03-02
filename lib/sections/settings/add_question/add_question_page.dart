import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/settings/add_question/add_explanation_box.dart';
import 'package:economics_app/sections/settings/add_question/add_question_button.dart';
import 'package:economics_app/sections/settings/add_question/answers_button.dart';
import 'package:economics_app/sections/settings/add_question/number_of_answers_button.dart';
import 'package:economics_app/sections/settings/add_question/question_button.dart';
import 'package:economics_app/sections/settings/course_button.dart';
import 'package:economics_app/sections/settings/hl_button.dart';
import 'package:economics_app/sections/settings/topic_tag_button.dart';
import 'package:economics_app/sections/settings/unit_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

import '../custom_tags_button.dart';
import '../subunit_button.dart';

class AddQuestionPage extends ConsumerStatefulWidget {
  const AddQuestionPage({this.editQuestion = false, super.key});

  final bool editQuestion;

  @override
  ConsumerState<AddQuestionPage> createState() => AddQuestionPageState();
}

class AddQuestionPageState extends ConsumerState<AddQuestionPage> {
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


    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    if (!_initNumberOfAnswers) {
      _initNumberOfAnswers = true;
      List<AnswerModel> answers = [];
      for (int i = 0; i < 4; i++) {
        answers.add(AnswerModel(
          "",
          isCorrect: i == 0,
        ));
      }
      WidgetsBinding.instance.addPostFrameCallback((t) {
        List<AnswerModel> answers = [];
        if (c.questionType == QuestionType.multi || c.questionType == null) {
        } else {
          answers = [c.answers?.first ?? AnswerModel("")];
        }

        editNotifier.updateCurrentQuestion(
          c.copyWith(
            questionType: c.questionType ?? QuestionType.multi,
            topicTag: c.topicTag ?? TopicTag.multipleChoiceQuestion,
            course: c.course ?? editState.courses.first,
            unit: c.unit ?? editState.courses.first.units.first,
            subunit:
                c.subunit ?? editState.courses.first.units.first.subunits.first,
            answers: answers,
          ),
        );
      });
    }

    final isMulti = c.questionType == QuestionType.multi;


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
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    collapsedHeight: kToolbarHeight * 2,
                    expandedHeight: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 10, child: CourseButton()),
                            Expanded(flex: 10, child: UnitButton()),
                            Expanded(flex: 10, child: SubunitButton()),
                            Expanded(flex: 10, child: TopicTagButton()),
                            Expanded(flex: 10, child: CustomTagsButton()),
                            if (editState.currentQuestion.hl == true) ...[
                              Expanded(
                                flex: 5,
                                child: HLButton(),
                              ),
                            ],
                          ]),
                    ),
                    automaticallyImplyLeading: false,
                    pinned:
                        true, // Keeps the app bar fixed at the top// Height of the expanded app bar
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [

                          QuestionButton(),
                        if (isMulti) ...[
                          NumberOfAnswersButton(),
                        ],

                          AnswersButton(),
                          CustomDivider(),
                        if (isMulti) ...[
                          AddExplanationBox(),
                        ],
                        AddQuestionButton(),
                        CustomDivider(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
