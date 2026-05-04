import 'package:economics_app/home_page/pages/topic_details.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

TopicDetails getTopicDetails(Topic topic) {
  switch (topic) {
    case Topic.notes:
      return TopicDetails(
        "IB Notes",
        "Curated Notes Based On The IB Syllabus",
        Icons.lightbulb_outline,
        Colors.blue,
      );

    case Topic.allDiagrams:
      return TopicDetails(
        "Diagram Library",
        "All The IB Diagrams You Need To Know",
        Icons.show_chart,
        Colors.orange,
      );
    case Topic.paper1Questions:
      return TopicDetails(
        "Paper One Questions",
        "Suggested Answers",
        Icons.question_answer_outlined,
        Colors.green,
      );
    case Topic.quickNotes:
      return TopicDetails(
        "Quick Notes",
        "Last Minute Revision",
        Icons.note_alt_sharp,
        Colors.orange,
      );
  }
}
