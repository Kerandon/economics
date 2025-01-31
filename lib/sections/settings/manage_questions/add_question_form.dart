import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/diagrams/enums/diagrams_number.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/course_type_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_back_to_home_button.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../diagrams/diagram_widgets/diagram_builder.dart';
import '../../quizzes/custom_widgets/custom_tags_buttons.dart';
import '../../quizzes/custom_widgets/flip_card_tags_buttons.dart';
import '../../quizzes/custom_widgets/unit_drop_down.dart';

import '../../quizzes/quiz_enums/flip_card_tag.dart';
import 'custom_form_builder_text_field.dart';
import 'diagram_dropdowns/number_of_diagrams_dropdown.dart';
import 'methods/prepare_new_question_for_firebase.dart';
import 'methods/prepare_update_question_for_firebase.dart';

class AddQuestionForm extends ConsumerStatefulWidget {
  const AddQuestionForm({this.question, super.key});

  final QuestionModel? question;

  @override
  ConsumerState<AddQuestionForm> createState() => _EditQuestionsPageState();
}

class _EditQuestionsPageState extends ConsumerState<AddQuestionForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _setUpForQuestionEdit = false;
  bool _courseAndUnitsAreEqual = true;
  bool _questionsAndAnswersAreEqual = true;

  List<CourseMixin> courses = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    String title = '';

    title = 'Add ${editState.questionType.toText().toLowerCase()} question';

    if (widget.question != null) {
      title = 'Edit ${editState.questionType.toText().toLowerCase()} question';

      if (!_setUpForQuestionEdit) {
        _setUpForQuestionEdit = true;
        final questionModel = widget.question;

        final answers = questionModel!.answers;
        AnswerModel? correctAnswer;
        List<AnswerModel> incorrectAnswers = [];
        for (var a in answers!) {
          if (a.isCorrect) {
            correctAnswer = a;
          } else {
            incorrectAnswers.add(a);
          }
        }

        final explanation = questionModel.explanation ?? "";
        WidgetsBinding.instance.addPostFrameCallback(
          (t) {
            if (questionModel.diagrams != null &&
                questionModel.diagrams!.isNotEmpty) {
              editNotifier.setDiagramsNumber(context, size,
                  diagramsNumber:
                      questionModel.diagrams!.length.toDiagramsNumber);
              for (int i = 0; i < questionModel.diagrams!.length; i++) {
                editNotifier.setDiagramsSelected(questionModel.diagrams![i], i);
              }
            }

            final fields = _formKey.currentState!.fields;
            fields[kQuestion]!.didChange(questionModel.question ?? "");
            fields[kCorrectAnswer]!.didChange(correctAnswer?.answer ?? "");
            if (questionModel.questionType == QuestionType.multi) {
              fields[kIncorrectAnswer1]!.didChange(incorrectAnswers[0].answer);
              fields[kIncorrectAnswer2]!.didChange(incorrectAnswers[1].answer);
              fields[kIncorrectAnswer3]!.didChange(incorrectAnswers[2].answer);
              fields[kExplanation]!.didChange(explanation);
            }
          },
        );

        _courseAndUnitsAreEqual = editState.course == widget.question?.course &&
            editState.unit == widget.question?.unit &&
            editState.subunit == widget.question?.subunit;

        if (widget.question!.diagrams != null) {
          if (widget.question!.diagrams!.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((t) {
              for (int i = 0; i < widget.question!.diagrams!.length; i++) {
                editNotifier.setDiagramsSelected(
                    widget.question!.diagrams![i], i);
              }
            });
          }
        }
      }
    }

    bool disableButton = true;
    if (widget.question != null) {
      if (_formKey.currentState?.isValid == true &&
              !_questionsAndAnswersAreEqual ||
          !_courseAndUnitsAreEqual) {
        disableButton = false;
      }
    } else {
      if (_formKey.currentState?.isValid == true) {
        disableButton = false;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: const CustomBackIconButton(
          ManageQuestionsPage(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(),
              FormBuilder(
                onChanged: () {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    if (widget.question != null) {
                      final answers = getQuestionAndAnswersAndExplanation(
                          _formKey, editState);
                      _questionsAndAnswersAreEqual =
                          questionsAndAnswersAreEqual(
                              question: widget.question, newAnswers: answers);
                    }
                    setState(() {});
                  });
                },
                key: _formKey,
                child: Column(
                  children: [
                    const CourseTypeButtons(),
                    const FlipCardTagsButtons(),
                    const UnitDropDown(
                      alwaysShowAllUnits: true,
                    ),
                    const CustomFormBuilderTextField(kQuestion),
                    const CustomFormBuilderTextField(kCorrectAnswer),
                    if (editState.flipCardTag.toQuestionType() ==
                        QuestionType.multi) ...[
                      const CustomFormBuilderTextField(kIncorrectAnswer1),
                      const CustomFormBuilderTextField(kIncorrectAnswer2),
                      const CustomFormBuilderTextField(kIncorrectAnswer3),
                      const CustomFormBuilderTextField(
                        kExplanation,
                        validationRequired: false,
                      ),
                    ],
                    DiagramBuilder(
                        canScroll: false,
                        selectedDiagrams: editState.selectedDiagrams.toList()),
                    const NumberOfDiagramsDropdown(),
                    CustomTagsButtons(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  bottom: size.height * kBottomIndent,
                ),
                child: SizedBox(
                  width: size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: size.width * kWrapSpacing,
                    children: [
                      CustomChipButton(
                        isDisabled: disableButton,
                        onPressed: () {
                          final hasDuplicates =
                              getQuestionAndAnswersAndExplanation(
                                      _formKey, editState)
                                  .hasDuplicates();

                          final fields = _formKey.currentState?.fields;
                          bool questionAlreadyExists = false;
                          if (widget.question == null) {
                            questionAlreadyExists = editState.allQuestions.any(
                              (q) => q.question == fields![kQuestion]!.value,
                            );
                          }

                          String errorText = '';
                          if (hasDuplicates && questionAlreadyExists) {
                            errorText =
                                'Error - duplicate answers & question already exists';
                          } else if (hasDuplicates) {
                            errorText = 'Error - duplicate answers';
                          } else if (questionAlreadyExists) {
                            errorText = 'Error - Question already exists';
                          }

                          if (hasDuplicates || questionAlreadyExists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorText),
                              ),
                            );
                          } else {
                            if (widget.question != null) {
                              prepareUpdateQuestionForFirebase(
                                context: context,
                                originalQuestion: widget.question!,
                                formKey: _formKey,
                                editState: editState,
                              );
                            } else {
                              prepareNewQuestionForFirebase(
                                context: context,
                                formKey: _formKey,
                                editState: editState,
                              );
                            }
                          }
                        },
                        text: 'Confirm',
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _formKey.currentState?.reset();
                          });
                        },
                        icon: const Icon(Icons.refresh_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> getQuestionAndAnswersAndExplanation(
    GlobalKey<FormBuilderState> formKey, EditQuestionState editState) {
  List<String> questionsAndAnswers = [];
  if (formKey.currentState?.fields != null) {
    final fields = formKey.currentState!.fields;
    questionsAndAnswers.add(fields[kQuestion]!.value);
    questionsAndAnswers.add(fields[kCorrectAnswer]!.value);
    if (editState.questionType == QuestionType.multi) {
      questionsAndAnswers.add(fields[kIncorrectAnswer1]!.value);
      questionsAndAnswers.add(fields[kIncorrectAnswer2]!.value);
      questionsAndAnswers.add(fields[kIncorrectAnswer3]!.value);
      questionsAndAnswers.add(fields[kExplanation]?.value ?? "");
    }
  }

  return questionsAndAnswers;
}

bool questionsAndAnswersAreEqual({
  required QuestionModel? question,
  required List<String> newAnswers,
}) {
  if (question != null) {
    List<String> originalQuestionsAndAnswersAndExplanation = [];
    originalQuestionsAndAnswersAndExplanation.add(question.question!);
    for (var a in question.answers!) {
      originalQuestionsAndAnswersAndExplanation.add(a.answer);
    }
    originalQuestionsAndAnswersAndExplanation.add(question.explanation ?? "");

    return const ListEquality()
        .equals(originalQuestionsAndAnswersAndExplanation, newAnswers);
  }
  return false;
}
