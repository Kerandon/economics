import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../methods/extract_excel_data.dart';
import '../../methods/pick_excel_file.dart';
import '../../methods/send_new_question_to_firebase.dart';
import '../question_tile.dart';

class ExcelDataManager extends StatefulWidget {
  const ExcelDataManager({super.key});

  @override
  State<ExcelDataManager> createState() => _ExcelDataManagerState();
}

class _ExcelDataManagerState extends State<ExcelDataManager> {
  FilePickerResult? file;
  List<QuestionModel> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Excel Data Manager')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        icon: Icon(Icons.upload_file),
                        label:
                            Text(file?.files.first.name ?? 'Select Excel File'),
                        onPressed: () async {
                          file = await pickExcelFile();
                          questions = extractData(file);
                          setState(() {});
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20.0),
                          textStyle: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      if (file != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Selected: ${file!.files.first.name}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (file != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(file!.files.first.path ?? ''),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Add ${questions.length} questions to Firebase'),
                  onPressed: questions.isNotEmpty
                      ? () {
                          sendNewQuestionsBatchToFirebase(questions.toList());
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    textStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          if (questions.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => QuestionTile(q: questions[index]),
                childCount: questions.length,
              ),
            ),
        ],
      ),
    );
  }
}
