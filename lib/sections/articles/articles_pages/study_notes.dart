import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/custom_divider.dart';
import '../../../app/custom_widgets/custom_page_heading.dart';
import '../../../app/custom_widgets/custom_sub_tile.dart';
import '../../../app/custom_widgets/loading_error/custom_error_widget.dart';
import '../../../app/custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../../app/utils/helper_methods/get_section_icon.dart';
import '../../quizzes/quiz_helper_methods/quiz_firebase_methods.dart';
import '../../quizzes/quiz_models/question_model.dart';
import '../../../app/enums/sections.dart';
import '../articles_models/article_model.dart';
import '../articles_helper_methods/firebase_methods.dart';

class StudyNotes extends ConsumerStatefulWidget {
  const StudyNotes({super.key});

  @override
  ConsumerState<StudyNotes> createState() => _SectionsPageState();
}

class _SectionsPageState extends ConsumerState<StudyNotes> {
  late final Future<List<ArticleModel>?> _articlesFuture;
  late final Future<List<QuestionModel>?> _questionsFuture;
  final List<ExpandableController> _expandableControllers = [];

  @override
  void initState() {
    _articlesFuture = getArticleDataFromFirebase();
    _questionsFuture = getQuestionDataFromFirebase();

    for (int i = 0; i < 4; i++) {
      _expandableControllers.add(ExpandableController());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizNotifier = ref.read(quizProvider.notifier);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CustomPageHeading(
            expandableControllers: _expandableControllers,
            icon: const Icon(Icons.style_outlined),
            title: 'Study Notes',
            //allTilesCollapsed: appState.showExpanded.entries.elementAt(0).value,
            // expandableChanged: (){
            //   if(_expandableControllers.any((c) => c.expanded)){
            //     appNotifier.setShowExpanded(0, true);
            //   }else{
            //     appNotifier.setShowExpanded(0, false);
            //   }
            // },
          ),
        ];
      },
      body: FutureBuilder(
        future: Future.wait([_articlesFuture, _questionsFuture]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CustomErrorWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data![0] != null &&
                snapshot.data![1] != null) {
              /// Sort article data
              List<ArticleModel> allArticles =
                  snapshot.data![0]!.toList() as List<ArticleModel>;
              List<ArticleModel> introArticles = [];
              List<ArticleModel> microArticles = [];
              List<ArticleModel> macroArticles = [];
              List<ArticleModel> globalArticles = [];
              for (var a in allArticles) {
                if (a.unit!.startsWith('1')) {
                  introArticles.add(a);
                }
                if (a.unit!.startsWith('2')) {
                  microArticles.add(a);
                }
                if (a.unit!.startsWith('3')) {
                  macroArticles.add(a);
                }
                if (a.unit!.startsWith('4')) {
                  globalArticles.add(a);
                }
              }

              final questions = snapshot.data![1] as List<QuestionModel>;

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                quizNotifier.setAllQuestions(questions);
              });

              return ListView.builder(
                itemCount: Section.values.length,
                itemBuilder: (context, index) {
                  final section = Section.values[index];
                  return Column(
                    children: [
                      ExpandableNotifier(
                        controller: _expandableControllers[index],
                        child: ExpandablePanel(
                          header: ListTile(
                            leading: Icon(getSectionIcon(section)),
                            title: Text(section.getSectionName()),
                          ),
                          collapsed: const SizedBox.shrink(),
                          expanded: Column(
                            children: <Widget>[
                              ...[
                                ..._buildUnitsTile(section, [
                                  introArticles,
                                  microArticles,
                                  macroArticles,
                                  globalArticles,
                                ])
                              ]
                            ],
                          ),
                        ),
                      ),
                      const CustomDivider(),
                    ],
                  );
                },
              );
            }
          }
          return const CustomProgressIndicator();
        },
      ),
    );
  }
}

List<Widget> _buildUnitsTile(
    Section section, List<List<ArticleModel>> articles) {
  switch (section) {
    case Section.intro:
      return [
        ...articles[0].map(
          (m) => CustomSubTile(
            leadingText: m.unit.toString(),
            title: m.title!,
          ),
        ),
      ];
    case Section.micro:
      return [
        ...articles[1].map(
          (m) => CustomSubTile(
            leadingText: m.unit.toString(),
            title: m.title!,
          ),
        ),
      ];
    case Section.macro:
      return [
        ...articles[2].map(
          (m) => CustomSubTile(
            leadingText: m.unit.toString(),
            title: m.title!,
          ),
        ),
      ];
    case Section.global:
      return [
        ...articles[3].map(
          (m) => CustomSubTile(
            leadingText: m.unit.toString(),
            title: m.title!,
          ),
        ),
      ];
  }
}
