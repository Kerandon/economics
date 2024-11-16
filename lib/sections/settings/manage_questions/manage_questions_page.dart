import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_back_to_home_button.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/course_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/quiz_type_buttons.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/unit_dropdown_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../quizzes/methods/get_questions_data.dart';
import 'manage_questions_tile.dart';

class ManageQuestionsPage extends ConsumerStatefulWidget {
  const ManageQuestionsPage({super.key});

  @override
  ConsumerState<ManageQuestionsPage> createState() =>
      _ManageQuestionsPageState();
}

class _ManageQuestionsPageState extends ConsumerState<ManageQuestionsPage> {
  List<QuestionModel> questions = [];
  List<CourseMixin> courses = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitAndSubunitProvider = ref.watch(
      editQuestionProvider.select((state) => (state.unit, state.subunit)),
    );

    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage questions'),
        leading: const CustomBackIconButton(QuizHomePage()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddQuestionForm(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: FutureBuilder<List<QuestionModel>>(
            future: getQuestionsData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QuestionModel> questions = snapshot.data!.toList();
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  editNotifier.setAllQuestions(questions);
                });

                List<QuestionModel> filteredQuestions = questions.toList()..sort((a,b)=> a.question!.compareTo(b.question!));
                for (var q in questions) {
                  if (q.unit != unitAndSubunitProvider.$1) {
                    filteredQuestions.remove(q);
                  }
                  if (q.subunit != unitAndSubunitProvider.$2) {
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
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredQuestions.length,
                        itemBuilder: (context, index) {
                          final q = filteredQuestions[index];
                          return Column(
                            children: [
                              SizedBox(height: size.height * 0.01,),
                              ManageQuestionsTile(q: q),
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
            }),
      ),
    );
  }
}
