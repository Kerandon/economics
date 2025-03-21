import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../diagrams/diagram_widgets/custom_diagram_builder.dart';
import '../../methods/get_tile_decoration.dart';
import 'answer_tile.dart';
import 'edit_question_button.dart';

class MultiChoiceTile extends ConsumerWidget {
  const MultiChoiceTile(
    this.question, {
    this.editMode = false,
    super.key,
  });

  final QuestionModel question;
  final bool editMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final tileSpacing = size.width * 0.01;
    return IgnorePointer(
      ignoring: question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect,
      child: Container(
        decoration: getTileDecoration(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tileSpacing,
            vertical: tileSpacing,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: tileSpacing),
                child: Container(
                  decoration: getTileDecoration(context),
                  child: Padding(
                    padding: EdgeInsets.all(tileSpacing),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                question.question ?? "",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CustomDiagramBuilder(
                                  diagrams: question.diagrams?.toList()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: EditQuestionButton(
                              question: question,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: tileSpacing,
                ),
                child: (question.answers?.isNotEmpty ?? false)
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: question.answers?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: tileSpacing,
                          crossAxisSpacing: tileSpacing,
                          mainAxisExtent: (size.height * 0.28),
                        ),
                        itemBuilder: (context, index) {
                          final a = question.answers![index];
                          return GridTile(
                            child: AnswerTile(
                              answer: a.copyWith(
                                  answerStage: editMode
                                      ? a.isCorrect
                                          ? AnswerStage.correct
                                          : null
                                      : null),
                              question: question,
                              answerIndex: index,
                            ),
                          );
                        },
                      )
                    : Container(color: Colors.red, width: 50, height: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
