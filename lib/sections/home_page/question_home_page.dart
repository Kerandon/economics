import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_quiz_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager/audio_manager.dart';
import '../../main.dart';
import '../all_diagrams_page/all_diagrams_page.dart';
import '../notes_page/notes_page.dart';
import 'custom_home_tile.dart';

class QuestionHomePage extends ConsumerStatefulWidget {
  const QuestionHomePage({super.key});

  @override
  ConsumerState<QuestionHomePage> createState() => _QuestionHomePageState();
}

class _QuestionHomePageState extends ConsumerState<QuestionHomePage> {
  @override
  void initState() {
    getIt<AudioManager>().stopSoundTrack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final startNotifier = ref.read(startQuizProvider.notifier);

    final editState = ref.watch(editQuestionProvider);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * kPageIndentVertical,
        left: size.width * kPageIndentHorizontal,
        right: size.width * kPageIndentHorizontal,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          crossAxisCount: 4, // Number of columns
          childAspectRatio: 1.0, // Ensures tiles are square
        ),
        itemBuilder: (context, index) {
          if (index < 2) {
            return CustomHomeTile(
                title: QuestionType.values.elementAt(index).name,
                onPressed: () {
                  startNotifier
                    ..setAllTopicQuestions(editState.allQuestions.toList())
                    ..setQuestionType(QuestionType.values[index]);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StartQuizPage(),
                    ),
                  );
                });
          }
          if (index == 2) {
            return CustomHomeTile(
              title: 'Diagrams',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllDiagramsPage(),
                  ),
                );
              },
            );
          }
          if(index == 3){
            return CustomHomeTile(
              title: 'Notes',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotesPage(),
                  ),
                );
              },
            );
          }
          return null;
        },
        itemCount: QuestionType.values.length + 2,
        //TopicTag.values.length, // Number of grid tiles
      ),
    );
  }
}
