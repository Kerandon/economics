import 'package:economics_app/sections/notes/models/unit_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState {
  final bool isDarkTheme;
  final int page;
  final UnitModel selectedUnit;

  AppState({
    required this.isDarkTheme,
    required this.page,
    required this.selectedUnit,
  });

  AppState copyWith(
      {bool? isDarkTheme,
      int? page,
      UnitModel? selectedUnit,
      Map<int, bool>? showExpanded}) {
    return AppState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      page: page ?? this.page,
      selectedUnit: selectedUnit ?? this.selectedUnit,
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

  void setSelectedUnit(UnitModel unit) {
    state = state.copyWith(selectedUnit: unit);
  }

  /// Triggers a rebuild of the widget tree (used for expanded icon to update)

  void toggleToRebuildWidgetTree() {
    state = state.copyWith();
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(AppState(
    isDarkTheme: true,
    page: 0,
    selectedUnit: UnitModel(id: '', unit: ''),
  )),
);
