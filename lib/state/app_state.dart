import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final bool isDarkTheme;

  AppState({required this.isDarkTheme});

  AppState copyWith({bool? isDarkTheme}) {
    return AppState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(state) : super(state);

  void setDarkTheme(bool isDark) {
    state = state.copyWith(isDarkTheme: isDark);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(
    AppState(isDarkTheme: true),
  ),
);
