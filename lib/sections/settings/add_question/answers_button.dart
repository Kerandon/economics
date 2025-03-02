import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/settings/add_question/correct_box.dart';
import 'package:economics_app/sections/settings/add_question/custom_text_field.dart';
import 'package:economics_app/sections/settings/add_question/diagrams/add_diagrams_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_enums/question_part_enum.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class AnswersButton extends ConsumerWidget {
  const AnswersButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final isMulti =
        editState.currentQuestion.topicTag == TopicTag.multipleChoiceQuestion;

    return Column(
      children: [
        ...List.generate(
          editState.currentQuestion.answers?.length ?? 0,
          (index) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: CustomTextField(
                      minLines: isMulti ? 1 : 5,
                      label: isMulti
                          ? '${QuestionKey.answer.name} ${index + 1}'
                          : QuestionKey.answer.name,
                      name: '${QuestionKey.answer.name} ${index + 1}',
                      onChanged: (value) {
                        List<AnswerModel> answers =
                            editState.currentQuestion.answers?.toList() ?? [];

                        editNotifier.updateCurrentQuestion(
                          editState.currentQuestion.copyWith(
                            answers: answers,
                          ),
                        );
                        // }
                      },
                    ),
                  ),
                  if (editState.currentQuestion.questionType ==
                      QuestionType.multi) ...[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              editNotifier.setQuestionPartSelected(
                                '${QuestionKey.answer.name} $index'
                                    .toQuestionPartEnum(),
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
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Add image'),
                                      ));
                            },
                            icon: Icon(
                              Icons.image_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMulti) ...[
                      Expanded(child: SizedBox()),
                    ],
                    if (isMulti) ...[
                      Expanded(
                        flex: 2,
                        child: CorrectBox(
                          index: index,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
              Wrap(
                children: [
                  ...List.generate(
                    editState
                            .currentQuestion.answers?[index].diagrams?.length ??
                        0,
                    (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.20,
                        height: size.width * 0.20,
                        child: CustomPaint(
                          painter: editState.currentQuestion.answers?[index]
                              .diagrams![i].painter,
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
    );
  }
}
