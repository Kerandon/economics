import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../diagrams/diagram_widgets/custom_diagram_builder.dart';
import '../../methods/get_tile_decoration.dart';
import '../../quiz_enums/answer_stage.dart';
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

    final tileSpacing = size.width * 0.01;

    return IgnorePointer(
      ignoring: question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect,
      child: Container(
        decoration: getTileDecoration(context),
        padding: EdgeInsets.all(tileSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: tileSpacing),
              child: Container(
                decoration: getTileDecoration(context),
                padding: EdgeInsets.symmetric(
                    horizontal: tileSpacing, vertical: tileSpacing / 2),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Centered question text
                    HtmlWidget(
                      question.question ?? "",
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                    ),
                    // Diagram aligned to the left
                    if (question.diagrams != null &&
                        question.diagrams!.isNotEmpty)
                      Positioned(
                        left: 0,
                        child: CustomDiagramBuilder(
                          diagrams: question.diagrams!.toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Answers grid
            if (question.answers?.isNotEmpty ?? false)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: question.answers!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: tileSpacing,
                  crossAxisSpacing: tileSpacing,
                  mainAxisExtent: size.height * 0.25,
                ),
                itemBuilder: (context, index) {
                  final a = question.answers![index];

                  return GridTile(
                    child: AnswerTile(
                      answer: a,
                      question: question,
                      answerIndex: index,
                    ),
                  );
                },
              )
            else
              Center(
                child: Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
