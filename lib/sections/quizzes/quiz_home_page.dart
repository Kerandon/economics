import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/check_answers_at_end_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/number_of_questions_buttons.dart';
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
import 'methods/filter_selected_questions.dart';
import 'methods/start_quiz.dart';

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
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final quizNotifier = ref.read(quizProvider.notifier);

    final filteredQuestions = filterSelectedQuestion(
        editState: editState,
        editNotifier: editNotifier,
        quizNotifier: quizNotifier,
        formKey: _formKey);

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
                CustomChipButton(
                  isDisabled: filteredQuestions.isEmpty,
                  text: 'Start Quiz',
                  onPressed: () {
                    startQuiz(
                      context: context,
                      quizNotifier: quizNotifier,
                      filteredQuestions: filteredQuestions,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
