// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../enums/diagram_type.dart';
//
// class DiagramsState {
//   final List<DiagramType> selectedDiagrams;
//
//   DiagramsState({required this.selectedDiagrams});
//
//   DiagramsState copyWith({List<DiagramType>? selectedDiagrams}) {
//     return DiagramsState(
//         selectedDiagrams: selectedDiagrams ?? this.selectedDiagrams);
//   }
// }
//
// class DiagramsNotifier extends StateNotifier<DiagramsState> {
//   DiagramsNotifier(super.state);
//
//   void setDiagramSelected(DiagramType diagram, int index) {
//     List<DiagramType> diagrams = state.selectedDiagrams.toList();
//     diagrams.replaceRange(index, index, [diagram]);
//     state = state.copyWith(selectedDiagrams: diagrams);
//   }
// }
//
// final diagramsProvider = StateNotifierProvider<DiagramsNotifier, DiagramsState>(
//   (ref) => DiagramsNotifier(
//     DiagramsState(
//         // section: Section.global,
//         selectedDiagrams: [
//           DiagramType.global_ExportSubsidies_Calculation,
//           DiagramType.global_ExportSubsidies_Calculation,
//           DiagramType.macro_BusinessCycle_Default,
//           DiagramType.global_Tariffs_Standard_Default,
//         ]),
//   ),
// );
