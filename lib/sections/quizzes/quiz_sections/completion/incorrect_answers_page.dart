import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/flip_card/flip_card_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../questions/quiz_models/question_model.dart';

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

    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...incorrectQuestions.entries.map(
                (question) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * kPageIndentHorizontal,
                    vertical: size.height * 0.01,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadiusBig),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * kPageIndentHorizontal,
                        vertical: size.height * 0.01,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                'Question ${question.key.toString()}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          FlipCardTile(question.value)
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
                child: CustomChipButton(
                    text: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    isSelected: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
