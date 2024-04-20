import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/articles/articles_models/article_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/question_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/quiz_stats.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_models/answer_model.dart';
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
  List<QuestionModel> selectedQuestions = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions.isEmpty) {
      for (var q in quizState.allQuestions) {
        if (q.tags != null &&
            q.tags!.isNotEmpty &&
            q.tags!.any((element) => element == widget.articleModel.title)) {
          selectedQuestions.add(q.shuffleAnswers());
        }
      }

      selectedQuestions = selectedQuestions..shuffle();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        List<QuestionModel> updatedSelectedQuestions = [];

        for (var q in selectedQuestions) {
          List<AnswerModel> updatedAnswers = [];
          for (var a in q.answers) {
            // Reset the AnswerStage property for each answer
            updatedAnswers.add(a.copyWith(answerStage: AnswerStage.notSelected));
          }
          // Update the answers list for the current question
          QuestionModel updatedQuestion = q.copyWith(answers: updatedAnswers);
          updatedSelectedQuestions.add(updatedQuestion);
        }

        quizNotifier.setCurrentQuestions(updatedSelectedQuestions);
        print('REGENERATE QUESTIONS');
      });


    }

    // for(var q in quizState.selectedQuestions){
    //   print('${q.answerStage} and ${q.question}');
    //   for(var a in q.answers){
    //     print('answers ${a.answerStage}');
    //   }
    // }

    return ExpansionTile(
      initiallyExpanded: true,
      leading: const Icon(Icons.quiz_outlined),
      title: const Text('Review quiz'),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * kPageIndentHorizontal),
          child: Column(
            children: [
              ...[                      SizedBox(
          height: size.height * kPageIndentVertical * 2)],
              ...quizState.selectedQuestions.map((q) {
                return QuestionTile(
                  index: quizState.selectedQuestions.indexOf(q),
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
              if(quizState.questionsAllAnswered)...[
                const QuizStats(),
              ],

            ],
          ),
        ),
        SizedBox(height: size.height * 0.05,)
      ],
    );
  }
}
