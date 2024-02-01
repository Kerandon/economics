import 'package:economics_app/custom_widgets/custom_loading_screen.dart';
import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/enums/firebase_type_enum.dart';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../custom_widgets/display_image.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, required this.article});

  final TopicModel article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late final Future<List<TopicModel>> articleFuture;

  @override
  void initState() {
    articleFuture = getData(
        '/contents/${widget.article.grandparent}/Subtopics/'
        '${widget.article.parent}/Articles/${widget.article.title}',
        firebaseType: FirebaseType.document);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title!),
      ),
      body: FutureBuilder(
        future: articleFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final topic = snapshot.data;

            final content = topic?.elementAt(0).content;

            return Container(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(size.width * kPageIndent),
                child: ListView(
                  children: content!
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (e.title != null) ...[
                                Text(
                                  e.title!,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                              if (e.heading != null) ...[
                                Text(
                                  e.heading!,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                              if (e.image != null) ...[DisplayImage(e.image!)],
                              if (e.body != null) ...[
                                Markdown(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    data: e.body!)
                              ],
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
          } else {
            return const CustomProgressIndicator();
          }
        },
      ),
    );
  }
}
