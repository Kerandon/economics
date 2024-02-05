// import 'package:economics_app/models/topic_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../utils/enums/parent_enum.dart';
//
// class ContentState {
//   final List<TopicModel> sections;
//   List<TopicModel> subtopics;
//   List<TopicModel> articles;
//
//   ContentState({
//     required this.sections,
//     required this.subtopics,
//     required this.articles,
//   });
//
//   ContentState copyWith(
//       {List<TopicModel>? sections,
//       List<TopicModel>? subtopics,
//       List<TopicModel>? articles,
//       String? subtopicSelected}) {
//     return ContentState(
//         sections: sections ?? this.sections,
//         subtopics: subtopics ?? this.subtopics,
//         articles: articles ?? this.articles);
//   }
// }
//
// class ContentNotifier extends StateNotifier<ContentState> {
//   ContentNotifier(state) : super(state);
//
//   void setTopicData(List<TopicModel> data, TopicCategory category) {
//     switch (category) {
//       case TopicCategory.mainTopic:
//         state = state.copyWith(sections: data);
//       case TopicCategory.subtopic:
//         state = state.copyWith(subtopics: data);
//       case TopicCategory.article:
//         state = state.copyWith(articles: data);
//     }
//   }
// }
//
// final contentProvider = StateNotifierProvider<ContentNotifier, ContentState>(
//   (ref) => ContentNotifier(
//     ContentState(sections: [], subtopics: [], articles: []),
//   ),
// );
