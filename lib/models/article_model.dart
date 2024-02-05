import 'package:economics_app/configs/constants.dart';

class ArticleModel {
  final int? index;
  final String? heading;
  final String? image;
  final String? body;
  final List<ArticleModel>? paragraphs;

  ArticleModel(
      {this.index, this.heading, this.image, this.body, this.paragraphs});

  factory ArticleModel.copyWith({
    int? index,
    String? heading,
    String? image,
    String? body,
    List<ArticleModel>? paragraphs,
  }) {
    return ArticleModel(
      index: index,
      heading: heading,
      image: image,
      body: body,
      paragraphs: paragraphs,
    );
  }

  factory ArticleModel.fromMap(
      {required Map<String, dynamic> map, int? index}) {
    String? heading;
    String? body;
    String? image;
    List<ArticleModel> paragraphs = [];

    for (var d in map.entries) {
      if (d.key == kHeading) {
        heading = d.value;
      }
      if (d.key == kBody) {
        body = d.value;
      }

      if (d.key == kImage) {
        image = d.value;
      }

// Check if the key is a paragraph key
      if (d.key.startsWith(kParagraph)) {
        // Extract the paragraph index
        int paraIndex = int.parse(d.key.substring(kParagraph.length + 1));

        paragraphs.add(ArticleModel.fromMap(map: d.value, index: paraIndex));
      }
    }

    return ArticleModel(
      index: index,
      heading: heading,
      body: body,
      image: image,
      paragraphs: paragraphs,
    );
  }
}
