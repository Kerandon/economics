
import 'package:excel/excel.dart';

import '../../../sections/quizzes/quiz_enums/question_key.dart';
import '../../../sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';

void exportToExcel(List<QuestionModel> allQuestions) {
  final excel = Excel.createExcel();
  Sheet sheet = excel['quiz_data'];

  // Define headers including the new properties, with Question ID as the first column
  List<String> headers = [
    QuestionKey.id.name,
    // Moved ID to the first column
    QuestionKey.type.name,
    // Moved Question Type to the second column
    QuestionKey.question.name,
    QuestionKey.answer1.name,
    QuestionKey.correct.name,
    QuestionKey.answer2.name,
    QuestionKey.correct.name,
    QuestionKey.answer3.name,
    QuestionKey.correct.name,
    QuestionKey.answer4.name,
    QuestionKey.correct.name,
    QuestionKey.explanation.name,
    QuestionKey.syllabus.name,
    QuestionKey.unit1.name,
    QuestionKey.unit2.name,
    QuestionKey.subunit1.name,
    QuestionKey.subunit2.name,
    QuestionKey.tag1.name,
    QuestionKey.tag2.name,
    QuestionKey.tag3.name,
    QuestionKey.tag4.name,
    QuestionKey.diagram1.name,
    QuestionKey.diagram2.name,
    QuestionKey.diagram3.name,
    QuestionKey.diagram4.name,
    // Added columns for diagrams
  ];

  for (int col = 0; col < headers.length; col++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
        .value = TextCellValue(headers[col]);
  }

  // Populate data
  for (int i = 0; i < allQuestions.length; i++) {
    final q = allQuestions[i];

    // Ensure exactly 4 answers and their correctness
    List<String> answers = List.filled(4, '');
    List<String> correctness =
    List.filled(4, 'FALSE'); // Create a list for correctness
    for (int j = 0; j < (q.answers?.length ?? 0).clamp(0, 4); j++) {
      answers[j] = q.answers![j].answer;
      correctness[j] = q.answers![j].isCorrect
          ? 'TRUE'
          : 'FALSE'; // Assign correct status as string
    }

    // Ensure exactly 2 units
    List<String> units = List.filled(2, 'null');
    for (int j = 0; j < (q.units?.length ?? 0).clamp(0, 2); j++) {
      units[j] = q.units![j].name ?? 'null';
    }

    // Ensure exactly 2 subunits
    List<String> subunits = List.filled(2, 'null');
    for (int j = 0; j < (q.subunits?.length ?? 0).clamp(0, 2); j++) {
      subunits[j] = q.subunits![j].name ?? 'null';
    }

    // Ensure exactly 4 tags
    List<String> tags = List.filled(4, 'null');
    for (int j = 0; j < (q.tags?.length ?? 0).clamp(0, 4); j++) {
      tags[j] = q.tags![j].name;
    }

    // Ensure exactly 4 diagrams
    List<String> diagrams = List.filled(4, 'null');
    for (int j = 0; j < (q.diagrams?.length ?? 0).clamp(0, 4); j++) {
      diagrams[j] = q.diagrams![j].type?.name ?? 'null';
    }

    // Prepare row data, with question ID as the first column
    List<String?> rowValues = [
      q.id ?? '', // Question ID first
      q.questionType?.name ?? '', // Question Type second
      q.question,
      answers[0], correctness[0], // Answer 1 and its correctness
      answers[1], correctness[1], // Answer 2 and its correctness
      answers[2], correctness[2], // Answer 3 and its correctness
      answers[3], correctness[3], // Answer 4 and its correctness
      q.explanation,
      q.syllabus?.syllabus?.name ?? '',
      ...units, // Correctly filling the unit columns
      ...subunits, // Correctly filling the subunit columns
      ...tags, // Tags (up to 4 tags)
      ...diagrams, // Diagrams (up to 4 diagrams)
    ];

    // Populate row in Excel sheet
    for (int col = 0; col < rowValues.length; col++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: i + 1))
          .value = TextCellValue(rowValues[col] ?? '');
    }
  }

  excel.save(fileName: 'economics_app_data.xlsx');
}
