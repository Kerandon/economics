import 'package:flutter/material.dart';

BoxShadow buildBoxShadow(BuildContext context) {
  return BoxShadow(
    offset: Offset(1, 2),
    blurRadius: 5,
    color: Theme.of(context).colorScheme.shadow,
  );
}
