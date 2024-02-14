import 'package:economics_app/custom_widgets/tiles/custom_expansion_table.dart';
import 'package:economics_app/models/article_model.dart';
import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticleLayout extends StatelessWidget {
  const ArticleLayout(
      {super.key, required this.article, required this.expandableController});

  final ArticleModel article;
  final ExpansionTileController expandableController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: CustomExpansionTile(
        title: article.heading!.capitalizeFirstLetter(),
        expansionController: expandableController,
        child: SingleChildScrollView(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Markdown(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  data: article.body ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
