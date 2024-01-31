import 'package:economics_app/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/quiz_state.dart';
import '../../utils/constants.dart';
import 'answer_tile.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({super.key, required this.index, required this.question});

  final int index;
  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.003;
    final widthPadding = size.width * 0.05;
    final quizNotifier = ref.read(quizProvider.notifier);
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
                'Q${index.toString()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              title: Text(
                question.question,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ...question.answers.map((answer) {
              answerIndex++;
              String answerNumerator = getAnswerIndex(answerIndex);
              return AnswerTile(answerNumerator, question, answer);
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  widthPadding, heightPadding, widthPadding, heightPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        quizNotifier.checkQuestion(question);
                      },
                      child: const Text('Check')),
                  Icon(
                    Icons.check_outlined,
                    size: size.width * 0.10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
