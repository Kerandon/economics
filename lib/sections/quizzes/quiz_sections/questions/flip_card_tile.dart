import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/app/audio_manager/audio_manager.dart';
import 'package:economics_app/sections/diagrams/diagram_widgets/custom_diagram_builder.dart';
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../main.dart';

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
    final theme = Theme.of(context);

    final quizNotifier = ref.watch(quizProvider.notifier);
    final a = widget.question.answers!.first;
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
      animationCompleted: (flipDirection) {
        if (widget.question.answerStage != AnswerStage.incorrect) {
          quizNotifier.updateQuestion(
              widget.question.copyWith(answerStage: AnswerStage.correct));
        }
      },
      child: Stack(
        children: [
          Container(
            width: size.width * 0.90,
            height: size.height * 0.75,
            decoration: getTileDecoration(context),
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
                            topRight: Radius.circular(kRadius),
                          ),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.redAccent,
                                  child: HtmlWidget(
                                    customStylesBuilder: (element) {
                                      return {'text-align': 'center'};
                                    },
                                    widget.question.question!,
                                    textStyle: _cardSide == CardSide.back
                                        ? theme.textTheme.titleLarge?.copyWith(
                                          )
                                        : theme.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                  ),
                                ),
                                Row(children: [
                                  if (_cardSide == CardSide.back) ...[
                                    if (widget.question.answers!.isNotEmpty) ...[
                                      Expanded(
                                        child: HtmlWidget(
                                          customStylesBuilder: (element) {
                                            return {'text-align': 'center'};
                                          },
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(),
                                          a.answer,
                                        ),
                                      ),
                                    ],
                                    if (a.diagrams != null &&
                                        a.diagrams!.isNotEmpty) ...[
                                      CustomDiagramBuilder(diagrams: a.diagrams?.toList())
                                    ],
                                  ],

                                ],)

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
                      getIt<AudioManager>().playSound('other/select'); // Retrieve instance
                      setState(() {});
                    },
                    icon: const Icon(Icons.flip_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
