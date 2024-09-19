class UnitModel {
  final String id;
  final String unit;
  final bool hlOnly;

  UnitModel({
    required this.id,
    required this.unit,
    this.hlOnly = false,
  });

  // Add the fromMap method to create a UnitModel from a Map
  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'],
      unit: map['unit'],
      hlOnly: map['hlOnly'] ?? false, // Default to false if not provided
    );
  }

  // Add the toMap method to convert UnitModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit,
      'hlOnly': hlOnly,
    };
  }
}
