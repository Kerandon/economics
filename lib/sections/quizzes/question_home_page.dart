import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_quiz_page.dart';

import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
    List<DiagramModel> allDiagrams = DiagramModel.getUniqueByUnitAndType(size, context);

    
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
                      allDiagrams[index].type?.toText() ?? ''),
                  children: [
CustomDiagramBuilderWithSubtype(diagrams: [allDiagrams[index]])
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
class CustomDiagramBuilderWithSubtype extends StatefulWidget {
  const CustomDiagramBuilderWithSubtype({
    super.key,
    required this.diagrams,
    this.dimensions = 0.40,
  });

  final List<DiagramModel>? diagrams;
  final double dimensions;

  @override
  State<CustomDiagramBuilderWithSubtype> createState() =>
      _CustomDiagramBuilderWithSubtypeState();
}

class _CustomDiagramBuilderWithSubtypeState
    extends State<CustomDiagramBuilderWithSubtype> {
  final Map<String, DiagramSubtype?> _selectedSubtypes = {};

  void _showFullScreenDiagram(DiagramModel diagram) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(
              [
                diagram.type?.toText(),
                diagram.subtype?.description(),
              ].whereType<String>().join(' - '),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: AspectRatio(
                aspectRatio: 1, // Ensures width and height are equal
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomPaint(
                    painter: diagram.painter,
                    size: Size.infinite, // Painter will be given square space
                  ),
                ),
              ),
            ),
          )

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final diagramsToShow = DiagramModel.getSelectedDiagrams(
      size,
      context,
      selectedDiagrams: widget.diagrams ?? [],
    );

    final Map<String, List<DiagramModel>> grouped = {};
    for (var diagram in diagramsToShow) {
      final key = '${diagram.unit}_${diagram.type}';
      grouped.putIfAbsent(key, () => []).add(diagram);
    }

    return Wrap(
      children: grouped.entries.map((entry) {
        final key = entry.key;
        final diagrams = entry.value;
        final subtypes = diagrams
            .where((d) => d.unit == diagrams.first.unit && d.type == diagrams.first.type)
            .map((d) => d.subtype)
            .whereType<DiagramSubtype>()
            .toSet()
            .toList();

        final selectedSubtype = _selectedSubtypes[key] ?? subtypes.first;

        final currentDiagram = diagrams.firstWhere(
              (d) => d.subtype == selectedSubtype,
          orElse: () => diagrams.first,
        );

        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Diagram display with fade animation and fullscreen tap
              Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: GestureDetector(
                      key: ValueKey(currentDiagram.subtype),
                      onTap: () => _showFullScreenDiagram(currentDiagram),
                      child: SizedBox(
                        width: size.width * widget.dimensions,
                        height: size.width * widget.dimensions,
                        child: CustomPaint(painter: currentDiagram.painter),
                      ),
                    ),
                  ),
                  // Magnifying glass icon for enlargement
                  IconButton(
                    icon: Icon(Icons.search, size: 30),
                    onPressed: () => _showFullScreenDiagram(currentDiagram),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(currentDiagram.subtype?.description() ?? ""),
                    ),
                  ),
                ],
              ),
              // Subtype chips
              if (subtypes.length > 1)
                Wrap(
                  spacing: 8,
                  children: subtypes.map((subtype) {
                    final isSelected = subtype == selectedSubtype;
                    return CustomChipButton(
                      isSelected: isSelected,
                      text: subtype.toText(),
                      onPressed: () {
                        setState(() {
                          _selectedSubtypes[key] = subtype;
                        });
                      },
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
