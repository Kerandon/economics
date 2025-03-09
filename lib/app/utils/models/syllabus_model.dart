import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:equatable/equatable.dart';
import '../../enums/syllabus_enum.dart';

class SyllabusModel with EquatableMixin {
  final Syllabus? syllabus;

  final List<UnitModel> units;

  SyllabusModel({required this.syllabus, required this.units});

  // copyWith method
  SyllabusModel copyWith({Syllabus? syllabus, List<UnitModel>? units}) {
    return SyllabusModel(
      syllabus: syllabus ?? this.syllabus,
      units: units ?? this.units,
    );
  }

  @override
  List<Object?> get props => [syllabus];
}
