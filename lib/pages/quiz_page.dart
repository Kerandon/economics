import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/custom_widgets/custom_loading_screen.dart';
import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../answer_tile.dart';
import '../utils/constants.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  late final Future<QuerySnapshot<Map<String, dynamic>>> _questionsFuture;
  List<QuestionModel> questions = [];
  bool _questionsAreSet = false;

  @override
  void initState() {
    _questionsFuture = getQuizQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: FutureBuilder(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  snapshot.data!.docs;

              for (var d in documents) {
                final questionModel = QuestionModel.fromMap(
                  MapEntry(
                    d.id,
                    d.data(),
                  ),
                );

                if (!questions.contains(questionModel)) {
                  questions.add(questionModel);
                }
              }

              if (!_questionsAreSet) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    quizNotifier.setCurrentQuestions(questions);
                    print('set current questions');
                    _questionsAreSet = true;
                  },
                );
              }

              int questionIndex = 0;

              if (questions.isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  children: quizState.currentQuestions.map((question) {
                    questionIndex++;
                    int answerIndex = 0;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(kRadius),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Text(
                                'Q${questionIndex.toString()}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              title: Text(
                                question.question,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            ...question.answers.map((answer) {
                              answerIndex++;
                              String answerNumerator =
                                  getAnswerIndex(answerIndex);
                              return AnswerTile(
                                  answerNumerator, question, answer);
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                              child: ElevatedButton(
                                  style: ElevatedButton .styleFrom(
                                    elevation:  0
                                  ),
                                  onPressed: (){
                                    quizNotifier.checkQuestion(question);
                                  }, child: Text('Check')),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                );

              }
            }
            return const CustomProgressIndicator();
          }),
    );
  }

  String getAnswerIndex(int index) {
    String letter = "";
    switch (index) {
      case 1:
        letter = 'a';
      case 2:
        letter = 'b';
      case 3:
        letter = 'c';
      case 4:
        letter = 'd';
    }
    return letter;
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getQuizQuestions() async {
  final document = FirebaseFirestore.instance.collection(kQuiz).get();
  return document;
}
