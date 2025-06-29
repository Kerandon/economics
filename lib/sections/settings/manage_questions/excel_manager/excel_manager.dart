import 'package:economics_app/app/custom_widgets/building_helper.dart';
import 'package:economics_app/sections/settings/manage_questions/filter_buttons.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/enums/firebase_status.dart';
import '../../../../app/utils/helper_methods/export_to_excel.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../../methods/download_excel_data.dart';
import '../../methods/filter_questions.dart';
import '../../methods/pick_excel_file.dart';
import '../../methods/send_new_question_to_firebase.dart';
import '../question_tile.dart';

class ExcelManager extends ConsumerStatefulWidget {
  const ExcelManager({super.key});

  @override
  ConsumerState<ExcelManager> createState() => _ExcelUploadManagerState();
}

class _ExcelUploadManagerState extends ConsumerState<ExcelManager> {
  FilePickerResult? file;
  List<QuestionModel> filteredQuestions = [];

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    filteredQuestions = editState.temporaryQuestions.toList();
    final c = editState.currentQuestion;
    filteredQuestions =
        filterQuestions(questions: filteredQuestions.toList(), filter: c)
            .toList();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ManageQuestionsPage(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {
                exportToExcel(
                  filteredQuestions.toList(),
                );
              },
              icon: Icon(
                Icons.file_download,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

          ],
          title: Text('Excel Manager'),),
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
                          editNotifier.setTemporaryQuestions(
                              downloadExcelData(file).toList());
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
                  label: Text(
                      'Add ${filteredQuestions.length} questions to Firebase'),
                  onPressed: filteredQuestions.isNotEmpty
                      ? () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => BuilderHelper(
                                        future: sendNewQuestionsBatchToFirebase(
                                            filteredQuestions.toList()),
                                        onComplete: (status) {
                                          String msg =
                                              'Questions successfully added to firebase';
                                          if (status ==
                                              FirebaseStatus.error) {
                                            msg =
                                                'Error - questions not added to firebase';
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBar(content: Text(msg)));
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ExcelManager(),
                                            ),
                                          );
                                        },
                                      )));
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
          SliverToBoxAdapter(child: FilterButtons()),
          if (filteredQuestions.toList().isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return QuestionTile(
                    q: filteredQuestions[index],
                    pageOnPopupButtonExit: ExcelManager(),
                  );
                },
                childCount: filteredQuestions.length,
              ),
            ),
        ],
      ),
    );
  }
}
