import 'package:flutter/material.dart';

enum CustomIcon { notes, diagrams, quiz, construction }

Icon getCustomIcon(CustomIcon page) {
  switch (page) {
    case CustomIcon.notes:
      return const Icon(Icons.notes_outlined);
    case CustomIcon.diagrams:
      return const Icon(Icons.ssid_chart_outlined);
    case CustomIcon.quiz:
      return const Icon(Icons.question_answer_outlined);
    case CustomIcon.construction:
      return const Icon(Icons.construction_outlined);
  }
}
