import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../articles_models/article_model.dart';
import '../articles_pages/article_page.dart';

class CustomSubTile extends  ConsumerWidget {
  const CustomSubTile(
    this.article, {
    this.removeDivider = false,
    super.key,
  });

  final ArticleModel article;
  final bool removeDivider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final width = size.width * 0.20;
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticlePage(article),
              ),
            );
          },
          leading: Container(
            width: width,
            height: width,
            color: Colors.red,
          ),
          title: Text(article.title ?? "")
        ),
        if (!removeDivider) ...[const Divider()]
      ],
    );
  }
}
