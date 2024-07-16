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
    return Stack(
      children: [
        AlertDialog(
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
              const Text(
                'Quiz Completed',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.05),
                  child: SizedBox(
                    height: size.height * 0.20,
                    child: FittedBox(
                      child: Text(
                        '${(percentCorrect * 100).round()}%',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 2000,
                                ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '$numberCorrect / $totalQuestions',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * kPageIndentVertical),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const IncorrectAnswersPage()));
                    },
                    child: const Text('Review incorrect answers'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * kPageIndentVertical),
                    child: OutlinedButton(
                      onPressed: () {
                        quizNotifier.setResetQuestions();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      child: const Text('New Quiz'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const ConfettiAnimation(),
      ],
    );
  }
}
