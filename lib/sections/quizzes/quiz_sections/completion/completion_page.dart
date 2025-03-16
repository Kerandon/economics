import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/methods/reset_questions_models.dart';
import 'package:economics_app/sections/quizzes/methods/shuffle_question_models.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_page.dart';
import 'package:economics_app/sections/tab_main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quiz_state/quiz_state.dart';
import 'incorrect_answers_page.dart';

class CompletionPage extends ConsumerStatefulWidget {
  const CompletionPage({super.key});

  @override
  ConsumerState<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends ConsumerState<CompletionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    const spacing = 0.03;
    return Stack(
      children: [
        Center(
          child: AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      icon: const Icon(Icons.close), // Close icon
                    ),
                  ],
                ),
                Text(
                  'Results',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * spacing,
                  ),
                  child: Text(
                    quizState.results.resultEmoji,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 100,
                        ),
                  ),
                ),
              ],
            ),
            content: ConstrainedBox(
              constraints: BoxConstraints(minWidth: size.width * 0.60),
              child: Builder(builder: (context) {
                final size = MediaQuery.of(context).size;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: size.height * spacing,
                              ),
                              child: Text(
                                quizState.results.percentCorrect,
                                style: theme.textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: theme.textTheme.titleLarge,
                          children: [
                            TextSpan(
                              text: quizState.results.totalAnsweredCorrect
                                  .toString(),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const TextSpan(
                              text: ' of ',
                            ),
                            TextSpan(
                              text: quizState.results.totalAnswered.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const TextSpan(
                              text: ' answers were correct',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
            actions: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  if (!quizState.results.allQuestionsAreCorrect) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChipButton(
                          text: 'Retest incorrect answers',
                          onPressed: () {
                            List<QuestionModel> incorrectQuestions = [];
                            for (var q in quizState.selectedQuestions) {
                              if (q.answerStage == AnswerStage.incorrect) {
                                incorrectQuestions.add(q);
                              }
                            }

                            incorrectQuestions =
                                resetAnswerStage(incorrectQuestions.toList());

                            quizNotifier.setResetQuestions();
                            incorrectQuestions = shuffleQuestionsAndAnswers(
                                incorrectQuestions.toList());
                            quizNotifier.setSelectedQuestions(
                                incorrectQuestions.toList());

                            WidgetsBinding.instance.addPostFrameCallback((t) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QuestionPage(),
                                ),
                              );
                            });
                          },
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        CustomChipButton(
                          text: 'Review incorrect answers',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const IncorrectAnswersPage()));
                          },
                          isSelected: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                      ),
                      child: CustomDivider(),
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomChipButton(
                        text: 'New quiz',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => StartPage()),
                          );
                          WidgetsBinding.instance.addPostFrameCallback((t) {
                            quizNotifier.setResetQuestions();
                          });
                        },
                        isSelected: true,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      CustomChipButton(
                        text: 'Home',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const TabBarMain()),
                          );
                          WidgetsBinding.instance.addPostFrameCallback((t) {
                            quizNotifier.setResetQuestions();
                          });
                        },
                        isSelected: true,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
