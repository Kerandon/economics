import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/diagrams/diagram_widgets/diagram_builder.dart';
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import 'edit_question_button.dart';

class FlipCardTile extends ConsumerStatefulWidget {
  const FlipCardTile(this.question, {this.editMode = false, super.key});

  final QuestionModel question;
  final bool editMode;

  @override
  ConsumerState<FlipCardTile> createState() => _FlipCardTileState();
}

class _FlipCardTileState extends ConsumerState<FlipCardTile> {
  bool _animateFlip = false;
  CardSide _cardSide = CardSide.front;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final quizNotifier = ref.watch(quizProvider.notifier);
    return FlipAnimation(
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
        quizNotifier.setCardSide(side);
        setState(() {});
      },
      animationCompleted: (flipDirection) {},
      child: Container(
        width: size.width,
        height: size.height * 0.75,
        decoration: getTileDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.editMode) ...[
                EditQuestionButton(
                  question: widget.question,
                ),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kRadius),
                        topRight: Radius.circular(kRadius),
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            HtmlWidget(
                              widget.question.question!,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (_cardSide == CardSide.back) ...[
                              CustomDivider(),
                              if (widget.question.answers!.isNotEmpty) ...[
                                HtmlWidget(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(),
                                  widget.question.answers!.first.answer,
                                ),
                              ],
                              if (widget.question.diagrams != null &&
                                  widget.question.diagrams!.isNotEmpty) ...[
                                DiagramBuilder(
                                  canScroll: false,
                                ),
                              ],
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
                icon: const Icon(Icons.flip_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
