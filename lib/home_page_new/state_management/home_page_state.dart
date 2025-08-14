
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../diagrams/enums/unit_type.dart';


class HomePageState {
  final UnitType selectedUnit;
  final Subunit? selectedSubunit;  // allow null initially or default to first subunit

  HomePageState({
    required this.selectedUnit,
    this.selectedSubunit,
  });

  HomePageState copyWith({
    UnitType? selectedUnit,
    Subunit? selectedSubunit,
  }) {
    return HomePageState(
      selectedUnit: selectedUnit ?? this.selectedUnit,
      selectedSubunit: selectedSubunit ?? this.selectedSubunit,
    );
  }
}

class EditHomePageNotifier extends StateNotifier<HomePageState> {
  EditHomePageNotifier(super._state);

  void setUnit(UnitType unit) {
    // When unit changes, optionally reset selectedSubunit to first subunit of new unit
    final firstSubunit = unit.subunits.isNotEmpty ? unit.subunits.first : null;
    state = state.copyWith(
      selectedUnit: unit,
      selectedSubunit: firstSubunit,
    );
  }

  void setSubunit(Subunit subunit) {
    // Only allow subunit if it belongs to the current selected unit
    if (subunit.unit == state.selectedUnit) {
      state = state.copyWith(selectedSubunit: subunit);
    }
  }
}

final homePageProvider =
StateNotifierProvider<EditHomePageNotifier, HomePageState>(
      (ref) => EditHomePageNotifier(
    HomePageState(
      selectedUnit: UnitType.intro,
      selectedSubunit: UnitType.intro.subunits.first,
    ),
  ),
);
