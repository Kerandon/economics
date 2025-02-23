import '../../../app/utils/models/unit_model.dart';
void sortUnitsByIndex(List<UnitModel> units, {bool descending = false}) {
  units.sort((a, b) {
    double aIndex = double.tryParse(a.index ?? '0') ?? 0;
    double bIndex = double.tryParse(b.index ?? '0') ?? 0;
    return descending ? bIndex.compareTo(aIndex) : aIndex.compareTo(bIndex);
  });
}
