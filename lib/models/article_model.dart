import 'package:economics_app/configs/constants.dart';

class ArticleModel {
  final String? heading;
  final String? body;

  ArticleModel({required this.heading, required this.body});

  factory ArticleModel.copyWith({
    String? heading,
    String? body,
  }) {
    return ArticleModel(
      heading: heading,
      body: body,
    );
  }

  factory ArticleModel.fromMap({required Map<String, dynamic> map}) {
    String? heading;
    String? body;

    for (var d in map.entries) {
      if (d.key == kHeading) {
        heading = d.value;
      }
      if (d.key == kBody) {
        body = d.value;
      }
    }

    return ArticleModel(
      heading: heading,
      body: body,
    );
  }
}
