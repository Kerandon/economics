import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';

List<QuestionModel> filterQuestions({
  required List<QuestionModel> questions,
  required QuestionModel filter,
}) {
  return questions.where((q) {
    final syllabusMatch = (filter.syllabuses?.isEmpty ?? true) ||
        (q.syllabuses?.any((s) => filter.syllabuses!.contains(s)) ?? false);

    final unitMatch = (filter.units?.isEmpty ?? true) ||
        (q.units?.any((u) => filter.units!.contains(u)) ?? false);

    final subunitMatch = (filter.subunits?.isEmpty ?? true) ||
        (q.subunits?.any((su) => filter.subunits!.contains(su)) ?? false);

    final typeMatch = (filter.questionTypes?.isEmpty ?? true) ||
        (q.questionTypes?.any((t) => filter.questionTypes!.contains(t)) ??
            false);

    final tagMatch = (filter.tags?.isEmpty ?? true) ||
        (q.tags?.any((t) => filter.tags!.contains(t)) ?? false);

    return syllabusMatch && unitMatch && subunitMatch && typeMatch && tagMatch;
  }).toList();
}
