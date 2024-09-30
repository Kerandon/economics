import 'package:economics_app/app/enums/ib_section.dart';
import 'package:economics_app/app/enums/ig_units.dart';
import 'package:flutter/material.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';

List<DropdownMenuItem<dynamic>> createUnitsDropdownMenuItems(UnitMixin s) {

  List<DropdownMenuItem> units = [];
  if(s == IBSection.all || s == IGSection.all){
    return [];
  }else {
    for (var u in s.subUnits.skip(1)) {
      units.add(
        DropdownMenuItem(
          value: u,
          child: Row(
            children: [
              if (u.id != null) Text(u.id!),
              if (u.id != null) const SizedBox(width: 8),
              Text(u.unit),
            ],
          )
        ),
      );
    }
    return units;
  }
}