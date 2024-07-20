import 'package:economics_app/sections/quizzes/quiz_data/number_of_questions.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_section/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_big_button.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/custom_heading.dart';
import '../../../app/custom_widgets/custom_small_divider.dart';
import '../../../app/custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';
import '../../../app/enums/sections.dart';
import '../quiz_enums/answer_stage.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  bool _showIcon = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    return Stack(
      children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: AppColors.defaultAppColorDarker,
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                actions: const [
                  CustomButtonOverlayAppBar(
                    title: 'Quiz',
                  )
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                ExpansionTile(
                  onExpansionChanged: (open) {
                    _showIcon = !_showIcon;
                    setState(() {});
                  },
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Quiz settings'),
                  children: [
                    const CustomHeading('Quiz me on'),
                    Wrap(
                        spacing: size.width * kWrapSpacing,
                        alignment: WrapAlignment.center,
                        children:
                            quizState.selectedSections.entries.map((section) {
                          bool isSelected = false;

                          for (var s in quizState.selectedSections.entries) {
                            if (s.key == section.key && s.value) {
                              isSelected = s.value;
                            }
                          }

                          return CustomChipButton(
                              text: section.key.getSectionName(),
                              isSelected: isSelected,
                              onPressed: () {
                                quizNotifier.setSectionAsSelected(
                                    section.key, !isSelected);
                              });
                        }).toList()),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const CustomSmallDivider(),
                    const CustomHeading('Number of questions'),
                    Wrap(
                      spacing: size.width * kWrapSpacing,
                      alignment: WrapAlignment.center,
                      children: numberOfQuestions.map((number) {
                        bool isSelected = false;
                        if (number == quizState.numberOfQuestionsSelected) {
                          isSelected = true;
                        }

                        return CustomChipButton(
                            text: number.toString(),
                            isSelected: isSelected,
                            onPressed: () {
                              quizNotifier.setNumberOfQuestionsSelected(number);
                            });
                      }).toList(),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const CustomSmallDivider(),
                    SwitchListTile(
                        title: Text(
                          'Show answers as I go',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        value: quizState.showAnswersAsIGo,
                        onChanged: (on) {
                          quizNotifier.setShowAnswersAsIGo(on);
                        }),
                  ],
                ),
                AnimatedContainer(
                  height: _showIcon ? height * 0.45 : height * 0.06,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                CustomBigButton(
                  text: 'Start Quiz!',
                  onPressed: quizState.selectedSections.values
                          .every((element) => element == false)
                      ? null
                      : () {
                          quizNotifier.setResetQuestions();
                          List<QuestionModel> selectedQuestions = [];

                          for (var q in quizState.allQuestions) {
                            {
                              selectedQuestions.add(q.shuffleAnswers());
                            }
                          }
                          selectedQuestions.shuffle();

                          quizNotifier.setSelectedQuestions(selectedQuestions);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QuestionPage()));
                        },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
