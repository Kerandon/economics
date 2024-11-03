import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_back_to_home_button.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/app/custom_widgets/custom_pop_up.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/course_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/quiz_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/unit_dropdown_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/methods/delete_question_from_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../quizzes/methods/get_questions_data.dart';


class ManageQuestionsPage extends ConsumerStatefulWidget {
  const ManageQuestionsPage({super.key});

  @override
  ConsumerState<ManageQuestionsPage> createState() =>
      _ManageQuestionsPageState();
}

class _ManageQuestionsPageState extends ConsumerState<ManageQuestionsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<QuestionModel> questions = [];
  List<CourseMixin> courses = [];

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage questions'),
        leading: CustomBackIconButton(Navigator.of(context).pop),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: FutureBuilder<List<QuestionModel>>(
          future: getQuestionsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QuestionModel> questions = snapshot.data!.toList();
              WidgetsBinding.instance.addPostFrameCallback((t){
                editNotifier.setAllQuestions(questions);
              });

              List<QuestionModel> filteredQuestions = questions.toList();
              print('selected subunit is ${editState.subunit.name}');
              for(var q in questions){
                if(q.unit != editState.unit){
                  filteredQuestions.remove(q);
                }
                if(q.subunit != editState.subunit){
                  filteredQuestions.remove(q);
                }
              }



              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(),
                    const QuizTypeButtons(),
                    const Gap(),
                    const CourseTypeButtons(),
                    const Gap(),
                    const UnitDropdownButtons(),
                    const Gap(),
                    const Gap(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredQuestions.length,
                      itemBuilder: (context, index) {
                        final q = filteredQuestions[index];
                        return Column(
                          children: [
                            ListTile(
                              titleAlignment: ListTileTitleAlignment.top,
                              trailing: ConstrainedBox(
                                constraints:
                                BoxConstraints(maxWidth: size.width * 0.20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          deleteQuestion(context, q);
                                        },
                                        icon: const Icon(Icons.delete_outlined)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit_outlined)),
                                  ],
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${q.unit?.name}: ${q.subunit?.name}',
                                  ),
                                  Text(
                                    q.question ?? "question blank",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  ...q.answers!.map(
                                        (e) {
                                      return Row(
                                        children: [
                                          const Text(
                                            'A',
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.01),
                                            child: Text(
                                              e.answer,
                                            ),
                                          ),
                                          if (e.isCorrect) ...[
                                            const Icon(Icons.check_circle_outline)
                                          ],
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const CustomDivider(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  void deleteQuestion(BuildContext context, QuestionModel q) {
        showDialog(
        context: context,
        builder: (context) => CustomPopup(
                actionButtons: [
                  CustomChipButton(
                    text: 'Confirm',
                      onPressed: () {

                            deleteQuestionFromFirebase(q.id!);
                  }),
                  CustomChipButton(
                      text: 'Cancel',
                      onPressed: () {
                    Navigator.of(context).pop();
                  }),
                ],
                title:
                    'Are you sure you want to delete question: ${q.question} ?'));
  }
}
