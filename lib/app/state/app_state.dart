import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final bool isDarkTheme;
  final int page;

  AppState({required this.isDarkTheme, required this.page});

  AppState copyWith({bool? isDarkTheme, int? page}) {
    return AppState(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme, page: page ?? this.page);
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(state) : super(state);

  void setDarkTheme(bool isDark) {
    state = state.copyWith(isDarkTheme: isDark);
  }

  void setPage(int page) {
    state = state.copyWith(page: page);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(
    AppState(
      isDarkTheme: true,
      page: 0,
    ),
  ),
);
