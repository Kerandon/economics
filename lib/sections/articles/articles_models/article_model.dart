import '../../quizzes/quiz_models/question_model.dart';

class ArticleModel {
  final String? unit;
  final String? title;
  final String? body;

  ArticleModel({
    this.unit,
    this.title,
    this.body,
  });

  factory ArticleModel.copyWith({
    String? unit,
    String? title,
    String? body,
    List<QuestionModel>? questions,
  }) {
    return ArticleModel(unit: unit, title: title, body: body);
  }

  List<ArticleModel> parseSections(String rawString) {
    List<ArticleModel> articles = [];

    // Define regex pattern to extract data between SECTION tags
    final sectionPattern = RegExp(r'<SECTION:(.*?):(.*?):(.*?)>');

    // Extract matches using regex
    final sectionMatches = sectionPattern.allMatches(rawString);

    // Loop through matches and create ArticleModel objects
    for (final match in sectionMatches) {
      String title = match.group(1)!;
      String unit = match.group(2)!;
      String body = match.group(3)!;

      articles.add(ArticleModel.copyWith(
        unit: unit,
        title: title,
        body: body,
      ));
    }

    return articles;
  }
}
