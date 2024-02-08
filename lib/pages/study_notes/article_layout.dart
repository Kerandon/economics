import 'package:economics_app/custom_widgets/tiles/custom_expansion_table.dart';
import 'package:economics_app/models/article_model.dart';
import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';
import '../../custom_widgets/article/paragraph_heading.dart';
import '../../custom_widgets/images/display_image.dart';

class ArticleLayout extends StatelessWidget {
  const ArticleLayout(
      {super.key, required this.article, required this.expandableController});

  final ArticleModel article;
  final ExpansionTileController expandableController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textBlockPadding =
        EdgeInsets.symmetric(vertical: size.height * 0.020);
    int paragraphIndex = 0;
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: CustomExpansionTile(
        title: article.heading!.capitalizeFirstLetter(),
        expansionController: expandableController,
        child: Column(
          children: [
            ...article.paragraphs!.map((p) {
              paragraphIndex++;
              final isLastParagraph =
                  paragraphIndex == article.paragraphs!.length;

              return Container(
                width: size.width,
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParagraphBlock(
                      p.heading,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    ParagraphBlock(p.body),
                    if (p.image != null) ...[
                      Padding(
                        padding: textBlockPadding,
                        child: DisplayImage(p.image!),
                      )
                    ],
                    if (!isLastParagraph)
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),

      // ExpansionTile(
      //   iconColor: Colors.white,
      //   collapsedIconColor: Colors.white,
      //   controller: expandableController,
      //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
      //   expandedAlignment: Alignment.centerLeft,
      //   initiallyExpanded: true,
      //   title: ParagraphBlock(article.heading!.capitalizeFirstLetter(), fontWeight: FontWeight.bold,),
      //   children: [
      //     ...article.paragraphs!.map((p) {
      //       paragraphIndex++;
      //       final isLastParagraph = paragraphIndex == article.paragraphs!.length;
      //
      //       return Container(
      //         width: size.width,
      //         color: Theme.of(context).colorScheme.background,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             ParagraphBlock(p.heading, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,),
      //             ParagraphBlock(p.body),
      //             if (p.image != null) ...[
      //               Padding(
      //                 padding: textBlockPadding,
      //                 child: DisplayImage(p.image!),
      //               )
      //             ],
      //             if (!isLastParagraph)
      //               Divider(
      //                 color: Theme.of(context).colorScheme.secondary,
      //               ),
      //           ],
      //         ),
      //       );
      //     }).toList(),
      //   ],
      // ),
    );
  }
}
