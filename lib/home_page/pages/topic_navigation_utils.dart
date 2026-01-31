import 'package:economics_app/home_page/pages/home_page_web.dart';
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

      // As you build more pages, add them here:
      // case Topic.microNotes:
      //   return const MicroNotesPage();

      // Default fallback for pages you haven't built yet
      default:
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text("Coming Soon")),
        );
    }
  }
}
