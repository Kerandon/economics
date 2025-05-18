import 'dart:io';

import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/audio/sound_track_toggle.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/state/app_state.dart';
import '../../app/utils/helper_methods/export_to_excel.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkThemeState =
        ref.watch(appProvider.select((s) => s.isDarkTheme));
    final editState = ref.watch(editQuestionProvider);
    final appNotifier = ref.read(appProvider.notifier);
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            SwitchListTile(
                title: Text(
                  'Dark theme',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: isDarkThemeState,
                onChanged: (on) {
                  appNotifier.setDarkTheme(on);
                }),
            ListTile(
              title: Text(
                'Manage Questions',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManageQuestionsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Export to Excel'),
              onTap: () {
                exportToExcel(editState.allQuestions.toList());
              },
            ),
            ListTile(
              title: Text('Upload Excel'),
              onTap: () {
           showDialog(context: context, builder: (context) => ExcelDataManager());
              },
            ),
            const SoundTrackToggle(),
          ],
        ),
      ),
    );
  }
}

class ExcelDataManager extends StatelessWidget {
  const ExcelDataManager({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Excel data manager'),
      content: Column(
        children: [
          OutlinedButton(onPressed: ()async{


          }, child: Text('Select Excel')),

        ],
      ),
    );
  }
}




void pickExcelFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls'],
  );

  if (result != null && result.files.single.path != null) {
    print('success');
  }
  return null;
}
