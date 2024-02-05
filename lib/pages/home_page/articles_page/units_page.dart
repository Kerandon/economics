import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/custom_widgets/images/display_image.dart';
import 'package:economics_app/models/article_model.dart';
import 'package:economics_app/models/topic_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../../utils/helper_methods/firebase_methods.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key, required this.topic});

  final TopicModel topic;

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  late final Future<List<ArticleModel>> _articlesFuture;

  @override
  void initState() {
    _articlesFuture = getArticlesData(widget.topic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Text(
            widget.topic.title!,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          FutureBuilder<List<ArticleModel>>(
              future: _articlesFuture,
              builder: (context, snapshot) {
                List<ArticleModel> articles = [];
                if (snapshot.hasData) {
                  articles = snapshot.data!.toList();

                  return ListView(
                      shrinkWrap: true,
                      children: articles
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpandablePanel(
                                    header: Text(
                                      e.heading!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    collapsed: const SizedBox.shrink(),
                                    expanded: ListView(
                                      shrinkWrap: true,
                                      children: e.paragraphs!
                                          .map((p) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (p.heading != null) ...[
                                                    Text(
                                                      p.heading!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                  ],
                                                  if (p.body != null) ...[
                                                    Text(
                                                      p.body!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    if (p.image != null) ...[
                                                      SizedBox(
                                                          width: 300,
                                                          height: 300,
                                                          child: DisplayImage(
                                                              p.image!))
                                                    ]
                                                  ],
                                                ],
                                              ))
                                          .toList(),
                                    )),
                              ))
                          .toList());
                }
                return const CustomProgressIndicator();
              })
        ],
      ),
    );
  }
}

Future<List<ArticleModel>> getArticlesData(TopicModel topic) async {
  /// Define a list of [ArticleModel]
  List<ArticleModel> articles = [];

  /// Get the [QuerySnapshot<Map<String, dynamic>>] from firebase
  final snapshot = await getRawCollectionData(
      '/$kSections/${topic.parent}/$kUnits/${topic.title}/$kArticles/');

  for (var a in snapshot!.docs) {
    articles
        .add(ArticleModel.fromMap(map: a.data(), index: int.tryParse(a.id)));
  }

  return articles;
}
