import 'package:economics_app/configs/constants.dart';

class ArticleModel {
  final int? index;
  final String? heading;
  final String? body;

  ArticleModel(
      {required this.index, required this.heading, required this.body});

  factory ArticleModel.copyWith({
    int? index,
    String? heading,
    String? body,
  }) {
    return ArticleModel(
      index: index,
      heading: heading,
      body: body,
    );
  }

  factory ArticleModel.fromMap({
    required Map<String, dynamic> map,
    String? heading,
  }) {
    int? index;
    String? body;

    for (var d in map.entries) {
      if (d.key == kIndex) {
        try {
          index = d.value;
        } catch (e){
          ///to-do add in an custom error screen
          throw Exception('could not parse int');
        }
      }
      if (d.key == kHeading) {
        heading == d.value;
      }
      if (d.key == kBody) {
        body = d.value;
      }
    }

    return ArticleModel(
      heading: heading ?? "",
      index: index,
      body: body,
    );
  }
}
