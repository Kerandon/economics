import 'package:economics_app/custom_widgets/custom_table/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/custom_widgets/loading_error/custom_error_widget.dart';
import 'package:economics_app/models/article_model.dart';
import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import '../../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../../utils/helper_methods/firebase_methods.dart';
import '../../configs/app_colors.dart';
import '../../custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';
import 'article_layout.dart';
import '../../custom_widgets/tiles/custom_expansion_table.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({Key? key, required this.topic}) : super(key: key);

  final TopicModel topic;

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  final List<ExpansionTileController> _expansionControllers = [];
  late final Future<List<ArticleModel>?> _articlesFuture;
  late final Future<Map<String, String>?> _imagesFuture;

  @override
  void initState() {
    _articlesFuture = getArticlesData(widget.topic);
    _imagesFuture = getImageURLs(widget.topic.unit.toString());

    if (widget.topic.terms != null && widget.topic.terms!.isNotEmpty) {
      _expansionControllers.add(ExpansionTileController());
    }
    if (widget.topic.summary != null && widget.topic.summary!.isNotEmpty) {
      _expansionControllers.add(ExpansionTileController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: AppColors.defaultAppColorDarker,
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                actions: [
                  CustomButtonOverlayAppBar(
                      title:
                          '${widget.topic.unit.toString()} ${(widget.topic.title!).capitalizeFirstLetter()}',
                      expansionControllers: _expansionControllers),
                ]),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.topic.summary != null &&
                  widget.topic.summary!.isNotEmpty) ...[
                CustomExpansionTile(
                    title: 'Learning objectives',
                    expansionController: _expansionControllers[0],
                    child: CustomTable(
                      widget.topic.summary!.toMap(),
                      useBulletPoints: true,
                    ))
              ],
              if (widget.topic.terms != null &&
                  widget.topic.terms!.isNotEmpty) ...[
                CustomExpansionTile(
                  title: 'Key terms',
                  expansionController: _expansionControllers[1],
                  child: CustomTable(widget.topic.terms!),
                ),
              ],
              FutureBuilder(
                future: Future.wait([
                  getArticlesData(widget.topic),
                  getImageURLs(widget.topic.unit.toString()),

                  ///To-do add back in futures
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CustomErrorWidget();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      /// Get article and image data from firebase
                      final articles =
                          (snapshot.data?[0] as List<ArticleModel>?)
                                  ?.toList() ??
                              [];
                      List<ArticleModel> updatedArticles = [];
                      final imageUrls =
                          snapshot.data![1]! as Map<String, String>?;

                      /// Iterate through each article
                      for (var b in articles) {
                        if (b.body != null) {
                          /// Turn the body string into a list of words
                          List<String> bodyWords = b.body!.toListOfWords();

                          /// Identify any matches of the body with an image
                          for (int i = 0; i < bodyWords.length; i++) {
                            String word = bodyWords[i];
                            String? imageUrl =
                                imageUrls?[word.extractStringInsideBrackets()];

                            /// replace is there is a match
                            if (imageUrl != null) {
                              bodyWords[i] = '![Image]($imageUrl)';
                            }
                          }
                          updatedArticles.add(ArticleModel.copyWith(
                              heading: b.heading, body: bodyWords.join(' ')));
                        }
                      }

                      if (updatedArticles.isNotEmpty) {
                        int i = 0 + _expansionControllers.length;

                        return Column(
                          children: updatedArticles.map((article) {
                            i++;
                            _expansionControllers
                                .add(ExpansionTileController());
                            return ArticleLayout(
                              article: article,
                              expandableController:
                                  _expansionControllers[i - 1],
                            );
                          }).toList(),
                        );
                      }
                      return const SizedBox.shrink();
                    } else {
                      return const CustomErrorWidget();
                    }
                  }
                  return const CustomProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
