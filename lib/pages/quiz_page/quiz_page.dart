import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/custom_widgets/custom_loading_screen.dart';
import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/pages/quiz_page/question_tile.dart';
import 'package:economics_app/state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../configs/constants.dart';

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
    _questionsFuture = getQuizQuestions(tags: ['test']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

                    return QuestionTile(
                        index: questionIndex, question: question);
                  }).toList(),
                );
              }
            }
            return const CustomProgressIndicator();
          }),
    );
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getQuizQuestions({List<String>? tags}) async {
  Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(kQuiz);

  // Conditionally add the where clause only if tags is not null
  if (tags != null && tags.isNotEmpty) {
    query = query.where('tags', arrayContainsAny: tags);
  }

  final document = await query.get();
  return document;
}
