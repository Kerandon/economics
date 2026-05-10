import 'package:economics_app/home_page/pages/home_page_web.dart';
import 'package:economics_app/home_page/pages/notes_page/notes_page.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_one_questions_page.dart';
import 'package:economics_app/home_page/pages/quick_notes/master_slide_list.dart';
import 'package:economics_app/home_page/pages/quick_notes/quick_notes.dart';
import 'package:economics_app/home_page/pages/terms/terms_page.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

import 'diagrams_page/diagrams_page.dart';

extension TopicNavigation on Topic {
  Widget get page {
    switch (this) {
      case Topic.allDiagrams:
        return const DiagramsPage();
      case Topic.paper1Questions:
        return const PaperOneQuestionsPage();
      case Topic.quickNotes:
        return const QuickNotesPage();
      case Topic.terms:
        return TermsPage();
      case Topic.realWorldExamples:
        return TermsPage();
    }
  }
}
