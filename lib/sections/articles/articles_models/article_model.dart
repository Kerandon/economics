import '../../quizzes/quiz_models/question_model.dart';

class ArticleModel {
  final String? unit;
  final String? title;
  final String? body;

  ArticleModel(
      {required this.unit,
      required this.title,
      required this.body,});

  factory ArticleModel.copyWith({
    String? unit,
    String? title,
    String? body,
    List<QuestionModel>? questions,
  }) {
    return ArticleModel(
        unit: unit, title: title, body: body);
  }

  List<ArticleModel> parseSections(String rawString) {
    List<ArticleModel> articles = [];

    // Define regex pattern to extract data between SECTION tags
    final sectionPattern =
    RegExp(r'<SECTION:(.*?):(.*?):(.*?)>');

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


  // factory ArticleModel.fromMap({
  //   required Map<String, dynamic> map,
  // }) {
  //   String? unit;
  //   String? title;
  //   String? body;
  //   List<QuestionModel>? questionList = [];
  //   for (var d in map.entries) {
  //     if (d.key == kUnit) {
  //       unit = d.value;
  //     }
  //     if (d.key == kTitle) {
  //       title = d.value;
  //     }
  //     if (d.key == kBody) {
  //       body = d.value;
  //     }
  //     // if (d.key == 'quiz') {
  //     //   Map<String, dynamic> jsonData = json.decode(d.value);
  //     //   List<dynamic> questions = jsonData['questions'];
  //     //   for (var question in questions) {
  //     //     final answer = question['answers'] as Map<String, dynamic>;
  //     //     List<AnswerModel> answers = [];
  //     //     for (var e in answer.entries) {
  //     //       answers.add(AnswerModel(e.key, e.value, AnswerStage.notAnswered));
  //     //     }
  //     //     final questionModel = QuestionModel(
  //     //         question: question['question'],
  //     //         answers: answers,
  //     //         answerStage: AnswerStage.notAnswered);
  //     //     questionList.add(questionModel);
  //     //   }
  //     // }
  //   }
  //
  //   return ArticleModel(
  //     unit: unit,
  //     title: title,
  //     body: body,
  //   );
  // }
}
