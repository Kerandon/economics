import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/select_sections_widget.dart';
import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/custom_widgets/custom_icon_button.dart';
import '../../../../app/custom_widgets/custom_pop_up.dart';
import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/enums/course.dart';
import 'answer_row.dart';
import 'custom_text_field.dart';

import '../../quiz_enums/question_type.dart';

class AddQuestionPage extends ConsumerStatefulWidget {
  const AddQuestionPage({
    super.key,
  });

  @override
  ConsumerState<AddQuestionPage> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends ConsumerState<AddQuestionPage> {
  final _questionController = TextEditingController();
  final _explanationController = TextEditingController();
  final List<AnswerRow> _answerRows = [];
  final List<TextEditingController> _answerControllers = [];

  @override
  initState() {
    for (int i = 0; i < 2; i++) {
      final c = TextEditingController();
      _answerRows.add(
        AnswerRow(
            index: i,
            controller: c,
            hintText: i == 0
                ? 'Type the correct answer here...'
                : 'Type incorrect answer $i here...'),
      );
      _answerControllers.add(c);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addQuestionState = ref.watch(addQuestionProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
        title: const Text('Add quiz question'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(),
              Wrap(
                spacing: 20,
                children: [
                  CustomChipButton(
                    text: QuestionType.multi.toText(),
                    onPressed: () =>
                        addQuestionNotifier.setQuestionType(QuestionType.multi),
                    isSelected:
                        addQuestionState.questionType == QuestionType.multi,
                  ),
                  CustomChipButton(
                    text: QuestionType.flip.toText(),
                    onPressed: () {
                      addQuestionNotifier.setQuestionType(QuestionType.flip);
                    },
                    isSelected:
                        addQuestionState.questionType == QuestionType.flip,
                  ),
                ],
              ),
              const Gap(
                showDivider: true,
              ),
              Wrap(
                spacing: 20,
                children: [
                  CustomChipButton(
                    text: Course.ib.toText(),
                    onPressed: () => addQuestionNotifier.setCourse(Course.ib),
                    isSelected: addQuestionState.course == Course.ib,
                  ),
                  CustomChipButton(
                    text: Course.igcse.toText(),
                    onPressed: () =>
                        addQuestionNotifier.setCourse(Course.igcse),
                    isSelected: addQuestionState.course == Course.igcse,
                  ),
                ],
              ),
              const Gap(),
              CustomTextField(
                controller: _questionController,
                hintText: 'Type your question here...',
              ),
              const Gap(
                showDivider: true,
              ),
              ..._answerRows,
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Green background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: CustomIconButton(
                        onPressed: () {
                          if (_answerRows.length < 4) {
                            final c = TextEditingController();
                            _answerRows.add(
                              AnswerRow(
                                index: _answerRows.length + 1,
                                controller: c,
                                hintText:
                                    'Type incorrect answer ${_answerRows.length} here...',
                              ),
                            );
                            _answerControllers.add(c);
                            setState(() {});
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const CustomPopUp(
                                title: 'Cannot add answer',
                                subtitle:
                                    'Multi-choice questions must have between 2 to 4 answers',
                              ),
                            );
                          }
                        },
                        icon: Icons.add,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  CustomIconButton(
                    onPressed: () {
                      if (_answerRows.length > 2) {
                        _answerRows.removeLast();
                        setState(() {});
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const CustomPopUp(
                            title: 'Cannot add answer',
                            subtitle:
                                'Multi-choice questions must have between 2 to 4 answers',
                          ),
                        );
                      }
                    },
                    icon: Icons.remove,
                  ),
                ],
              ),
              const Gap(
                showDivider: true,
              ),
              CustomTextField(
                controller: _explanationController,
                hintText: 'Type an optional answer explanation here...',
              ),
              const Gap(),
              const SelectSectionsWidget(),
              SizedBox(
                height: size.height * 0.10,
              ),
              CustomBigButton(text: 'Add Question', onPressed: () {}),
              const Gap(),
              SizedBox(
                height: size.height * 0.10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
