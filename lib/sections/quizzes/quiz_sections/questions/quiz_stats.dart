import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizStats extends ConsumerWidget {
  const QuizStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuestionsNumberOfQuestionsCorrectState = ref.watch(
        quizProvider
            .select((s) => (s.selectedQuestions, s.numberOfQuestionsCorrect)));
    final quizNotifier = ref.read(quizProvider.notifier);
    final size = MediaQuery.of(context).size;
    const spacing = 0.02;
    return Column(
      children: [
        ...[
          Padding(
            padding: EdgeInsets.all(size.height * spacing),
            child: Text(
              (selectedQuestionsNumberOfQuestionsCorrectState.$2 /
                      selectedQuestionsNumberOfQuestionsCorrectState.$1.length)
                  .toPercentageString(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * spacing),
            child: Text(
              '${selectedQuestionsNumberOfQuestionsCorrectState.$2} / ${selectedQuestionsNumberOfQuestionsCorrectState.$1.length} answers are correct',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.height * spacing),
            child: OutlinedButton(
              onPressed: () {
                quizNotifier.setResetQuestions();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh_outlined),
                  SizedBox(
                    width: size.width * spacing,
                  ),
                  const Text('Try again'),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
