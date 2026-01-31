// A helper widget to build the individual cards
import 'package:economics_app/home_page/pages/topic_navigation_utils.dart';
import 'package:economics_app/home_page/pages/topic_details.dart';
import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

import 'home_page_web.dart';

Widget buildTopicCard(TopicDetails details, BuildContext context, Topic topic) {
  return Card(
    // ... styling properties ...
    child: InkWell(
      onTap: () {
        // THE NEW NAVIGATION LOGIC
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => topic.page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: details.color, width: 6)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: details.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(details.icon, color: details.color, size: 30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details.subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
