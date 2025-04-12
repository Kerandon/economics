import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/diagrams/diagram_widgets/custom_diagram_builder.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_page.dart';
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
                      builder: (context) => StartPage(),
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
          return null;
        },
        itemCount: QuestionType.values.length + 1,
        //TopicTag.values.length, // Number of grid tiles
      ),
    );
  }
}

class CustomHomeTile extends ConsumerWidget {
  const CustomHomeTile({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);



    return GridTile(
      child: InkWell(
        onTap: () {
          onPressed.call();
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
                      title,
                      // QuestionType.values.elementAt(index).name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(
                  color: theme.colorScheme.shadow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AllDiagramsPage extends StatefulWidget {
  const AllDiagramsPage({super.key});

  @override
  State<AllDiagramsPage> createState() => _AllDiagramsPageState();
}

class _AllDiagramsPageState extends State<AllDiagramsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<DiagramModel> allDiagrams = DiagramModel.getAllDiagrams(size, context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Diagrams'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  title: Text(
                      '${allDiagrams[index].type?.name ?? ''} - ${allDiagrams[index].subtype?.name}'),
                  children: [
                    CustomDiagramBuilder(diagrams: [allDiagrams[index]],dimensions: 0.40,)
                  ],
                );
              },
              childCount: allDiagrams.length,
            ),
          ),
        ],
      ),
    );
  }
}
