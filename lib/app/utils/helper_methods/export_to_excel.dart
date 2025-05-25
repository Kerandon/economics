
import 'package:excel/excel.dart';

import '../../../sections/quizzes/quiz_enums/question_key.dart';
import '../../../sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
void exportToExcel(List<QuestionModel> allQuestions) {
  final excel = Excel.createExcel();
  excel.rename('Sheet1', 'quiz_data');
  final Sheet sheet = excel['quiz_data'];

  // Define headers explicitly
  List<String> headers = [
    QuestionKey.id.name,
    QuestionKey.type.name,
    QuestionKey.question.name,
    QuestionKey.answer1.name,
    QuestionKey.correct1.name,
    QuestionKey.answer2.name,
    QuestionKey.correct2.name,
    QuestionKey.answer3.name,
    QuestionKey.correct3.name,
    QuestionKey.answer4.name,
    QuestionKey.correct4.name,
    QuestionKey.explanation.name,
    QuestionKey.syllabus.name,
    QuestionKey.unit1Index.name,
    QuestionKey.unit1.name,
    QuestionKey.subunit1Index.name,
    QuestionKey.subunit1.name,
    QuestionKey.tag1.name,
    QuestionKey.tag2.name,
    QuestionKey.tag3.name,
    QuestionKey.tag4.name,
    // Add more headers here if needed
  ];

  // Write headers
  for (int col = 0; col < headers.length; col++) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
        .value = TextCellValue(headers[col]);
  }

  // Write question data
  for (int row = 0; row < allQuestions.length; row++) {
    final q = allQuestions[row];

    final answers = List.filled(4, '');
    final correctness = List.filled(4, 'FALSE');
    for (int i = 0; i < (q.answers?.length ?? 0).clamp(0, 4); i++) {
      answers[i] = q.answers![i].answer;
      correctness[i] = q.answers![i].isCorrect ? 'TRUE' : 'FALSE';
    }

    final unitName = q.units?.isNotEmpty == true ? q.units!.first.name ?? 'null' : 'null';
    final unitIndex = q.units?.isNotEmpty == true ? (q.units!.first.index ?? 0).toString() : '0';

    final subunitName = q.subunits?.isNotEmpty == true ? q.subunits!.first.name ?? 'null' : 'null';
    final subunitIndex = q.subunits?.isNotEmpty == true ? (q.subunits!.first.index ?? 0).toString() : '0';

    final tags = List.filled(4, 'null');
    for (int i = 0; i < (q.tags?.length ?? 0).clamp(0, 4); i++) {
      tags[i] = q.tags![i].name;
    }

    final Map<String, String?> valueMap = {
      QuestionKey.id.name: q.id ?? '',
      QuestionKey.type.name: q.questionTypes?[0].name ?? '',
      QuestionKey.question.name: q.question,
      QuestionKey.answer1.name: answers[0],
      QuestionKey.correct1.name: correctness[0],
      QuestionKey.answer2.name: answers[1],
      QuestionKey.correct2.name: correctness[1],
      QuestionKey.answer3.name: answers[2],
      QuestionKey.correct3.name: correctness[2],
      QuestionKey.answer4.name: answers[3],
      QuestionKey.correct4.name: correctness[3],
      QuestionKey.explanation.name: q.explanation,
      QuestionKey.syllabus.name: q.syllabuses?[0].syllabus?.name,
      QuestionKey.unit1Index.name: unitIndex,
      QuestionKey.unit1.name: unitName,
      QuestionKey.subunit1Index.name: subunitIndex,
      QuestionKey.subunit1.name: subunitName,
      QuestionKey.tag1.name: tags[0],
      QuestionKey.tag2.name: tags[1],
      QuestionKey.tag3.name: tags[2],
      QuestionKey.tag4.name: tags[3],
    };

    // Fill the row based on headers
    for (int col = 0; col < headers.length; col++) {
      final key = headers[col];
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1))
          .value = TextCellValue(valueMap[key] ?? '');
    }
  }

  excel.save(fileName: 'economics_app_data.xlsx');
}

