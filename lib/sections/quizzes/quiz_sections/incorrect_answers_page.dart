import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/configs/constants.dart';

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
    Map<int, QuestionModel> incorrectQuestions = {};

    for (int i = 0; i < quizState.selectedQuestions.length; i++) {
      if (quizState.selectedQuestions[i].answerStage == AnswerStage.incorrect) {
        incorrectQuestions.addAll({i + 1: quizState.selectedQuestions[i]});
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: const Text('Quiz Review'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.defaultAppColorDarker,
              automaticallyImplyLeading: false,
              pinned: false,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: const [
                Text('Incorrect answers'),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * kPageIndentHorizontal / 2),
            child: Column(
              children: [
                ...incorrectQuestions.entries.map((question) => Padding(
                      padding: EdgeInsets.all(
                          size.width * kPageIndentHorizontal / 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(
                                kBackgroundOpacity,
                              ),
                          borderRadius: BorderRadius.circular(kRadiusBig),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              size.width * kPageIndentHorizontal),
                          child: QuestionTile(
                            question: question.value,
                            index: question.key,
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * kBottomIndent,
                  ),
                  child: CustomBigButton(
                      text: 'Close',
                      onPressed: () => Navigator.of(context).maybePop()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
