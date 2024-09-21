import 'package:economics_app/app/enums/ib_section.dart';
import 'package:economics_app/app/enums/ig_units.dart';
import 'package:flutter/material.dart';

import '../../../../app/utils/mixins/section_mixin.dart';

List<DropdownMenuItem<dynamic>> createUnitsDropdownMenuItems(SectionMixin s) {
  print('section is ${s.name}');
  List<DropdownMenuItem> units = [];
  if(s == IBSection.all || s == IGSection.all){
    return [];
  }else {
    for (var u in s.units) {
      units.add(
        DropdownMenuItem(
          value: u,
          child: Row(
            children: [
              Text(u.id),
              const SizedBox(width: 8,),
              Text(u.unit),
            ],
          ),
        ),
      );
    }
    return units;
  }
}