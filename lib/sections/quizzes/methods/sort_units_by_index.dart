import '../../../app/utils/models/unit.dart';

void sortUnitsByIndex(List<Unit> units, {bool descending = false}) {
  units.sort((a, b) {
    int aIndex = int.tryParse(a.index ?? '0') ?? 0;
    int bIndex = int.tryParse(b.index ?? '0') ?? 0;
    return descending ? bIndex.compareTo(aIndex) : aIndex.compareTo(bIndex);
  });
}
