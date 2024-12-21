import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/configs/constants.dart';
import '../../../../../app/custom_widgets/gap.dart';

class FlipCardTile extends ConsumerStatefulWidget {
  const FlipCardTile(this.question, {super.key});

  final QuestionModel question;

  @override
  ConsumerState<FlipCardTile> createState() => _FlipCardTileState();
}

class _FlipCardTileState extends ConsumerState<FlipCardTile> {
  bool _animateFlip = false;
  CardSide _cardSide = CardSide.front;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final widthPadding = size.width * kPageIndentHorizontal;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
        left: widthPadding,
        right: widthPadding,
      ),
      child: FlipAnimation(
        isAnimating: (animating) {
          if (animating) {
            _animateFlip = false;
            setState(() {});
          }
        },
        reverse: _cardSide == CardSide.back,
        animate: _animateFlip,
        animationHalfCompleted: (side) {
          _cardSide = side;
          setState(() {});
        },
        animationCompleted: (flipDirection) {},
        child: Container(
          width: size.width,
          height: size.height * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(15),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.02),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kRadius),
                              topRight: Radius.circular(kRadius))),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                widget.question.question!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              if (_cardSide == CardSide.back) ...[
                                Gap(
                                  showDivider: true,
                                ),
                                HtmlWidget(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(),
                                  widget.question.answers!.first.answer,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _animateFlip = true;

                      setState(() {});
                    },
                    icon: const Icon(Icons.flip_outlined))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
