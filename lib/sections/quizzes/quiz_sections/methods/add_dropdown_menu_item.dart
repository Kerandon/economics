import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:flutter/material.dart';

DropdownMenuItem<dynamic> addDropdownMenuItem(UnitMixin s) {
  return DropdownMenuItem(
    value: s,
    child: Row(
      children: [
        if (s.id != null && s.id!.isNotEmpty) ...[
          Text(s.id!),
          const SizedBox(width: 8),
        ],
        Text(s.name),
      ],
    ),
  );
}
