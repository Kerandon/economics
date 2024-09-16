import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final bool isDarkTheme;
  final int page;

  AppState({
    required this.isDarkTheme,
    required this.page,
  });

  AppState copyWith(
      {bool? isDarkTheme, int? page, Map<int, bool>? showExpanded}) {
    return AppState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      page: page ?? this.page,
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

  /// Triggers a rebuild of the widget tree (used for expanded icon to update)

  void toggleToRebuildWidgetTree() {
    state = state.copyWith();
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(AppState(
    isDarkTheme: false,
    page: 0,
  )),
);
