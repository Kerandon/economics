import 'package:economics_app/sections/quizzes/quiz_sections/question_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/custom_widgets/custom_big_button.dart';
import '../quiz_models/question_model.dart';
import '../quiz_state/quiz_state.dart';
import 'methods/get_questions_from_firebase.dart';

class StartQuizWidget extends ConsumerStatefulWidget {
  const StartQuizWidget({
    super.key,
  });

  @override
  ConsumerState<StartQuizWidget> createState() => _StartQuizWidgetState();
}

class _StartQuizWidgetState extends ConsumerState<StartQuizWidget> {
  late final Future<List<QuestionModel>> _quizFuture;

  @override
  void initState() {
    _quizFuture = getQuestionsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final quizNotifier = ref.read(quizProvider.notifier);
    return CustomBigButton(
      text: 'Start Quiz!',
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FutureBuilder<List<QuestionModel>>(
                future: _quizFuture,
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                    List<QuestionModel> questions = snapshot.data!.toList();

                    WidgetsBinding.instance.addPostFrameCallback((t){
                      quizNotifier.setSelectedQuestions(questions);
                    });


                    return const QuestionPage();
                  }
                  return const Center(child: CircularProgressIndicator());


                }),
          ),
        );
      },
    );
  }
}
