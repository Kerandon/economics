
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_enums/answer_stage.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';
import '../quiz_state/quiz_state.dart';

class GifPopup extends ConsumerStatefulWidget {
  const GifPopup({super.key});

  @override
  ConsumerState<GifPopup> createState() => _GifPopupState();
}
class _GifPopupState extends ConsumerState<GifPopup> {
  final Map<String, bool> _correctImages = {}, _incorrectImages = {};
  bool _imagesArePopulated = false;
  bool _popupHasRun = false;
  bool _showDialog = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);

    QuestionModel? c;

    if (quizState.selectedQuestions.isNotEmpty) {
      c = quizState.selectedQuestions[quizState.currentQuestionIndex];
    }

    if (!_imagesArePopulated) {
      _imagesArePopulated = true;

      // Initialize correct gifs
      for (var gif in quizState.gifs.correctGifs ?? []) {
        _correctImages[gif] = false;
      }

      // Initialize incorrect gifs
      for (var gif in quizState.gifs.incorrectGifs ?? []) {
        _incorrectImages[gif] = false;
      }
    }

    if (c != null) {
      if (c.answerStage == AnswerStage.notSelected ||
          c.answerStage == AnswerStage.selected) {
        _popupHasRun = false;
      }

      if (!_popupHasRun &&
          (c.answerStage == AnswerStage.correct ||
              c.answerStage == AnswerStage.incorrect)) {
        _popupHasRun = true;
        _showDialog = true;
        Future.delayed(const Duration(milliseconds: 5000), () {
          if (context.mounted) {
            _showDialog = false;
            setState(() {});
          }
        });
      }
    }

    return _showDialog
        ? Builder(
      builder: (context) {
        String? selectedGif;

        if (c?.answerStage == AnswerStage.correct) {
          // Reset all if all used
          if (_correctImages.values.every((v) => v)) {
            _correctImages.updateAll((key, _) => false);
          }

          final available =
          _correctImages.entries.where((e) => !e.value).toList();

          if (available.isNotEmpty) {
            final r = Random().nextInt(available.length);
            selectedGif = available[r].key;
            _correctImages[selectedGif] = true;
          }
        } else if (c?.answerStage == AnswerStage.incorrect) {
          if (_incorrectImages.values.every((v) => v)) {
            _incorrectImages.updateAll((key, _) => false);
          }

          final available =
          _incorrectImages.entries.where((e) => !e.value).toList();

          if (available.isNotEmpty) {
            final r = Random().nextInt(available.length);
            selectedGif = available[r].key;
            _incorrectImages[selectedGif] = true;
          }
        }

        return selectedGif != null
            ? Center(
          child: Container(
            width: size.height * 0.60,
            height: size.width * 0.80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(selectedGif),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
            : const SizedBox.shrink();
      },
    )
        : const SizedBox.shrink();
  }


}