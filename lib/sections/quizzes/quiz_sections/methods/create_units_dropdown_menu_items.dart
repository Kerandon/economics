import 'package:flutter/material.dart';

import '../../../../app/utils/mixins/section_mixin.dart';

List<DropdownMenuItem<dynamic>> createUnitsDropdownMenuItems(SectionMixin s) {
  List<DropdownMenuItem> units = [];
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