import 'package:economics_app/app/enums/ib_section.dart';
import 'package:economics_app/app/enums/ig_units.dart';
import 'package:flutter/material.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import 'add_dropdown_menu_item.dart';

List<DropdownMenuItem<dynamic>> createSubUnitsDropdown(UnitMixin section) {
  List<DropdownMenuItem> units = [];
  if (section == IBSection.all || section == IGSection.all) {
    return [];
  } else {
    for (var u in section.subunits) {
      units.add(addDropdownMenuItem(u));
    }
    return units;
  }
}
