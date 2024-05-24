import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../sections/articles/articles_models/article_model.dart';

class AppState {
  final bool isDarkTheme;
  final int page;
  final ArticleModel selectedArticle;

  AppState(
      {required this.isDarkTheme,
      required this.page,
      required this.selectedArticle});

  AppState copyWith(
      {bool? isDarkTheme, int? page, ArticleModel? selectedArticle}) {
    return AppState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      page: page ?? this.page,
      selectedArticle: selectedArticle ?? this.selectedArticle,
    );
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(super.state);

  void setDarkTheme(bool isDark) {
    state = state.copyWith(isDarkTheme: isDark);
  }

  void setPage(int page) {
    state = state.copyWith(page: page);
  }

  void setSelectedArticle(ArticleModel article) {
    state = state.copyWith(selectedArticle: article);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(
    AppState(
      isDarkTheme: true,
      page: 0,
      selectedArticle: ArticleModel(),
    ),
  ),
);
