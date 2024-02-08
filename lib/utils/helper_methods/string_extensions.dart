extension CapitalizeFirstLetterExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }


}
extension ListToMapExtension<T> on List<T> {
  Map<String, T> toMap() {
    return { for (var item in this) indexOf(item).toString() : item };
  }
}
