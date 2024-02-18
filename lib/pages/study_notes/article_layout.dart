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

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: CustomExpansionTile(
        title: article.heading?.capitalizeFirstLetter() ?? "",
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
                  tableBorder: TableBorder.all(color: Colors.white, width: 1),
                  tableColumnWidth: IntrinsicColumnWidth(),
                  tableCellsPadding: EdgeInsets.only(bottom: 10, left: 10),
                  tableHeadAlign: TextAlign.start,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension MarkdownTableFormatter on String {
  String formatToMarkdownTable() {
    // Remove leading and trailing whitespaces and newlines
    var formattedText = this.trim();

    // Split the text into lines
    var lines = formattedText.split('\n');

    // Remove leading and trailing whitespaces from each line
    lines = lines.map((line) => line.trim()).toList();

    // Join the lines back with '\n'
    formattedText = lines.join('\n');

    // Split the text into rows
    var rows = formattedText.split('|');

    // Remove leading and trailing whitespaces from each cell
    rows = rows.map((row) {
      var cells = row.split('|');
      cells = cells.map((cell) => cell.trim()).toList();
      return cells.join('|');
    }).toList();

    // Join the rows back with '|'
    formattedText = rows.join('\n| ');

    // Add the necessary markdown table syntax
    formattedText = '| ' + formattedText + ' |';

    return formattedText;
  }
}
