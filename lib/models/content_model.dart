class ContentModel {
  final int? index;
  final String? title;
  final String? heading;
  final String? image;
  final String? body;

  ContentModel([this.index, this.title, this.heading, this.image, this.body]);

  factory ContentModel.copyWith(
      {int? index,
      String? title,
      String? heading,
      String? image,
      String? body}) {
    return ContentModel(index, title, heading, image, body);
  }
}
