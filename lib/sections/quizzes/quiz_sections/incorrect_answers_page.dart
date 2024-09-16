import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_page_heading.dart';

class IncorrectAnswersPage extends ConsumerStatefulWidget {
  const IncorrectAnswersPage({super.key});

  @override
  ConsumerState<IncorrectAnswersPage> createState() =>
      _IncorrectAnswersPageState();
}

class _IncorrectAnswersPageState extends ConsumerState<IncorrectAnswersPage> {
  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final size = MediaQuery.of(context).size;
    Map<int, QuestionModelMulti> incorrectQuestions = {};

    for (int i = 0; i < quizState.selectedQuestions.length; i++) {
      if (quizState.selectedQuestions[i].answerStage == AnswerStage.incorrect) {
        incorrectQuestions.addAll({i + 1: quizState.selectedQuestions[i]});
      }
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomPageHeading(
                title:
                    'Review incorrect answers (${incorrectQuestions.length.toString()})',
                icon: const Icon(Icons.question_answer_outlined),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...incorrectQuestions.entries.map(
                  (question) => Padding(
                    padding:
                        EdgeInsets.all(size.width * kPageIndentHorizontal / 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.onSurface.withOpacity(
                                  kBackgroundOpacity,
                                ),
                        borderRadius: BorderRadius.circular(kRadiusBig),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * kPageIndentHorizontal),
                        child: Column(
                          children: [
                            QuestionTile(
                              question: question.value,
                              index: question.key,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * kBottomIndent,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    icon: const Icon(Icons.keyboard_return_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
