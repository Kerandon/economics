import 'package:economics_app/app/enums/font_size.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final bool isDarkTheme;
  final int page;
  final FontSize fontSize;

  AppState({
    required this.isDarkTheme,
    required this.page,
    required this.fontSize,
  });

  AppState copyWith({
    bool? isDarkTheme,
    int? page,
    FontSize? fontSize,
  }) {
    return AppState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      page: page ?? this.page,
      fontSize: fontSize ?? this.fontSize,
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

  void setFontSize() {
    final values = FontSize.values;
    final currentIndex = values.indexOf(state.fontSize);
    final nextIndex = (currentIndex + 1) % values.length;
    state = state.copyWith(fontSize: values[nextIndex]);
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
    fontSize: FontSize.medium, // Default font size
  )),
);
