import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/custom_widgets/gap.dart';
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
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    const spacing = 0.03;
    int numberCorrect = 0;
    int totalQuestions = quizState.selectedQuestions.length;

    for (var q in quizState.selectedQuestions) {
      if (q.answerStage == AnswerStage.correct) {
        numberCorrect++;
      }
    }
    double percentCorrect = 0.0;
    if (totalQuestions > 1) {
      percentCorrect = numberCorrect / totalQuestions;
    }

    String emoji = '';
    if (percentCorrect < 0.50) {
      emoji = '📈';
    } else if (percentCorrect >= 0.50 && percentCorrect < 0.85) {
      emoji = '🏆';
    } else if (percentCorrect >= 0.85 && percentCorrect <= 0.99) {
      emoji = '🚀';
    } else if (percentCorrect == 1.00) {
      emoji = '🎯';
    }

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
                SizedBox(
                  height: size.height * spacing,
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
                    emoji,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 60,
                        ),
                  ),
                ),
              ],
            ),
            content: Builder(builder: (context) {
              final size = MediaQuery.of(context).size;
              return SizedBox(
                width: size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(kBackgroundOpacity),
                          borderRadius: BorderRadius.circular(kRadius),
                          border: const Border()),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.10,
                            vertical: size.height * 0.03),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.01),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * spacing,
                                    ),
                                    Text(
                                      '${(percentCorrect * 100).round()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
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
                                style: Theme.of(context).textTheme.displaySmall,
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
              );
            }),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Column(
                children: [
                  const Gap(),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: size.width * kWrapSpacing,
                    children: [
                      if (percentCorrect != 1.0) ...[
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
                      CustomChipButton(
                        text: 'New quiz',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                          WidgetsBinding.instance.addPostFrameCallback((t) {
                            quizNotifier.setResetQuestions();
                          });
                        },
                        isSelected: true,
                      ),
                    ],
                  ),
                  const Gap(),
                ],
              ),
            ],
          ),
        ),
        if (percentCorrect == 100) ...[const ConfettiAnimation()],
      ],
    );
  }
}
