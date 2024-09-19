import 'package:economics_app/sections/quizzes/quiz_sections/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/quiz_home_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/custom_widgets/custom_big_button.dart';
import '../quiz_data/questions_bank/questions_bank.dart';
import '../quiz_models/question_model.dart';
import '../quiz_state/quiz_state.dart';

class StartQuizWidget extends ConsumerStatefulWidget {
  const StartQuizWidget({
    super.key,
  });

  @override
  ConsumerState<StartQuizWidget> createState() => _StartQuizWidgetState();
}

class _StartQuizWidgetState extends ConsumerState<StartQuizWidget> {
  late final Future<dynamic> _quizFuture;

  @override
  void initState() {
    _quizFuture = getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    return FutureBuilder<dynamic>(
        future: _quizFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

          }

          return CustomBigButton(
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
          );
        });
  }
}
