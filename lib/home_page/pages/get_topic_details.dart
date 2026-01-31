import 'package:economics_app/home_page/pages/topic_details.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

TopicDetails getTopicDetails(Topic topic) {
  switch (topic) {
    case Topic.introNotes:
      return TopicDetails(
        "Introduction",
        "Foundations of Scarcity & Choice",
        Icons.lightbulb_outline,
        Colors.blue,
      );
    case Topic.microNotes:
      return TopicDetails(
        "Microeconomics",
        "Supply, Demand & Market Failure",
        Icons.storefront,
        Colors.indigo,
      );
    case Topic.macroNotes:
      return TopicDetails(
        "Macroeconomics",
        "Inflation, GDP & Policy",
        Icons.public,
        Colors.teal,
      );
    case Topic.globalNotes:
      return TopicDetails(
        "Global Economy",
        "Trade, Exchange Rates & Development",
        Icons.language,
        Colors.deepPurple,
      );
    case Topic.allDiagrams:
      return TopicDetails(
        "Diagram Library",
        "Interactive Economic Models",
        Icons.show_chart,
        Colors.orange,
      );
    case Topic.paper1Questions:
      return TopicDetails(
        "Paper 1 Practice",
        "Essay Questions & Evaluation",
        Icons.edit_note,
        Colors.redAccent,
      );
    case Topic.paper3Questions:
      return TopicDetails(
        "Paper 3 Practice",
        "Policy & Quantitative Questions",
        Icons.calculate,
        Colors.green,
      );
    case Topic.terms:
      return TopicDetails(
        "Key Terms",
        "Definitions & Glossary",
        Icons.menu_book,
        Colors.brown,
      );
  }
}
