import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/sections/quizzes/quiz_data/number_of_questions.dart';
import 'package:economics_app/sections/quizzes/quiz_data/questions_bank/questions_bank.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_big_button.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/enums/sections.dart';
import '../quiz_enums/answer_stage.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: false);

  bool _expanded = false; // Move _expanded outside of the build method

  @override
  void initState() {
    super.initState();

    _expandableController.addListener(() {
      setState(() {
        _expanded = _expandableController.expanded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final kVerticalSettingsGap = height * 0.01;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    // if(!_initializedListener) {
    //   _initializedListener = true;
    //   _expandableController.addListener(() {
    //     _expanded = _expandableController.expanded;
    //   });
    // }

    return Stack(
      children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const CustomPageHeading(
                icon: Icon(
                  Icons.question_answer_outlined,
                ),
                title: 'Quiz',
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: kVerticalSettingsGap,
                ),
                ExpandableNotifier(
                  controller: _expandableController,
                  child: ExpandablePanel(
                    header: const ListTile(
                      title: Text('Settings'),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: Column(
                      children: [
                        const ListTile(title: Text('Sections')),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...Section.values.map(
                                (s) {
                                  return CustomChipButton(
                                    text: s.getSectionShortName(),
                                    isSelected:
                                        quizState.selectedSections.contains(s),
                                    onPressed: () {
                                      quizNotifier.setSectionAsSelected(s);
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: kVerticalSettingsGap),
                          child: const CustomDivider(),
                        ),
                        const ListTile(
                          title: Text('Number of questions'),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...numberOfQuestions.map(
                                (q) {
                                  return CustomChipButton(
                                    text: q.toString(),
                                    isSelected:
                                        quizState.numberOfQuestionsSelected ==
                                            q,
                                    onPressed: () {
                                      quizNotifier
                                          .setNumberOfQuestionsSelected(q);
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: kVerticalSettingsGap),
                          child: const CustomDivider(),
                        ),
                        SwitchListTile(
                            title: const Text('Check answers as I go'),
                            value: quizState.showAnswersAsIGo,
                            onChanged: (on) {
                              quizNotifier.setShowAnswersAsIGo(on);
                            }),
                        const CustomDivider(),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  height: _expanded ? size.height * 0.15 : size.height * 0.30,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.easeInOut,
                ),
                CustomBigButton(
                  text: 'Start Quiz!',
                  onPressed: quizState.selectedSections.isEmpty
                      ? null
                      : () {
                          quizNotifier.setResetQuestions();
                          List<QuestionModel> selectedQuestions = [];

                          for (var q in questionsBank) {
                            {
                              selectedQuestions.add(q.shuffleAnswers());
                            }
                          }
                          selectedQuestions.shuffle();

                          quizNotifier.setSelectedQuestions(selectedQuestions);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QuestionPage(),
                            ),
                          );
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
