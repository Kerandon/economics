import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/settings/manage_questions/methods/prepare_update_question_for_firebase.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_back_to_home_button.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../quizzes/custom_widgets/unit_dropdown_buttons.dart';
import 'custom_form_builder_text_field.dart';
import 'methods/prepare_new_question_for_firebase.dart';

class AddQuestionForm extends ConsumerStatefulWidget {
  const AddQuestionForm({this.question, super.key});

  final QuestionModel? question;

  @override
  ConsumerState<AddQuestionForm> createState() => _EditQuestionsPageState();
}

class _EditQuestionsPageState extends ConsumerState<AddQuestionForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _setUpForQuestionEdit = false;
  bool _userHasInteracted = false;
  List<CourseMixin> courses = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    String title = 'Add question';
    if (widget.question != null) {
      title = 'Edit question';

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
        WidgetsBinding.instance.addPostFrameCallback((t) {
          final fields = _formKey.currentState!.fields;

          fields[kQuestion]!.didChange(questionModel.question ?? "");
          fields[kCorrectAnswer]!.didChange(correctAnswer?.answer ?? "");
          fields[kIncorrectAnswer1]!.didChange(incorrectAnswers[0].answer);
          fields[kIncorrectAnswer2]!.didChange(incorrectAnswers[1].answer);
          fields[kIncorrectAnswer3]!.didChange(incorrectAnswers[2].answer);
          fields[kExplanation]!.didChange(explanation);
        });
      }
    }
    if (_userHasInteracted) {
      _formKey.currentState?.validate() ?? false;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          leading: const CustomBackIconButton(ManageQuestionsPage())),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(),
              Wrap(
                spacing: 20,
                children: courses.map((c) {
                  return CustomChipButton(
                    isSelected: c == editState.course,
                    onPressed: () {
                      editNotifier.setCourse(c);
                    },
                    text: c.name,
                  );
                }).toList(),
              ),
              const Gap(),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const UnitDropdownButtons(),
                    const Column(
                      children: [
                        CustomFormBuilderTextField(kQuestion),
                        CustomFormBuilderTextField(kCorrectAnswer),
                        CustomFormBuilderTextField(kIncorrectAnswer1),
                        CustomFormBuilderTextField(kIncorrectAnswer2),
                        CustomFormBuilderTextField(kIncorrectAnswer3),
                      ],
                    ),
                    FormBuilderTextField(
                      decoration:
                          const InputDecoration(label: Text(kExplanation)),
                      name: kExplanation,
                    ),
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
                        onPressed: () {
                          _userHasInteracted = true;
                          if (_formKey.currentState!.isValid) {
                            if (widget.question != null) {
                              prepareUpdateQuestionForFirebase(
                                  context: context,
                                  originalQuestion: widget.question!,
                                  formKey: _formKey,
                                  editState: editState);
                            } else {
                              prepareNewQuestionForFirebase(
                                  context: context,
                                  formKey: _formKey,
                                  editState: editState);
                            }
                          }

                          setState(() {});
                        },
                        text: 'Confirm',
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _formKey.currentState?.reset();
                            _userHasInteracted = false;
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

Future updateQuestion() async {
  try {
    final ref = FirebaseFirestore.instance;
    ref.collection(kQuiz).doc();
  } catch (e) {
    throw Exception('Error $e');
  }
}
