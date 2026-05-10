import 'package:economics_app/home_page/pages/topic_details.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

TopicDetails getTopicDetails(Topic topic) {
  switch (topic) {
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
    case Topic.terms:
      return TopicDetails(
        "Economic Terms",
        "A glossary of all key terms",
        Icons.abc_outlined,
        Colors.purple,
      );
    case Topic.realWorldExamples:
      return TopicDetails(
        "Real World Examples",
        "A glossary of real world examples",
        Icons.local_shipping_outlined,
        Colors.red,
      );
  }
}
