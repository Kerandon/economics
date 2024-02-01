import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'article_page.dart';
import '../../custom_widgets/custom_loading_screen.dart';

class SubtopicsPage extends ConsumerStatefulWidget {
  const SubtopicsPage(this.mainTopic, {super.key});

  final TopicModel mainTopic;

  @override
  ConsumerState<SubtopicsPage> createState() => _SubtopicsPageState();
}

class _SubtopicsPageState extends ConsumerState<SubtopicsPage> {
  late final Future<List<TopicModel>> subtopicsFuture;
  @override
  void initState() {
    subtopicsFuture = getData('contents/${widget.mainTopic.title}/Subtopics/',
        parent: widget.mainTopic.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mainTopic.title!),
      ),
      body: FutureBuilder<List<TopicModel>>(
          future: subtopicsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final subtopics = snapshot.data;

              return SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: subtopics!.map((e) {
                    final articlesFuture = getData(
                        'contents/${widget.mainTopic.title}/Subtopics/${e.title}/Articles',
                        parent: e.title,
                        grandparent: widget.mainTopic.title);

                    return ExpandablePanel(
                      header: Text(e.title!), // Add your header widget here
                      collapsed: const SizedBox.shrink(),
                      expanded: FutureBuilder(
                          future: articlesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final articles = snapshot.data;
                              return ListView(
                                shrinkWrap: true,
                                children: articles!
                                    .map((e) => ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticlePage(
                                                  article: e,
                                                ),
                                              ),
                                            );
                                          },
                                          title: Text(e.title!),
                                        ))
                                    .toList(),
                              );
                            } else {
                              return const CustomProgressIndicator();
                            }
                          }),
                    );
                  }).toList(),
                ),
              );
            }
            return const CustomProgressIndicator();
          }),
    );
  }
}
