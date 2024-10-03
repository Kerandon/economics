import 'package:economics_app/app/utils/mixins/unit_mixin.dart';

class Unit with UnitMixin {
  @override
  final String? id;

  @override
  final String name;

  @override
  final int? numberOfQuestions;

  @override
  final List<UnitMixin> subunits;

  Unit({
    this.id,
    required this.name,
    this.numberOfQuestions,
    this.subunits = const [],
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'name': name,
      'subunits': subunits.isNotEmpty ? subunits : null,
    };

    // Remove null key-value pairs
    map.removeWhere((key, value) => value == null);

    return map;
  }
}
