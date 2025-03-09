import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager/audio_manager.dart';
import '../../main.dart';

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
    final theme = Theme.of(context);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final startState = ref.watch(startQuizProvider);
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
          // final tag = TopicTag.values[index];
          int numberOfQuestions = 0;
          for (var q in editState.allQuestions) {
            if (q.syllabus == startState.syllabus) {
              numberOfQuestions++;
            }
          }
          //
          return GridTile(
            child: InkWell(
              onTap: () {
                startNotifier
                    .setAllTopicQuestions(editState.allQuestions.toList());

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Container(color: Colors.red,)
                  ),
                );
              },
              borderRadius: BorderRadius.circular(kRadius),
              // Match the tile's border radius
              child: Ink(
                decoration: getTileDecoration(context),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  // Inner spacing for the text
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Center(
                          child: Text(
                            QuestionType.values.elementAt(index).name,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(
                        color: theme.colorScheme.shadow,
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Text(
                            '${numberOfQuestions.toString()} questions',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: QuestionType.values.length,
        //TopicTag.values.length, // Number of grid tiles
      ),
    );
  }
}
