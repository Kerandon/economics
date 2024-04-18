import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/articles/articles_models/article_model.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/question_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_models/question_model.dart';
import '../quiz_state/quiz_state.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage(
    this.articleModel, {
    super.key,
  });

  final ArticleModel articleModel;

  @override
  ConsumerState<QuizPage> createState() => _ArticleQuizSectionState();
}

class _ArticleQuizSectionState extends ConsumerState<QuizPage> {
  bool _questionsAreSet = false;
  List<QuestionModel> selectedQuestions = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (!_questionsAreSet) {
      for (var q in quizState.allQuestions) {
        if (q.tags != null &&
            q.tags!.isNotEmpty &&
            q.tags!.any((element) => element == widget.articleModel.title)) {
          selectedQuestions.add(q);
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        quizNotifier.setCurrentQuestions(selectedQuestions);
        selectedQuestions = quizState.currentQuestions;
      });
      _questionsAreSet = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedQuestions = quizState.currentQuestions.toList();
    });

    return ExpansionTile(
      leading: const Icon(Icons.quiz_outlined),
      title: const Text('Review quiz'),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * kPageIndentHorizontal),
          child: Column(
            children: [
              ...quizState.currentQuestions.map((q) {
                return QuestionTile(
                  index: quizState.currentQuestions.indexOf(q),
                  question: q,
                );
              }).toList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!quizState.questionsAllAnswered) ...[
                    Padding(
                      padding:
                          EdgeInsets.all(size.height * kPageIndentVertical),
                      child: OutlinedButton(
                        onPressed: quizState.questionsAllSelected
                            ? () {
                                quizNotifier.checkAllAnswers();
                              }
                            : null,
                        child: const Text('Check Answers'),
                      ),
                    ),
                  ],
                ],
              ),
              Text((quizState.numberOfQuestionsCorrect /
                      quizState.currentQuestions.length)
                  .toPercentageString()),
              Text('${quizState.numberOfQuestionsCorrect} out of ${quizState.currentQuestions.length} are correct'),
            OutlinedButton(onPressed: (){}, child: Text('Try again'))
            ],
          ),
        ),
      ],
    );
  }
}
