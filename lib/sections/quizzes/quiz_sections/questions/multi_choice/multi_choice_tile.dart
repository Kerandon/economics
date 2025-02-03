import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'answer_tile.dart';

class MultiChoiceTile extends ConsumerWidget {
  const MultiChoiceTile(
    this.question, {
    super.key,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceTint,
        // Set background color
        borderRadius: BorderRadius.circular(kRadius),
        // Set the radius for rounded corners
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .shadow, // Shadow color (black with some transparency)
            offset: Offset(0, 4), // Shadow offset (vertical and horizontal)
            blurRadius: 8, // How blurry the shadow is
            spreadRadius: 2, // How much the shadow spreads
          ),
        ],
      ),
      child: IgnorePointer(
        ignoring: question.answerStage == AnswerStage.correct ||
            question.answerStage == AnswerStage.incorrect,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                question.question ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * kPageIndentHorizontal,
                right: size.width * kPageIndentHorizontal,
                bottom: size.height * kPageIndentVertical,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: question.answers?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQuery.of(context).size.height *
                      0.58 /
                      2, // 80% height divided by 2 rows
                ),
                itemBuilder: (context, index) => GridTile(
                  child: Center(
                    child: AnswerTile(
                      answer: question.answers![index],
                      question: question,
                      answerIndex: index,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
