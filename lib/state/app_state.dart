import 'package:economics_app/models/topic_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/enums/parent_enum.dart';

class AppState {
  final List<TopicModel> mainTopics;
  List<TopicModel> subtopics;
  List<TopicModel> articles;

  AppState({
    required this.mainTopics,
    required this.subtopics,
    required this.articles,
  });

  AppState copyWith(
      {List<TopicModel>? mainTopics,
      List<TopicModel>? subtopics,
      List<TopicModel>? articles,
      String? subtopicSelected}) {
    return AppState(
        mainTopics: mainTopics ?? this.mainTopics,
        subtopics: subtopics ?? this.subtopics,
        articles: articles ?? this.articles);
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(state) : super(state);

  void setTopicData(List<TopicModel> data, TopicCategory category) {
    switch (category) {
      case TopicCategory.mainTopic:
        state = state.copyWith(mainTopics: data);
      case TopicCategory.subtopic:
        state = state.copyWith(subtopics: data);
      case TopicCategory.article:
        state = state.copyWith(articles: data);
    }
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(
    AppState(mainTopics: [], subtopics: [], articles: []),
  ),
);
