import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/custom_widgets/loading_error/custom_error_widget.dart';
import '../../../app/custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../../app/custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';
import '../../quizzes/quiz_helper_methods/quiz_firebase_methods.dart';
import '../../quizzes/quiz_models/question_model.dart';
import '../articles_custom_widgets/custom_subtile.dart';
import '../articles_enums/sections.dart';
import '../articles_models/article_model.dart';
import '../articles_helper_methods/firebase_methods.dart';

class SectionsPage extends  ConsumerStatefulWidget {
  const SectionsPage({super.key});

  @override
   ConsumerState<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends ConsumerState<SectionsPage> {
  final List<ExpansionTileController> _expansionControllers = [];
  late final Future<List<ArticleModel>?> _articlesFuture;
  late final Future<List<QuestionModel>?> _questionsFuture;

  @override
  void initState() {
    _articlesFuture = getArticleDataFromFirebase();
    _questionsFuture = getQuestionDataFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizNotifier = ref.read(quizProvider.notifier);
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.defaultAppColorDarker,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              CustomButtonOverlayAppBar(
                  title: 'Study notes',
                  expansionControllers: _expansionControllers)
            ],
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
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: Section.values.map((section) {
                      return ExpansionTile(
                          leading: Icon(getSectionIcon(section)),
                          title: Text(section.getSectionName()),
                          children: [
                            if (section == Section.intro)
                              ...introArticles.map((article) {
                                return CustomSubTile(
                                  article,
                                  removeDivider: true,
                                );
                              }).toList(),
                            if (section == Section.micro)
                              ...microArticles
                                  .map((article) => CustomSubTile(
                                        article,
                                        removeDivider:
                                            article == microArticles.last,

                                      ))
                                  .toList(),
                            if (section == Section.macro)
                              ...macroArticles
                                  .map((article) => CustomSubTile(article,
                                      removeDivider:
                                          article == macroArticles.last))
                                  .toList(),
                            if (section == Section.global)
                              ...globalArticles
                                  .map((article) => CustomSubTile(article,
                                      removeDivider:
                                          article == globalArticles.last))
                                  .toList(),
                          ]);
                    }).toList()),
              );
            }
          }
          return const CustomProgressIndicator();
        },
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
