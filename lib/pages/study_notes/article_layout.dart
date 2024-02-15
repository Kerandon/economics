import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/custom_widgets/images/custom_image_network.dart';
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
    final size = MediaQuery.of(context).size;

    String updatedBody = article.body!.replaceAll(r'\n', '\n');
    updatedBody = "> Here is a text block \n\n ==Highlighted== "
        "and this";

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
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * kPageIndentHorizontal,
                    vertical: size.width * kPageIndentVertical),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                data: updatedBody,
                imageBuilder: (uri, _, __) {
                  return CustomImageNetwork(uri.toString());
                },
                styleSheet: MarkdownStyleSheet(
                  blockquoteDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  blockquote: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String parseNewlines(String input) {
  return input.replaceAll(RegExp(r'\\n'), '\n');
}
