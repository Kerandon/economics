import 'package:economics_app/home_page/pages/topic_enum.dart';
import 'package:flutter/material.dart';

import 'build_topic_card.dart';
import 'get_topic_details.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for contrast
      appBar: AppBar(
        title: const Text(
          'Economics Hub',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          // Placeholder for generic web actions (Profile, Search, etc.)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          // Prevent stretching on ultra-wide screens
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // A nice header section
                const Text(
                  "Welcome back",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  "Select a topic to review notes, diagrams, and practice questions.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),

                // The Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 280,
                          // Cards will be at most 280px wide
                          childAspectRatio: 1.1,
                          // Controls the square/rect shape
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                    itemCount: Topic.values.length,
                    itemBuilder: (context, index) {
                      final topic = Topic.values[index];
                      final details = getTopicDetails(topic);

                      return buildTopicCard(details, context, topic);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
