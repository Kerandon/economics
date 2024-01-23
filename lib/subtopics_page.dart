import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/state/app_state.dart';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_loading_screen.dart';

class SubtopicsPage extends ConsumerStatefulWidget {
  const SubtopicsPage(this.mainTopic, {super.key});

  final TopicModel mainTopic;

  @override
  ConsumerState<SubtopicsPage> createState() => _SubtopicsPageState();
}

class _SubtopicsPageState extends ConsumerState<SubtopicsPage> {
  late final Future<List<TopicModel>> subTopicsFuture;

  @override
  void initState() {
    subTopicsFuture = getData('contents/${widget.mainTopic.title}/Subtopics/',
        parent: widget.mainTopic.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mainTopic.title!),
      ),
      body: FutureBuilder<List<TopicModel>>(
          future: subTopicsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final subtopics = snapshot.data;

              for (var d in subtopics!) {
                print('got subtopics ${d.title} and parent ${d.parent}');
              }
              return SingleChildScrollView(
                child: ExpansionPanelList(
                    children: subtopics
                        .map((e) => ExpansionPanel(
                            isExpanded: true,
                            headerBuilder: (context, isExpanded) => ListTile(
                                  title: Text(e.title!),
                                ),
                            body: FutureBuilder<List<TopicModel>>(
                                future: getData(
                                    '/contents/${widget.mainTopic.title}/Subtopics/${e.title}/Articles'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print('got data');
                                    return ListView(
                                      shrinkWrap: true,
                                      children: snapshot.data!
                                          .map((e) => ListTile(
                                                title: Text(e.title!),
                                              ))
                                          .toList(),
                                    );
                                  }
                                  return Container();
                                })))
                        .toList()),
              );
            }
            return CustomLoadingScreen();
          }),
    );
  }
}
