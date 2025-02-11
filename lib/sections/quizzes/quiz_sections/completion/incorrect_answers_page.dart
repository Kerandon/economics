import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/flip_card_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/multi_choice_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../quiz_enums/topic_tag.dart';
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
    final editState = ref.watch(editQuestionProvider);
    final quizState = ref.watch(quizProvider);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    Map<int, QuestionModel> incorrectQuestions = {};

    for (int i = 0; i < quizState.selectedQuestions.length; i++) {
      if (quizState.selectedQuestions[i].answerStage == AnswerStage.incorrect) {
        incorrectQuestions.addAll({i + 1: quizState.selectedQuestions[i]});
      }
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // Align the text to the left
              Expanded(
                flex: 12,
                child: AutoSizeText(
                  '${editState.unit.name} - ${editState.subunit.name}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      '${incorrectQuestions.keys.length} incorrect answers: ${incorrectQuestions.keys.map((e) => 'Q${e.toString()}')}',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
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
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(kRadiusBig),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * kPageIndentHorizontal,
                        vertical: size.height * 0.01,
                      ),
                      child: Column(
                        children: [
                          CustomDivider(),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.close_outlined,
                                  color: Colors.red,
                                  size: 32,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text(
                                  'Question ${question.key.toString()}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          if (question.value.topicTag ==
                              TopicTag.multipleChoiceQuestions) ...[
                            MultiChoiceTile(question.value),
                          ],
                          if (question.value.topicTag !=
                              TopicTag.multipleChoiceQuestions) ...[
                            FlipCardTile(question.value),
                          ],
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
