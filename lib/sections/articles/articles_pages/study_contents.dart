import 'dart:typed_data';

import 'package:economics_app/app/state/app_state.dart';
import 'package:economics_app/sections/articles/articles_models/article_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/app_colors.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../diagrams/custom_paint/custom_paint_diagrams.dart';
import '../../quizzes/quiz_widgets/quiz_page_for_notes.dart';

class ContentsPage extends ConsumerStatefulWidget {
  const ContentsPage({super.key});

  @override
  ConsumerState<ContentsPage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ContentsPage> {
  final List<ExpansionTileController> _expansionControllers = [];
  List<QuestionModel> selectedQuestions = [];
  ArticleModel article = ArticleModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingWidth = size.width * 0.01;
    final paddingHeight = size.height * 0.02;
    final appState = ref.watch(appProvider);
    article = appState.selectedArticle;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study notes'),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: TextButton(onPressed: () {  }, child: Text('Expand'),),
            ),
            // SliverAppBar(
            //   backgroundColor: AppColors.defaultAppColorDarker,
            //   automaticallyImplyLeading: false,
            //   pinned: false,
            //   floating: true,
            //   forceElevated: innerBoxIsScrolled,
            // ),
          ];
        },
        body: SingleChildScrollView(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                leading: const Icon(Icons.school_outlined),
                title: const Text('Study notes'),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: paddingHeight,
                      horizontal: paddingWidth,
                    ),
                    child: ArticleContent(article: article),
                  ),
                ],
              ),
              QuizPageForNotes(article),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleContent extends StatefulWidget {
  const ArticleContent({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late final Future<Uint8List?> _imageFuture;

  @override
  void initState() {
    _imageFuture = getImage('aggregate_demand');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<Uint8List?>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HtmlWidget(
              widget.article.body!,
              customWidgetBuilder: (element) {
                return SizedBox(
                  height: size.width,
                  width: size.width,
                  child: const CustomPaintDiagrams(),
                );
              },
            );
          }
          return Container(
            height: 200,
            width: 200,
            color: Colors.red,
          );
        });
  }
}

Future<Uint8List?> getImage(String path) async {
  try {
    final instance = FirebaseStorage.instance;
    return await instance.ref('$path.png').getData();
  } catch (error) {
    return null;
  }
}
