import 'package:flutter/material.dart';

import 'get_box_shadow.dart';
import '../../../app/configs/constants.dart';

BoxDecoration getTileDecoration(BuildContext context,
    {bool surfaceTint = false}) {
  final theme = Theme.of(context);

  return BoxDecoration(
    color:
        surfaceTint ? theme.colorScheme.surfaceTint : theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(kRadius),
    border: Border.all(
      color: theme.colorScheme.scrim,
    ),
    boxShadow: [buildBoxShadow(context)],
  );
}
