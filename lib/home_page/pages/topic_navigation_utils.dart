import 'package:economics_app/home_page/pages/home_page_web.dart';
import 'package:economics_app/home_page/pages/notes_page/notes_page.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_one_questions_page.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

import 'diagrams_page/diagrams_page.dart';

// Assuming your DiagramsPage is imported here
// import 'pages/diagrams_page.dart';

extension TopicNavigation on Topic {
  // This returns the specific Widget page for each topic
  Widget get page {
    switch (this) {
      case Topic.allDiagrams:
        return const DiagramsPage();
      case Topic.notes:
        return const NotesPage();
      case Topic.paper1Questions:
        return const PaperOneQuestionsPage();
    }
  }
}
