import 'package:economics_app/app/utils/mixins/unit_mixin.dart';

mixin CourseMixin {
  String get name;

  List<UnitMixin> get units;
}