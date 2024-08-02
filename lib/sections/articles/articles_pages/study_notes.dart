import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/loading_error/custom_error_widget.dart';
import '../../../app/custom_widgets/loading_error/custom_progress_indicator.dart';
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

  bool allTilesCollapsed = true;
  @override
  void initState() {
    _articlesFuture = getArticleDataFromFirebase();
    _questionsFuture = getQuestionDataFromFirebase();

    for (int i = 0; i < 4; i++) {
      _expandableControllers.add(ExpandableController());
      _expandableControllers[i].addListener((){
        print('listening');
        if(_expandableControllers.any((c) => c.expanded)){
          allTilesCollapsed = false;
        }else{
          allTilesCollapsed = true;
        }
        setState(() {

        });
      });

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizNotifier = ref.read(quizProvider.notifier);


   print(allTilesCollapsed);
    return ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Colors.blue,
        useInkWell: true,
      ),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Row(
                children: [
                Text('Study notes'),
                  IconButton(onPressed: (){
                    if(_expandableControllers.any((c) => c.expanded)){
                      for(var c in _expandableControllers){
                        if(c.expanded){
                          c.toggle();

                        }
                      }
                    }else if(_expandableControllers.every((c) => !c.expanded)){
                      for(var c in _expandableControllers){

                          c.toggle();


                      }
                    }

                  }, icon: Icon(allTilesCollapsed ? Icons.expand : Icons.close_fullscreen_outlined)),
                ],
              ),
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

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: Section.values.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final section = Section.values[index];
                          return ExpandableNotifier(
                            controller: _expandableControllers[index],
                            child: ExpandablePanel(
                              header: ListTile(
                                title: Text(section.getSectionName()),
                              ),
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                              ),
                              controller: _expandableControllers[index],
                              collapsed: SizedBox.shrink(),
                              expanded: Column(
                                children: [
                                  Container(
                                    width: size.width,
                                    child: const Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                    ),
                                  ),
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(
                                        crossFadePoint: 0),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }
            return const CustomProgressIndicator();
          },
        ),
      ),
    );
  }

  IconData getSectionIcon(Section section) {
    IconData icon;
    switch (section) {
      case Section.intro:
        icon = FontAwesomeIcons.bookOpenReader;
      case Section.micro:
        icon = FontAwesomeIcons.cartShopping;
      case Section.macro:
        icon = FontAwesomeIcons.chartLine;
      case Section.global:
        icon = FontAwesomeIcons.globe;
    }
    return icon;
  }
}
