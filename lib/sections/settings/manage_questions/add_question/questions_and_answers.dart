import 'package:economics_app/sections/settings/manage_questions/add_question/add_diagrams_page.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../quizzes/quiz_enums/question_part_enum.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

class QuestionsAndAnswers extends ConsumerWidget {
  const QuestionsAndAnswers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: CustomTextField(
                          name: kQuestion,
                          onChanged: (value) {
                            editNotifier
                              ..updateCurrentQuestion(editState.currentQuestion
                                  .copyWith(question: value))
                              ..setQuestionPartSelected(
                                QuestionPart.question,
                              );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                editNotifier.setQuestionPartSelected(
                                    QuestionPart.question);
                                showDialog(
                                  context: context,
                                  builder: (context) => AddDiagramPage(),
                                );
                              },
                              icon: Icon(
                                Icons.insert_chart_outlined,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...List.generate(
                        editState.currentQuestion.diagrams?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size.width * 0.20,
                            height: size.width * 0.20,
                            child: CustomPaint(
                              painter: editState
                                  .currentQuestion.diagrams![index].painter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ...List.generate(
                editState.currentQuestion.answers!.length,
                (index) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 12,
                          child: CustomTextField(
                            name: '$kAnswer ${index + 1}',
                            onChanged: (value) {
                              List<AnswerModel> answers =
                                  editState.currentQuestion.answers?.toList() ??
                                      [];

                              if (index >= 0 && index < answers.length) {
                                answers[index] =
                                    answers[index].copyWith(answer: value);

                                editNotifier.updateCurrentQuestion(
                                  editState.currentQuestion.copyWith(
                                    answers: answers,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  editNotifier.setQuestionPartSelected(
                                    '$kAnswer $index'.toQuestionPartEnum(),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddDiagramPage(),
                                  );
                                },
                                icon: Icon(
                                  Icons.insert_chart_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.image_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ChoiceChip(
                            onSelected: (value) {
                              final a =
                                  editState.currentQuestion.answers?.toList() ??
                                      [];

                              if (index >= 0 && index < a.length) {
                                a[index] = a[index].copyWith(isCorrect: value);

                                editNotifier.updateCurrentQuestion(
                                  editState.currentQuestion.copyWith(
                                    answers: a,
                                  ),
                                );
                              }
                            },
                            checkmarkColor: Colors.white,
                            selectedColor: theme.colorScheme.primary,
                            label: Builder(builder: (context) {
                              final isSelected =
                                  editState.currentQuestion.answers != null &&
                                          index <
                                              editState.currentQuestion.answers!
                                                  .length
                                      ? editState.currentQuestion
                                          .answers![index].isCorrect
                                      : false;
                              return Text(
                                isSelected ? 'Correct' : 'Incorrect',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isSelected ? Colors.white : Colors.red,
                                ),
                              );
                            }),
                            selected:
                                editState.currentQuestion.answers != null &&
                                        index <
                                            editState
                                                .currentQuestion.answers!.length
                                    ? editState.currentQuestion.answers![index]
                                        .isCorrect
                                    : false,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        ...List.generate(
                          editState.currentQuestion.answers?[index].diagrams
                                  ?.length ??
                              0,
                          (i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: size.width * 0.20,
                              height: size.width * 0.20,
                              child: CustomPaint(
                                painter: editState.currentQuestion
                                    .answers?[index].diagrams![i].painter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
