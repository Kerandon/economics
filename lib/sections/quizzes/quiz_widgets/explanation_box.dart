
import 'package:flutter/material.dart';

import '../../../app/configs/constants.dart';
import '../quiz_models/question_model.dart';

class ExplanationBox extends StatelessWidget {
  const ExplanationBox({
    super.key,
    required this.question,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * kPageIndentVertical),
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius),
            border: Border.all(color: Theme.of(context).colorScheme.primary,

            ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.height * kPageIndentVertical),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.info_outline, // You can replace this with any appropriate icon
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextSpan(
                  text: "Explanation\n", // Title text
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextSpan(
                  text: question.explanation, // Explanation text
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),


        ),
      ),
    );
  }
}
