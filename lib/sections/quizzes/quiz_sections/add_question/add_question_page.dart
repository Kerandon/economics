import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/methods/send_question_to_firebase.dart';
import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/custom_widgets/custom_icon_button.dart';
import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/utils/mixins/course_mixin.dart';
import '../../../../app/utils/models/course.dart';
import '../../../../app/utils/models/unit.dart';
import '../../../settings/edit_courses/helper_methods/get_course_data_from_firebase.dart';
import '../questions/quiz_models/answer_model.dart';
import '../questions/quiz_models/question_model.dart';
import 'add_question_dropdowns.dart';
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
  late final Future<QuerySnapshot<Map<String, dynamic>>?> _courseDataFuture;
  final _explanationController = TextEditingController();
  final List<CustomTextField> _questionAndAnswerRows = [];
  final List<TextEditingController> _questionAndAnswerControllers = [];
  bool _setUpStateOnInit = false;
  final minNumberOfAnswers = 2;
  final maxNumberOfAnswers = 4;
  final numberOfAnswersOnInit = 4;
  List<CourseMixin> courses = [];

  @override
  initState() {
    _courseDataFuture = getCourseData();
    for (int i = 0; i < numberOfAnswersOnInit + 1; i++) {
      final c = TextEditingController();
      _questionAndAnswerRows.add(
        CustomTextField(
          requireValidation: true,
          id: i == 0 ? 'question' : 'answer${i - 1}',
          controller: c,
          label: i == 0
              ? 'Type the quiz question'
              : i == 1
                  ? '*Type the CORRECT answer'
                  : '*Type incorrect answer #${(i - 1)}',
        ),
      );
      _questionAndAnswerControllers.add(c);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () async {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text('Add quiz question'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
        future: _courseDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            if (!_setUpStateOnInit) {
              _setUpStateOnInit = true;
              for (var e in snapshot.data!.docs) {
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  addQuestionNotifier.resetState();
                  for (int i = 0; i < numberOfAnswersOnInit + 1; i++) {
                    addQuestionNotifier.addQuestionAndAnswer(MapEntry(
                        i == 0 ? 'question' : 'answer${i - 1}', false));
                  }
                });
                courses.add(
                  Course.fromMap({
                    e.id: e.data(),
                  }),
                );
              }

              if (addQuestionState.course.name == "") {
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  addQuestionNotifier.setCourse(courses.first);
                });
              }
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * kPageIndentHorizontal),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * kPageIndentHorizontal),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Wrap(
                        spacing: 20,
                        children: [
                          CustomChipButton(
                            text: QuestionType.multi.toText(),
                            onPressed: () => addQuestionNotifier
                                .setQuestionType(QuestionType.multi),
                            isSelected: addQuestionState.questionType ==
                                QuestionType.multi,
                          ),
                          CustomChipButton(
                            text: QuestionType.flip.toText(),
                            onPressed: () {
                              addQuestionNotifier
                                  .setQuestionType(QuestionType.flip);
                            },
                            isSelected: addQuestionState.questionType ==
                                QuestionType.flip,
                          ),
                        ],
                      ),
                      const Gap(
                        showDivider: true,
                      ),
                      Wrap(
                        spacing: 20,
                        children: courses.map((c) {
                          return CustomChipButton(
                            isSelected: c == addQuestionState.course,
                            onPressed: () {
                              addQuestionNotifier.setCourse(c);
                            },
                            text: c.name,
                          );
                        }).toList(),
                      ),
                      const Gap(),
                      ..._questionAndAnswerRows,
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          CustomIconButton(
                            onPressed: _questionAndAnswerRows.length <
                                    maxNumberOfAnswers + 1
                                ? () {
                                    final c = TextEditingController();

                                    _questionAndAnswerRows.add(
                                      CustomTextField(
                                        label:
                                            '*Type incorrect answer #${(_questionAndAnswerRows.length) - 1}',
                                        requireValidation: true,
                                        controller: c,
                                        id: 'answer${_questionAndAnswerRows.length - 1}',
                                      ),
                                    );
                                    _questionAndAnswerControllers.add(c);
                                    addQuestionNotifier.addQuestionAndAnswer(
                                        MapEntry(
                                            'answer${_questionAndAnswerRows.length - 2}',
                                            false));
                                    setState(() {});
                                  }
                                : null,
                            icon: Icons.add,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          CustomIconButton(
                            onPressed: _questionAndAnswerRows.length >
                                    minNumberOfAnswers + 1
                                ? () {
                                    _questionAndAnswerRows.removeLast();
                                    _questionAndAnswerControllers.removeLast();
                                    addQuestionNotifier.removeLastAnswer();
                                    setState(() {});
                                  }
                                : null,
                            icon: Icons.remove,
                          ),
                        ],
                      ),
                      const Gap(
                        showDivider: true,
                      ),
                      CustomTextField(
                        padding: 0.0,
                        controller: _explanationController,
                        label:
                            'Type an explanation to the answer (optional)...',
                      ),
                      const Gap(
                        showDivider: true,
                      ),
                      const AddQuestionDropdowns(),
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      CustomBigButton(
                        text: 'Add Question',
                        onPressed: addQuestionState.allFieldsAreValidated
                            ? () async {
                                final course = addQuestionState.course;
                                final type = addQuestionState.questionType;
                                final question =
                                    _questionAndAnswerControllers[0].text;
                                List<AnswerModel> answers = [];
                                for (int i = 1;
                                    i < _questionAndAnswerControllers.length;
                                    i++) {
                                  answers.add(AnswerModel(
                                      _questionAndAnswerControllers[i].text,
                                      isCorrect: i == 1));
                                }
                                final explanation = _explanationController.text;
                                final unit = addQuestionState.unit;
                                final subunit = addQuestionState.subunit;
                                final q = const QuestionModel().copyWith(
                                  course: course,
                                  type: type,
                                  question: question,
                                  answers: answers,
                                  explanation: explanation,
                                  unit: unit,
                                  subunit: Unit().copyWith(
                                      name: subunit.name,
                                      index: '${unit.index}.${subunit.index}'),
                                );

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BuilderHelper(
                                        future:
                                            sendQuestionToFirebase(question: q),
                                        loadingText:
                                            'Adding question...please wait a moment',
                                        onButtonPressed: {
                                          'Add another question': () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddQuestionPage(),
                                              ),
                                            );
                                          },
                                          'Close': () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage(),
                                              ),
                                            );
                                          },
                                        }),
                                  ),
                                );
                              }
                            : null,
                      ),
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

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
