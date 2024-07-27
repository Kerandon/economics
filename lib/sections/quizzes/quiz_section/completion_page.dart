import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/animation/confetti_animation.dart';
import '../quiz_state/quiz_state.dart';
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
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    const spacing = 0.01;
    int numberCorrect = 0;
    int totalQuestions = quizState.selectedQuestions.length;

    for (var q in quizState.selectedQuestions) {
      if (q.answerStage == AnswerStage.correct) {
        numberCorrect++;
      }
    }
    double percentCorrect = 0;
    if (totalQuestions > 1) {
      percentCorrect = numberCorrect / totalQuestions;
    }
    String emoji = '';
    if (percentCorrect == 0) {
      emoji = '😓';
    } else if (percentCorrect > 0 && percentCorrect < 50) {
      emoji = '😬';
    } else if (percentCorrect >= 50 && percentCorrect < 90) {
      emoji = '💪';
    } else if (percentCorrect >= 90 && percentCorrect <= 99) {
      emoji = '🤩';
    } else if (percentCorrect == 100) {
      emoji = '🎯';
    }

    return Stack(
      children: [
        Center(
          child: IntrinsicWidth(
            child: IntrinsicHeight(
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
                    SizedBox(
                      height: size.height * spacing,
                    ),
                    Text(
                      'Quiz summary',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * spacing,
                      ),
                      child: Text(
                        emoji,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 60,
                            ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(kBackgroundOpacity),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border()),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.03),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.01),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      'Your score',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    SizedBox(
                                      height: size.height * spacing,
                                    ),
                                    Text('${(percentCorrect * 100).round()}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            )),
                                    SizedBox(
                                      height: size.height * spacing,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.titleLarge,
                                children: [
                                  TextSpan(
                                    text: '$numberCorrect',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text: ' of ',
                                  ),
                                  TextSpan(
                                    text: '$totalQuestions',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' questions were answered correctly',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const IncorrectAnswersPage()));
                            },
                            child: const Text(
                              'Review incorrect answers',
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                quizNotifier.setResetQuestions();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              },
                              child: const Text(
                                'New Quiz',
                                textAlign: TextAlign.center,
                              )))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (percentCorrect == 100) ...[const ConfettiAnimation()],
      ],
    );
  }
}
