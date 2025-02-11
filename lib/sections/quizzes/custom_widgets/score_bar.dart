import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_state/quiz_state.dart';

class ScoreBar extends ConsumerWidget {
  const ScoreBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final theme = Theme.of(context);

    String score = "";
    if (quizState.quizIsCompleted) {
      score = 'Total score ${quizState.results.percentCorrect}';
    } else {
      score = 'Current score ${quizState.results.percentCorrect}';
    }

    return AutoSizeText(
      score,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
