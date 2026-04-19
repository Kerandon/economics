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
        leading: SizedBox(),
        toolbarHeight: 150,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
