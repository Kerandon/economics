import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/question_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';

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
    Map<int, QuestionModel> incorrectQuestions = {};

    for (int i = 0; i < quizState.selectedQuestions.length; i++) {
      if (quizState.selectedQuestions[i].answerStage == AnswerStage.incorrect) {
        incorrectQuestions.addAll({i + 1: quizState.selectedQuestions[i]});
      }
    }

    return Scaffold(
      appBar: AppBar(
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
                CustomButtonOverlayAppBar(
                  title: 'Incorrect answers',
                )
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: incorrectQuestions.entries
                .map((question) => QuestionTile(
                      question: question.value,
                      index: question.key,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
