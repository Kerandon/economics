import 'package:economics_app/models/topic_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final List<TopicModel> contents;

  AppState({required this.contents});

  AppState copyWith(List<TopicModel> contents) {
    return AppState(contents: contents);
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(state) : super(state);

  void setContents(List<TopicModel> contents) {
    state = state.copyWith(contents);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(
    AppState(
      contents: [],
    ),
  ),
);
