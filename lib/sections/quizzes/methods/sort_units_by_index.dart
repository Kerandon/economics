import '../../../app/utils/models/unit_model.dart';

void sortUnitsByIndex(List<UnitModel> units, {bool descending = false}) {
  units.sort((a, b) {
    int aIndex = int.tryParse(a.index ?? '0') ?? 0;
    int bIndex = int.tryParse(b.index ?? '0') ?? 0;
    return descending ? bIndex.compareTo(aIndex) : aIndex.compareTo(bIndex);
  });
}
