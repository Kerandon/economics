import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/custom_widgets/images/display_image.dart';
import 'package:economics_app/custom_widgets/loading_error/custom_error_widget.dart';
import 'package:economics_app/custom_widgets/tiles/custom_banner.dart';
import 'package:economics_app/custom_widgets/tiles/custom_title_tile.dart';
import 'package:economics_app/models/article_model.dart';
import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/utils/helper_methods/string_extensions.dart';

import 'package:flutter/material.dart';

import '../../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../../utils/helper_methods/firebase_methods.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key, required this.topic});

  final TopicModel topic;

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late final Future<List<ArticleModel>?> _articlesFuture;

  @override
  void initState() {
    _articlesFuture = getArticlesData(widget.topic);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textBlockPadding = EdgeInsets.symmetric(vertical: size.height * 0.015);
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
      ),
      body: SingleChildScrollView(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            CustomBanner(
                '${widget.topic.unit} ${widget.topic.title!.capitalizeFirstLetter()}'),
            FutureBuilder<List<ArticleModel>?>(
                future: _articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CustomErrorWidget();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<ArticleModel> articles = [];
                      articles = snapshot.data!.toList();

                      return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: articles
                              .map((e) => ExpansionTile(
                                      title: CustomTitleTile(e.heading),
                                      children: [
                                        ...e.paragraphs!
                                            .map(
                                              (p) => Padding(
                                                padding: EdgeInsets.symmetric(horizontal: size.width * kPageIndent),
                                                child: Column(
                                                  children: [
                                                    if (p.heading != null) ...[
                                                      Padding(
                                                        padding: textBlockPadding,
                                                        child: Text(
                                                          p.heading!,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        ),
                                                      ),
                                                    ],
                                                    if (p.body != null) ...[
                                                      Padding(
                                                        padding: textBlockPadding,
                                                        child: Text(
                                                          p.body!,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge,
                                                        ),
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
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ]))
                              .toList());
                    } else {
                      return const CustomErrorWidget();
                    }
                  }
                  return const CustomProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
