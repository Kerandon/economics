import 'package:economics_app/app/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../quiz_models/question_model.dart';
import 'answer_tile.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({super.key, required this.index, required this.question});

  final int index;
  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final answers = question.answers;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
      SizedBox(
        width: size.width * 0.05,
        child: Text(
            (index + 1).toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
      ),
              Text(question.question,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
            ],
          ),
          const Divider(
            color: AppColors.defaultAppColor,),
          ...answers
              .map((answer) => AnswerTile(
                    answerIndex: answers.indexOf(answer),
                    answer: answer,
                    question: question,
                  ))
              .toList()
        ],
      ),
    );
  }
}
