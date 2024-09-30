import 'package:economics_app/app/animation/rotate_around_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../app/configs/constants.dart';

class ExplanationBox extends StatelessWidget {
  const ExplanationBox({
    super.key,
    required this.explanation,
  });

  final String explanation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RotateAroundAnimation(
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
                          Icons
                              .info_outline, // You can replace this with any appropriate icon
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

                    // text: , // Explanation text
                    // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //       color: Theme.of(context).colorScheme.primary,
                    //     ),
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
