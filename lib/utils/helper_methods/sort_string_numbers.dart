int sortStringNumbers(String? a, String? b) {
  List<String> partsA = a?.split('.') ?? ["0"];
  List<String> partsB = b?.split('.') ?? ["0"];

  int intPartA = int.parse(partsA[0]);
  int intPartB = int.parse(partsB[0]);

  int decimalPartA = int.parse(partsA.length > 1 ? partsA[1] : "0");
  int decimalPartB = int.parse(partsB.length > 1 ? partsB[1] : "0");

  if (intPartA == intPartB) {
    return decimalPartA.compareTo(decimalPartB);
  } else {
    return intPartA.compareTo(intPartB);
  }
}
