
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../../../app/enums/syllabus_enum.dart';
import '../../../app/utils/models/syllabus_model.dart';
import '../../../app/utils/models/unit_model.dart';
import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_enums/question_type.dart';
import '../../quizzes/quiz_enums/tag.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
List<QuestionModel> extractData(FilePickerResult? file) {
  List<QuestionModel> questions = [];

  if (file != null) {
    final pickedFile = file.files.single;
    final bytes = pickedFile.bytes;

    if (bytes == null) {

      return questions;
    }

    final excel = Excel.decodeBytes(bytes);
    // Find the first sheet with data (rows > 0)
    Sheet? sheetWithData;
    for (var sheet in excel.sheets.values) {
      if (sheet.rows.isNotEmpty) {
        sheetWithData = sheet;
        break;
      }
    }

    if (sheetWithData == null) {

      return questions;
    }

    final sheet = sheetWithData;

    // header row
    if (sheet.rows.isEmpty) {

      return questions;
    }

    final headerRow = sheet.rows[0];
    final Map<String, int> headerMap = {};
    for (int i = 0; i < headerRow.length; i++) {
      final cell = headerRow[i];
      if (cell != null && cell.value != null) {
        headerMap[cell.value.toString().trim()] = i;
      }
    }

    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      if (row.isEmpty) continue;

      String? getValue(String key) {
        final index = headerMap[key];
        if (index == null || index >= row.length) return null;
        return row[index]?.value?.toString();
      }

      final id = getValue(QuestionKey.id.name);
      final question = getValue(QuestionKey.question.name);

      if ((id == null || id.trim().isEmpty) &&
          (question == null || question.trim().isEmpty)) {
        continue;
      }

      // ... rest of your code to build the QuestionModel ...
      final questionType = QuestionTypeExtension.fromText(
        getValue(QuestionKey.type.name) ?? '',
      );

      final answer1 = getValue(QuestionKey.answer1.name);
      final answer1CorrectString =
          (getValue(QuestionKey.correct1.name)?.toUpperCase() ?? '') == 'TRUE';
      final answer2 = getValue(QuestionKey.answer2.name);
      final answer2CorrectString =
          (getValue(QuestionKey.correct2.name)?.toUpperCase() ?? '') == 'TRUE';
      final answer3 = getValue(QuestionKey.answer3.name);
      final answer3CorrectString =
          (getValue(QuestionKey.correct3.name)?.toUpperCase() ?? '') == 'TRUE';
      final answer4 = getValue(QuestionKey.answer4.name);
      final answer4CorrectString =
          (getValue(QuestionKey.correct4.name)?.toUpperCase() ?? '') == 'TRUE';

      List<AnswerModel> answers = [
        AnswerModel(answer1 ?? '', isCorrect: answer1CorrectString),
        AnswerModel(answer2 ?? '', isCorrect: answer2CorrectString),
        AnswerModel(answer3 ?? '', isCorrect: answer3CorrectString),
        AnswerModel(answer4 ?? '', isCorrect: answer4CorrectString),
      ];

      final explanation = getValue(QuestionKey.explanation.name);

      final syllabus = SyllabusEnumExtension.fromText(
        getValue(QuestionKey.syllabus.name) ?? '',
      );

      final unit1 = getValue(QuestionKey.unit1.name);
      final subunit1 = getValue(QuestionKey.subunit1.name);

      final unit1IndexString = getValue(QuestionKey.unit1Index.name);
      final subunit1IndexString = getValue(QuestionKey.subunit1Index.name);

      final unit1Index = int.tryParse(unit1IndexString ?? '');
      final subunit1Index = int.tryParse(subunit1IndexString ?? '');

      List<Tag?>? tags = [
        CustomTagExtension.fromText(getValue(QuestionKey.tag1.name)),
        CustomTagExtension.fromText(getValue(QuestionKey.tag2.name)),
        CustomTagExtension.fromText(getValue(QuestionKey.tag3.name)),
        CustomTagExtension.fromText(getValue(QuestionKey.tag4.name)),
      ];

      questions.add(
        QuestionModel().copyWith(
          id: id,
          question: question,
          questionTypes: [questionType ?? QuestionType.multi],
          answers: answers,
          explanation: explanation,
          syllabuses: [SyllabusModel(syllabus: syllabus, units: [])],
          units: [
            UnitModel(
              name: unit1,
              index: unit1Index?.toString() ?? '',
            )
          ],
          subunits: [
            UnitModel(
              name: subunit1,
              index: subunit1Index?.toString() ?? '',
            )
          ],
          tags: tags.whereType<Tag>().toList(),
        ),
      );
    }
  }

  return questions;
}
