import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_back_to_home_button.dart';
import 'package:economics_app/sections/diagrams/enums/diagrams_number.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/flip_card_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/multi_choice_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/add_question_page_2.dart';
import 'package:economics_app/sections/tab_main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../quizzes/custom_widgets/filter_button.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_enums/topic_tag.dart';

class ManageQuestionsPage extends ConsumerStatefulWidget {
  const ManageQuestionsPage({super.key});

  @override
  ConsumerState<ManageQuestionsPage> createState() =>
      _ManageQuestionsPageState();
}

class _ManageQuestionsPageState extends ConsumerState<ManageQuestionsPage> {
  List<QuestionModel> questions = [];
  List<CourseMixin> courses = [];
  late final _future = getQuestionsData();
  bool _dataIsSet = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackIconButton(TabBarMain()),
        title: Row(
          children: [
            Text('Manage questions'),
            const QuizFilterButton(
              showExtraButtons: false,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: FutureBuilder<List<QuestionModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QuestionModel> questions = snapshot.data!.toList();
              WidgetsBinding.instance.addPostFrameCallback((t) {
                if (!_dataIsSet) {
                  _dataIsSet = true;
                  editNotifier.setAllQuestions(questions);
                  editNotifier.setFilteredQuestions();
                  editNotifier.setDiagramsNumber(context, size,
                      diagramsNumber: DiagramsNumber.zero);
                }
              });

              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: editState.filteredQuestions.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final q = editState.filteredQuestions[index];
                    return GridTile(
                      child: q.topicTag == TopicTag.multipleChoiceQuestions
                          ? MultiChoiceTile(
                              q,
                              editMode: true,
                              mainAxisDivisor: 2.0,
                            )
                          : FlipCardTile(q),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_outlined),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddQuestionPage2(),
            ),
          );
        },
      ),
    );
  }
}
