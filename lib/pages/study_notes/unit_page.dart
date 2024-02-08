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
import '../../custom_widgets/article/paragraph_heading.dart';
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

  @override
  void initState() {
    _articlesFuture = getArticlesData(widget.topic);
    if (widget.topic.terms != null) {
      _expansionControllers.add(ExpansionTileController());
    }
    if (widget.topic.summary != null) {
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
                title: Text(
                    '${widget.topic.unit} ${widget.topic.title!.capitalizeFirstLetter()}'),
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
              if (widget.topic.summary != null) ...[
                CustomExpansionTile(
                  title: 'Learning objectives',
                  expansionController: _expansionControllers[0],
                  child:
                        CustomTable(widget.topic.summary!.toMap(), useBulletPoints: true,)

                )
              ],
              if (widget.topic.terms != null) ...[
                CustomExpansionTile(
                  title: 'Key terms',
                  expansionController: _expansionControllers[1],
                  child: CustomTable(widget.topic.terms!),
                ),
              ],
              FutureBuilder<List<ArticleModel>?>(
                future: _articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CustomErrorWidget();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<ArticleModel> articles = snapshot.data!.toList();
                      int i = 0;
                      return Column(
                        children: articles.map((article) {
                          i++;
                          _expansionControllers.add(ExpansionTileController());
                          return ArticleLayout(
                            article: article,
                            expandableController: _expansionControllers[i + 1],
                          );
                        }).toList(),
                      );
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
