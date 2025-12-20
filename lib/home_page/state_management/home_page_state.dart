import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../diagrams/enums/unit_type.dart';
import '../../diagrams/models/diagram_widget.dart';

class HomePageState {
  final UnitType? selectedUnit;
  final Subunit? selectedSubunit;
  final Subunit? selectedDiagramSubunit;
  final String? selectedDiagramId;

  HomePageState({
    this.selectedUnit,
    this.selectedSubunit,
    this.selectedDiagramSubunit,
    this.selectedDiagramId,
  });

  HomePageState copyWith({
    UnitType? selectedUnit,
    Subunit? selectedSubunit,
    Subunit? selectedDiagramSubunit,
    String? selectedDiagramID,
  }) {
    return HomePageState(
      selectedUnit: selectedUnit ?? this.selectedUnit,
      selectedSubunit: selectedSubunit ?? this.selectedSubunit,
      selectedDiagramSubunit:
          selectedDiagramSubunit ?? this.selectedDiagramSubunit,
      selectedDiagramId: selectedDiagramID ?? this.selectedDiagramId,
    );
  }
}

class HomePageNotifier extends StateNotifier<HomePageState> {
  HomePageNotifier(super._state);

  void setUnit(UnitType unit) {
    // When unit changes, optionally reset selectedSubunit to first subunit of new unit
    final firstSubunit = unit.subunits.isNotEmpty ? unit.subunits.first : null;
    state = state.copyWith(selectedUnit: unit, selectedSubunit: firstSubunit);
  }

  void setSubunit(Subunit subunit) {
    // Only allow subunit if it belongs to the current selected unit
    if (subunit.unit == state.selectedUnit) {
      state = state.copyWith(selectedSubunit: subunit);
    }
  }

  void setDiagramSubunit(Subunit subunit) {
    state = state.copyWith(selectedDiagramSubunit: subunit);
  }

  void setSelectedDiagramId(String id) {
    state = state.copyWith(selectedDiagramID: id);
  }
}

final homePageProvider = StateNotifierProvider<HomePageNotifier, HomePageState>(
  (ref) => HomePageNotifier(
    HomePageState(
      selectedUnit: UnitType.intro,
      selectedSubunit: UnitType.intro.subunits.first,
      selectedDiagramSubunit: Subunit.whatIsEconomics,
      selectedDiagramId: '',
    ),
  ),
);
