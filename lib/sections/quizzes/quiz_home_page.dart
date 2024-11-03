import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/check_answers_at_end_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/number_of_questions_buttons.dart';
import 'package:economics_app/sections/quizzes/methods/get_questions_data.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';

import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/custom_widgets/gap.dart';
import 'custom_widgets/course_type_buttons.dart';
import 'custom_widgets/quiz_type_buttons.dart';
import 'custom_widgets/unit_dropdown_buttons.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends ConsumerState<QuizHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    return FutureBuilder<dynamic>(
      future: getQuestionsData(),
      builder: (context, snapshot) {
        return Scaffold(
          drawer: const SettingsPage(),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: const Text('Quiz'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * kPageIndentHorizontal),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(),
                    const QuizTypeButtons(),
                    const Gap(),
                    const CourseTypeButtons(),
                    const Gap(),
                    const UnitDropdownButtons(),
                    const Gap(),
                    const NumberOfQuestionsButtons(),
                    const Gap(),
                    const CheckAnswersAtEndButton(),
                    const Gap(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.30,
                          vertical: size.height * 0.05),
                      child: CustomChipButton(
                          text: 'Start Quiz',
                          onPressed: () {
                            final state = _formKey.currentState;
                            state?.saveAndValidate();
                            List<QuestionModel> selectedQuestions =
                                editState.allQuestions.toList();
                            // final questionType = editState.questionType;
                            // final course = editState.course;
                            final unit = state?.fields[kUnit]?.initialValue;
                            final subunit = state?.fields[kSubunit]?.initialValue;
                            // final numberOfQuestion = editState.numberOfQuestions;
                            // final checkAtEnd = editState.checkAnswersAtEnd;

                            for (var q in editState.allQuestions) {
                              if (q.course != editState.course) {
                                selectedQuestions.remove(q);
                              }
                              if (unit != null && q.unit != unit) {
                                selectedQuestions.remove(q);
                              }
                              if (subunit != null && q.subunit != subunit) {
                                selectedQuestions.remove(q);
                              }
                            }

                            quizNotifier.setSelectedQuestions(selectedQuestions);

                            WidgetsBinding.instance.addPostFrameCallback((t) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => QuestionPage()));
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
