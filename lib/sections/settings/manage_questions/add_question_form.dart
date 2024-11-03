import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_back_to_home_button.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';

import '../../quizzes/custom_widgets/unit_dropdown_buttons.dart';
import '../../quizzes/methods/get_course_data.dart';

import 'methods/validate_and_save_to_question_model.dart';

class AddQuestionForm extends ConsumerStatefulWidget {
  const AddQuestionForm({super.key});

  @override
  ConsumerState<AddQuestionForm> createState() => _EditQuestionsPageState();
}

class _EditQuestionsPageState extends ConsumerState<AddQuestionForm> {
  late final Future<QuerySnapshot<Map<String, dynamic>>?> _courseDataFuture;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _setUpStateOnInit = false;
  List<CourseMixin> courses = [];

  @override
  void initState() {
    _courseDataFuture = getCourseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackIconButton(Navigator.of(context).pop),
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
                  courses.add(
                    Course.fromMap({
                      e.id: e.data(),
                    }),
                  );
                }

                if (editState.course.name == "") {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    editNotifier.setCourse(courses.first);
                  });
                }
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * kPageIndentHorizontal),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(),
                      const Text('Add question'),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              decoration: const InputDecoration(
                                  label: Text(kExplanation)),
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
                        child: Wrap(
                          spacing: size.width * kWrapSpacing,
                          children: [
                            CustomChipButton(
                              onPressed: () {
                                validateAndSaveToQuestionModel(
                                    context: context,
                                    formKey: _formKey,
                                    editState: editState);
                              },
                              text: 'Confirm',
                            ),
                            CustomChipButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                              },
                              text: 'Clear fields',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        decoration: InputDecoration(
          label: Text(text),
        ),
        name: text);
  }
}
