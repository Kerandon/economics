import 'package:economics_app/app/animation/rotate_around_animation.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';

class ExplanationBox extends ConsumerWidget {
  const ExplanationBox({
    super.key,
    required this.explanation,
  });

  final String explanation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    return RotateAroundAnimation(
      disable: quizState.quizIsCompleted,
      beginValue: 0.50,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.height * kPageIndentVertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.info_outline,
                          // You can replace this with any appropriate icon
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
                    WidgetSpan(
                        child: SizedBox(
                      height: size.height * 0.01,
                    )),
                  ],
                ),
              ),
              HtmlWidget(
                explanation,
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
